import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/data/models/products_by_categories_model.dart';
import 'package:al_omda/features/products/data/models/products_top_rated_model.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final BaseProductsRepository baseProductsRepository;
  ProductsCubit(this.baseProductsRepository) : super(ProductsState());
  Future<void> getMostRecentProducts() async {
    if (isClosed) return;

    emit(state.copyWith(productsState: RequestState.loading));

    final result = await baseProductsRepository.getMostRecentProducts();

    if (isClosed) return; // ✅ التحقق بعد الانتهاء من الطلبية

    result.fold(
      (failure) {
        if (isClosed) return; // ✅ التحقق قبل emit
        emit(
          state.copyWith(
            productsState: RequestState.error,
            productsMessage: failure,
          ),
        );
      },
      (products) {
        if (isClosed) return; // ✅ التحقق قبل emit
        emit(
          state.copyWith(
            productsState: RequestState.loaded,
            products: products,
          ),
        );
      },
    );
  }

  Future<void> getHomeProductsTopRated() async {
    emit(state.copyWith(productsTopRatedState: RequestState.loading));

    final result = await baseProductsRepository.getHomeProductsTopRated();

    result.fold(
      (failure) => emit(
        state.copyWith(
          productsTopRatedState: RequestState.error,
          productsTopRatedMessage: 'failure.message',
        ),
      ),
      (productsTopRated) => emit(
        state.copyWith(
          productsTopRated: productsTopRated,
          productsTopRatedState: RequestState.loaded,
        ),
      ),
    );
  }

  Future<void> getProductsByCategories(String categoryName) async {
    if (isClosed) return; // ✅ التحقق الأولي

    emit(state.copyWith(productsByCategoryState: RequestState.loading));

    final result = await baseProductsRepository.getProductsByCategories(
      categoryName,
    );

    if (isClosed) return; // ✅ التحقق بعد الانتهاء من الطلبية

    result.fold(
      (failure) {
        if (isClosed) return; // ✅ التحقق قبل emit
        emit(
          state.copyWith(
            productsByCategoryState: RequestState.error,
            productsByCategoryMessage: failure,
          ),
        );
      },
      (products) {
        if (isClosed) return; // ✅ التحقق قبل emit
        emit(
          state.copyWith(
            productsByCategoryState: RequestState.loaded,
            productsByCategory: products,
          ),
        );
      },
    );
  }
}

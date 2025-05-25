import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/products/data/models/most_resent_products_model.dart';
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
}

import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/categories/data/models/categories_model.dart';
import 'package:al_omda/features/categories/data/models/products_by_categories_model.dart';
import 'package:al_omda/features/categories/domain/repository/base_categories_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final BaseCategoriesRepository baseCategoriesRepository;
  CategoriesCubit(this.baseCategoriesRepository) : super(CategoriesState());
  Future<void> getCategories() async {
    if (isClosed) return; // ✅ التحقق الأولي

    emit(state.copyWith(categoriesState: RequestState.loading));

    final result = await baseCategoriesRepository.getCategories();

    if (isClosed) return; // ✅ التحقق بعد الانتهاء من الطلبية

    result.fold(
      (failure) {
        if (isClosed) return; // ✅ التحقق قبل emit
        emit(
          state.copyWith(
            categoriesState: RequestState.error,
            categoriesMessage: failure,
          ),
        );
      },
      (categories) {
        if (isClosed) return; // ✅ التحقق قبل emit
        emit(
          state.copyWith(
            categoriesState: RequestState.loaded,
            categories: categories,
          ),
        );
      },
    );
  }
  // Future<void> getCategories() async {
  //   emit(state.copyWith(categoriesState: RequestState.loading));

  //   final result = await baseCategoriesRepository.getCategories();

  //   result.fold(
  //     (failure) => emit(
  //       state.copyWith(
  //         categoriesState: RequestState.error,
  //         categoriesMessage: 'failure.message',
  //       ),
  //     ),
  //     (categories) => emit(
  //       state.copyWith(
  //         categories: categories,
  //         categoriesState: RequestState.loaded,
  //       ),
  //     ),
  //   );
  // }

  // Future<void> getProductsByCategories(String categoryName) async {
  //   emit(state.copyWith(productsByCategoryState: RequestState.loading));

  //   final result = await baseCategoriesRepository.getProductsByCategories(
  //     categoryName,
  //   );

  //   result.fold(
  //     (failure) {
  //       emit(
  //         state.copyWith(
  //           productsByCategoryState: RequestState.error,
  //           productsByCategoryMessage: failure,
  //         ),
  //       );
  //     },
  //     (products) {
  //       emit(
  //         state.copyWith(
  //           productsByCategoryState: RequestState.loaded,
  //           productsByCategory: products,
  //         ),
  //       );
  //     },
  //   );
  // }
  Future<void> getProductsByCategories(String categoryName) async {
    if (isClosed) return; // ✅ التحقق الأولي

    emit(state.copyWith(productsByCategoryState: RequestState.loading));

    final result = await baseCategoriesRepository.getProductsByCategories(
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

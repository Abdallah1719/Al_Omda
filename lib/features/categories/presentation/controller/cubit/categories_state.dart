part of 'categories_cubit.dart';

class CategoriesState extends Equatable {
  final List<CategoriesModel> categories;
  final RequestState categoriesState;
  final String categoriesMessage;

  final RequestState productsByCategoryState;
  final String productsByCategoryMessage;
  final List<ProductsByCategoriesModel> productsByCategory;

  const CategoriesState({
    this.categories = const [],
    this.categoriesState = RequestState.loading,
    this.categoriesMessage = '',
    this.productsByCategoryState = RequestState.loading,
    this.productsByCategoryMessage = '',
    this.productsByCategory = const [],
  });

  CategoriesState copyWith({
    List<CategoriesModel>? categories,
    RequestState? categoriesState,
    String? categoriesMessage,
    RequestState? productsByCategoryState,
    String? productsByCategoryMessage,
    List<ProductsByCategoriesModel>? productsByCategory,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      categoriesState: categoriesState ?? this.categoriesState,
      categoriesMessage: categoriesMessage ?? this.categoriesMessage,
      productsByCategoryState:
          productsByCategoryState ?? this.productsByCategoryState,
      productsByCategoryMessage:
          productsByCategoryMessage ?? this.productsByCategoryMessage,
      productsByCategory: productsByCategory ?? this.productsByCategory,
    );
  }

  @override
  List<Object?> get props => [
    categories,
    categoriesState,
    categoriesMessage,
    productsByCategoryState,
    productsByCategoryMessage,
    productsByCategory,
  ];
}

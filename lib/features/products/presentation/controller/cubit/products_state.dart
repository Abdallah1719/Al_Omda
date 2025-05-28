part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final RequestState productsState;
  final String productsMessage;
  final List<ProductsModel> products;
  final List<ProductsModel> productsTopRated;
  final RequestState productsTopRatedState;
  final String productsTopRatedMessage;

  final RequestState productsByCategoryState;
  final String productsByCategoryMessage;
  final List<ProductsModel> productsByCategory;

  const ProductsState({
    this.productsState = RequestState.loading,
    this.productsMessage = '',
    this.products = const [],
    this.productsTopRated = const [],
    this.productsTopRatedState = RequestState.loading,
    this.productsTopRatedMessage = '',
    this.productsByCategoryState = RequestState.loading,
    this.productsByCategoryMessage = '',
    this.productsByCategory = const [],
  });

  ProductsState copyWith({
    RequestState? productsState,
    String? productsMessage,
    List<ProductsModel>? products,
    List<ProductsModel>? productsTopRated,
    RequestState? productsTopRatedState,
    String? productsTopRatedMessage,
    RequestState? productsByCategoryState,
    String? productsByCategoryMessage,
    List<ProductsModel>? productsByCategory,
  }) {
    return ProductsState(
      productsState: productsState ?? this.productsState,
      productsMessage: productsMessage ?? this.productsMessage,
      products: products ?? this.products,
      productsTopRated: productsTopRated ?? this.productsTopRated,
      productsTopRatedState:
          productsTopRatedState ?? this.productsTopRatedState,
      productsTopRatedMessage:
          productsTopRatedMessage ?? this.productsTopRatedMessage,
      productsByCategoryState:
          productsByCategoryState ?? this.productsByCategoryState,
      productsByCategoryMessage:
          productsByCategoryMessage ?? this.productsByCategoryMessage,
      productsByCategory: productsByCategory ?? this.productsByCategory,
    );
  }

  @override
  List<Object?> get props => [
    productsState,
    productsMessage,
    products,
    productsTopRated,
    productsTopRatedState,
    productsTopRatedMessage,
    productsByCategoryState,
    productsByCategoryMessage,
    productsByCategory,
  ];
}

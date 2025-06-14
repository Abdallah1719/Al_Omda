part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final RequestState allProductsState;
  final String allProductsMessage;
  final List<ProductModel> allProducts;
  final List<ProductModel> productsTopRated;
  final RequestState productsTopRatedState;
  final String productsTopRatedMessage;
  final RequestState productsByCategoryNameState;
  final String productsByCategoryNameMessage;
  final List<ProductModel> productsByCategoryName;

  const ProductsState({
    this.allProductsState = RequestState.loading,
    this.allProductsMessage = '',
    this.allProducts = const [],
    this.productsTopRated = const [],
    this.productsTopRatedState = RequestState.loading,
    this.productsTopRatedMessage = '',
    this.productsByCategoryNameState = RequestState.loading,
    this.productsByCategoryNameMessage = '',
    this.productsByCategoryName = const [],
  });

  ProductsState copyWith({
    RequestState? allProductsState,
    String? allProductsMessage,
    List<ProductModel>? allProducts,
    List<ProductModel>? productsTopRated,
    RequestState? productsTopRatedState,
    String? productsTopRatedMessage,
    RequestState? productsByCategoryNameState,
    String? productsByCategoryNameMessage,
    List<ProductModel>? productsByCategoryName,
  }) {
    return ProductsState(
      allProductsState: allProductsState ?? this.allProductsState,
      allProductsMessage: allProductsMessage ?? this.allProductsMessage,
      allProducts: allProducts ?? this.allProducts,
      productsTopRated: productsTopRated ?? this.productsTopRated,
      productsTopRatedState:
          productsTopRatedState ?? this.productsTopRatedState,
      productsTopRatedMessage:
          productsTopRatedMessage ?? this.productsTopRatedMessage,
      productsByCategoryNameState:
          productsByCategoryNameState ?? this.productsByCategoryNameState,
      productsByCategoryNameMessage:
          productsByCategoryNameMessage ?? this.productsByCategoryNameMessage,
      productsByCategoryName: productsByCategoryName ?? this.productsByCategoryName,
    );
  }

  @override
  List<Object?> get props => [
    allProductsState,
    allProductsMessage,
    allProducts,
    productsTopRated,
    productsTopRatedState,
    productsTopRatedMessage,
    productsByCategoryNameState,
    productsByCategoryNameMessage,
    productsByCategoryName,
  ];
}

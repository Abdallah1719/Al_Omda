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
  final RequestState productsInCartState;
  final String productsInCartMessage;
  final List<ProductModel> productsInCart;

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
    this.productsInCartState = RequestState.loaded,
    this.productsInCartMessage = '',
    this.productsInCart = const [],
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
    RequestState? productsInCartState,
    String? productsInCartMessage,
    List<ProductModel>? productsInCart,
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
      productsByCategoryName:
          productsByCategoryName ?? this.productsByCategoryName,
      productsInCartState: productsInCartState ?? this.productsInCartState,
      productsInCartMessage:
          productsInCartMessage ?? this.productsInCartMessage,
      productsInCart: productsInCart ?? this.productsInCart,
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
    productsInCartState,
    productsInCartMessage,
    productsInCart,
  ];
}

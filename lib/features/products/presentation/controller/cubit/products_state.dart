part of 'products_cubit.dart';

class ProductsState extends Equatable {
  final RequestState productsState;
  final String productsMessage;
  final List<MostRecentProductsModel> products;

  const ProductsState({
    this.productsState = RequestState.loading,
    this.productsMessage = '',
    this.products = const [],
  });

  ProductsState copyWith({
    RequestState? productsState,
    String? productsMessage,
    List<MostRecentProductsModel>? products,
  }) {
    return ProductsState(
      productsState: productsState ?? this.productsState,
      productsMessage: productsMessage ?? this.productsMessage,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [productsState, productsMessage, products];
}

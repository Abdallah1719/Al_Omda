import 'package:al_omda/core/utils/enum.dart';
import 'package:al_omda/features/products/data/models/products_model.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final BaseProductsRepository baseProductsRepository;
  ProductsCubit(this.baseProductsRepository) : super(ProductsState());
  Future<void> getAllProducts() async {
    emit(state.copyWith(allProductsState: RequestState.loading));
    final result = await baseProductsRepository.getAllProducts();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            allProductsState: RequestState.error,
            allProductsMessage: failure,
          ),
        );
      },
      (allProducts) {
        emit(
          state.copyWith(
            allProductsState: RequestState.loaded,
            allProducts: allProducts,
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
          productsTopRatedMessage: failure,
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
    emit(state.copyWith(productsByCategoryNameState: RequestState.loading));

    final result = await baseProductsRepository.getProductsByCategoryName(
      categoryName,
    );
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            productsByCategoryNameState: RequestState.error,
            productsByCategoryNameMessage: failure,
          ),
        );
      },
      (products) {
        emit(
          state.copyWith(
            productsByCategoryNameState: RequestState.loaded,
            productsByCategoryName: products,
          ),
        );
      },
    );
  }

  //    Future<void> addToCart(int productId, int newQuantity) async {
  //   emit(state.copyWith(productsInCartState: RequestState.loading));

  //   final result = await baseProductsRepository.addToCart(productId, newQuantity);

  //   result.fold(
  //     (failure) {
  //       emit(state.copyWith(
  //         productsInCartState: RequestState.error,
  //         productsInCartMessage: failure,
  //       ));
  //     },
  //     (updatedProductsInCart) {
  //       emit(state.copyWith(
  //         productsInCartState: RequestState.loaded,
  //         productsInCartMessage: 'Product added to cart successfully',
  //         productsInCart: updatedProductsInCart,
  //       ));
  //     },
  //   );
  // }
  Future<void> addToCart(int productId, int newQuantity) async {
    emit(state.copyWith(productsInCartState: RequestState.loading));

    final result = await baseProductsRepository.addProductToCart(
      productId,
      newQuantity,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            productsInCartState: RequestState.error,
            productsInCartMessage: failure,
          ),
        );
      },
      (updatedProductsInCart) {
        emit(
          state.copyWith(
            productsInCartState: RequestState.loaded,
            productsInCartMessage: 'Product added to cart successfully',
            productsInCart: updatedProductsInCart,
          ),
        );
      },
    );
  }

  // removeFromCart
  Future<void> removeFromCart(int productId) async {
    emit(state.copyWith(productsInCartState: RequestState.loading));

    final result = await baseProductsRepository.removeProductFromCart(
      productId,
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            productsInCartState: RequestState.error,
            productsInCartMessage: failure,
          ),
        );
      },
      (updatedCart) {
        emit(
          state.copyWith(
            productsInCartState: RequestState.loaded,
            productsInCartMessage: 'Product removed from cart successfully',
            productsInCart: updatedCart,
          ),
        );
      },
    );
  }
}

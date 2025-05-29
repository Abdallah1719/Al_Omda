
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';


class CartCubit extends Cubit<CartState> {
  final BaseCartRepository baseCartRepository;

  CartCubit(this.baseCartRepository) : super(CartInitial());

  Future<void> getCartItems() async {
    emit(CartLoading());
    final result = await baseCartRepository.getCartItems();
    result.fold(
      (failure) => emit(CartError(failure)),
      (items) => emit(CartLoaded(items)),
    );
  }

  Future<void> addToCart(int productId) async {
    final result = await baseCartRepository.addToCart(productId);
    result.fold(
      (failure) => emit(CartError(failure)),
      (updatedItems) => emit(CartLoaded(updatedItems)),
    );
  }

  Future<void> updateQuantity(int productId, int newQuantity) async {
    final result = await baseCartRepository.updateQuantity(productId, newQuantity);
    result.fold(
      (failure) => emit(CartError(failure)),
      (updatedItems) => emit(CartLoaded(updatedItems)),
    );
  }

  Future<void> removeFromCart(int productId) async {
    final result = await baseCartRepository.removeFromCart(productId);
    result.fold(
      (failure) => emit(CartError(failure)),
      (updatedItems) => emit(CartLoaded(updatedItems)),
    );
  }
}
import 'package:al_omda/features/cart/data/models/cart_model.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final List<CartItemModel> items;
  CartLoaded(this.items);
}

class CartError extends CartState {
  final String message;
  CartError(this.message);
}

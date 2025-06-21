// import 'package:al_omda/features/cart/data/models/cart_model.dart';

// abstract class CartState {}

// class CartInitial extends CartState {}

// class CartLoading extends CartState {}

// class CartLoaded extends CartState {
//   final List<CartItemModel> items;
//   CartLoaded(this.items);
// }

// class CartError extends CartState {
//   final String message;
//   CartError(this.message);
// }
// 4. presentation/controller/cubit/cart_state.dart
// =====================================
import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();
  
  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartModel cartModel;
  
  const CartLoaded(this.cartModel);
  
  @override
  List<Object> get props => [cartModel];
}

class CartError extends CartState {
  final String message;
  
  const CartError(this.message);
  
  @override
  List<Object> get props => [message];
}

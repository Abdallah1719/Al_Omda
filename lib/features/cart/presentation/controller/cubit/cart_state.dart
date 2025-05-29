// // part of 'cart_cubit.dart';

// // sealed class CartState extends Equatable {
// //   const CartState();

// //   @override
// //   List<Object> get props => [];
// // }

// // final class CartInitial extends CartState {}
// import 'package:al_omda/features/cart/domain/entities/cart.dart';
// import 'package:equatable/equatable.dart';

// abstract class CartState extends Equatable {}

// class CartInitial extends CartState {
//   @override
//   List<Object?> get props => [];
// }

// class CartLoading extends CartState {
//   @override
//   List<Object?> get props => [];
// }

// class CartLoaded extends CartState {
//   final List<CartItem> items;

//   CartLoaded(this.items);

//   @override
//   List<Object?> get props => [items];
// }

// class CartError extends CartState {
//   final String message;

//   CartError(this.message);

//   @override
//   List<Object?> get props => [message];
// }

import 'package:al_omda/features/cart/domain/entities/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {}

class CartInitial extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoading extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoaded extends CartState {
  final List<CartItem> items;

  CartLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class CartError extends CartState {
  final String message;

  CartError(this.message);

  @override
  List<Object?> get props => [message];
}

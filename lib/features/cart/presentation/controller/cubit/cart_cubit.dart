// import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';

// class CartCubit extends Cubit<CartState> {
//   final BaseCartRepository baseCartRepository;

//   CartCubit(this.baseCartRepository) : super(CartInitial());

//   Future<void> getCartItems() async {
//     emit(CartLoading());
//     final result = await baseCartRepository.getCartItems();
//     result.fold(
//       (failure) => emit(CartError(failure)),
//       (items) => emit(CartLoaded(items)),
//     );
//   }

//   Future<void> addToCart(int productId) async {
//     final result = await baseCartRepository.addToCart(productId);
//     result.fold(
//       (failure) => emit(CartError(failure)),
//       (updatedItems) => emit(CartLoaded(updatedItems)),
//     );
//   }

//   Future<void> updateQuantity(int productId, int newQuantity) async {
//     final result = await baseCartRepository.updateQuantity(productId, newQuantity);
//     result.fold(
//       (failure) => emit(CartError(failure)),
//       (updatedItems) => emit(CartLoaded(updatedItems)),
//     );
//   }

//   Future<void> removeFromCart(int productId) async {
//     final result = await baseCartRepository.removeFromCart(productId);
//     result.fold(
//       (failure) => emit(CartError(failure)),
//       (updatedItems) => emit(CartLoaded(updatedItems)),
//     );
//   }
// }

import 'package:al_omda/features/cart/domain/entities/cart.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';

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
    final currentState = state;

    if (currentState is CartLoaded) {
      // تعديل الكمية محليًا
      final List<CartItem> updatedItems =
          currentState.items.map((item) {
            if (item.productId == productId) {
              return item.copyWith(quantity: newQuantity);
            }
            return item;
          }).toList();

      emit(CartLoaded(updatedItems));

      // تحديث الـAPI
      final result = await baseCartRepository.updateQuantity(
        productId,
        newQuantity,
      );

      result.fold(
        (failure) {
          emit(currentState); // العودة للحالة السابقة في حال الفشل
          emit(CartError(failure));
        },
        (items) {
          // يمكنك هنا إعادة تحميل البيانات النهائية إذا أردت:
          // emit(CartLoaded(items));
        },
      );
    }
  }

  Future<void> removeFromCart(int productId) async {
    final currentState = state;

    if (currentState is CartLoaded) {
      final List<CartItem> updatedItems =
          currentState.items
              .where((item) => item.productId != productId)
              .toList();

      emit(CartLoaded(updatedItems)); // 👉 تحديث الواجهة فورًا

      final result = await baseCartRepository.removeFromCart(productId);

      result.fold(
        (failure) {
          emit(currentState); // ❌ العودة للحالة السابقة
          emit(CartError(failure));
        },
        (items) {
          // ✅ optional: emit(CartLoaded(items));
        },
      );
    }
  }
}

import 'package:al_omda/features/cart/domain/entities/cart.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

 

  Future<void> removeFromCart(int productId) async {
    final currentState = state;

    if (currentState is CartLoaded) {
      final List<CartItem> oldItems = currentState.items;

      // 1. تحديث محلي فوري
      final updatedItems =
          oldItems.where((item) => item.productId != productId).toList();
      emit(CartLoaded(updatedItems));

      try {
        // 2. إرسال طلب الحذف
        final serverItems = await baseCartRepository.removeFromCart(productId);

        // 3. استخدام البيانات المباشرة من السيرفر
        emit(CartLoaded(serverItems));
      } catch (e) {
        // 4. معالجة الأخطاء
        emit(CartLoaded(oldItems)); // استعادة الحالة القديمة
        emit(CartError(e.toString()));

        // 5. محاولة إعادة التحميل بعد 2 ثانية
        await Future.delayed(Duration(seconds: 2));
        await getCartItems();
      }
    }
  }
}

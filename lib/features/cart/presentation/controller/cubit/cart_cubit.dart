import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/cart/data/models/cart_items_model.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:al_omda/features/cart/data/models/cart_summary_model.dart';
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:al_omda/features/products/domain/repository/base_products_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  final BaseCartRepository baseCartRepository;
  CartCubit(this.baseCartRepository) : super(CartInitial());
  // get cart items
  Future<void> getCartItems() async {
    emit(CartLoading());
    final result = await baseCartRepository.getCartItems();
    result.fold(
      (failure) => emit(CartError(failure)),
      (cartModel) => emit(CartLoaded(cartModel)),
    );
  }

  //remove Product From Cart
  void removeProductFromCart(int productId) async {
    if (state is CartLoaded) {
      await getIt<BaseProductsRepository>().removeProductFromCart(productId);
      final currentCartModel = (state as CartLoaded).cartModel;
      final updatedItems = List<CartItemsModel>.from(currentCartModel.items);
      updatedItems.removeWhere((item) => item.productId == productId);
      final newTotal = updatedItems.fold<double>(
        0,
        (sum, item) => sum + item.total,
      );
      final newSummary = CartSummaryModel(
        total: newTotal,
        totalItems: updatedItems.length,
        discountValue: currentCartModel.summary.discountValue,
      );
      final newCartModel = CartModel(items: updatedItems, summary: newSummary);
      emit(CartLoaded(newCartModel));
    }
  }
}

import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCartRepository {
  Future<Either<String, List<CartItemModel>>> getCartItems();
  Future<Either<String, List<CartItemModel>>> addToCart(int productId ,  int newQuantity,);
  // Future<Either<String, List<CartItemModel>>> updateQuantity(
  //   int productId,
  //   int newQuantity,
  // );
  Future<List<CartItemModel>> removeFromCart(int productId);
  Future<Either<String, bool>> makeOrder({
    required String date,
    required String time,
    required int paymentId,
    required int addressId,
  });
}

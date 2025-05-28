import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCartRepository {
  Future<Either<String, List<CartItemModel>>> getCartItems();
  Future<Either<String, bool>> addToCart(int productId);
  Future<Either<String, bool>> updateQuantity(int productId, int newQuantity);
  Future<Either<String, bool>> removeFromCart(int productId);
}
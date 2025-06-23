import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseCartRepository {
  Future<Either<String, CartModel>> getCartItems();
}

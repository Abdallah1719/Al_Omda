import 'package:al_omda/features/cart/data/data_source/cart_remote_data_source.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:dartz/dartz.dart';

class CartRepository implements BaseCartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepository(this.cartRemoteDataSource);

  @override
  Future<Either<String, List<CartItemModel>>> getCartItems() async {
    try {
      final List<CartItemModel> items =
          await cartRemoteDataSource.getCartItemsFromApi();
      return Right(items);
    } catch (e) {
      return Left("فشل في جلب بيانات السلة");
    }
  }

  // @override
  // Future<Either<String, List<CartItemModel>>> addToCart(
  //   int productId,
  //   int newQuantity,
  // ) async {
  //   try {
  //     final List<CartItemModel> updatedCart = await cartRemoteDataSource
  //         .addProductToCart(productId, newQuantity);
  //     return Right(updatedCart);
  //   } catch (e) {
  //     return Left("فشل في إضافة المنتج للسلة");
  //   }
  // }

  @override
  Future<List<CartItemModel>> removeFromCart(int productId) async {
    try {
      final items = await cartRemoteDataSource.removeFromCart(productId);
      return items;
    } catch (e) {
      throw Exception("فشل في حذف المنتج من السلة");
    }
  }
}

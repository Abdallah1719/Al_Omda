import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:dartz/dartz.dart';

// class CartRepository implements BaseCartRepository {
//   final ApiMethods api;
//   CartRepository(this.api);

//   @override
//   Future<Either<String, List<CartItemModel>>> getCartItems() async {
//     try {
//       final response = await api.get(ApiConstances.cart);
//       final itemsList = response["data"]["items"] as List;
//       final List<CartItemModel> allProductsInCart =
//           itemsList
//               .map(
//                 (item) => CartItemModel.fromJson(item as Map<String, dynamic>),
//               )
//               .toList();
//       return Right(allProductsInCart);
//     } on ServerException catch (e) {
//       return Left(e.errorModel.errorMessage);
//     }
//   }
// }

// 3. data/repository/cart_repository.dart
// =====================================
class CartRepository implements BaseCartRepository {
  final ApiMethods api;
  CartRepository(this.api);
 
  @override
  Future<Either<String, CartModel>> getCartItems() async {
    try {
      final response = await api.get(ApiConstances.cart);
      final CartModel cartModel = CartModel.fromJson(response);
      return Right(cartModel);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}

// =====================================
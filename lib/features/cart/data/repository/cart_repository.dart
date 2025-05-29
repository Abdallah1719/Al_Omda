// // // import 'package:dartz/dartz.dart';
// // // import 'package:al_omda/core/api/api_methods.dart';
// // // import 'package:al_omda/core/api/api_constances.dart';

// // // class CartRepository {
// // //   final ApiMethods api;

// // //   CartRepository({required this.api});
// // //    Future<Either<String, bool>> addToCart(int productId) async {
// // //     try {
// // //       final response = await api.post(
// // //         ApiConstances.addToCart,
// // //         data: {"product_id": productId, "quantity": 1},
// // //       );

// // //       if (response['success']) {
// // //         return Right(true);
// // //       } else {
// // //         return Left(response['message'] ?? "فشل في إضافة المنتج للسلة");
// // //       }
// // //     } catch (e) {
// // //       return Left("خطأ في الاتصال بالشبكة");
// // //     }
// // //   }
// // // }

// // import 'package:al_omda/features/products/data/models/products_model.dart';
// // import 'package:dartz/dartz.dart';
// // import 'package:al_omda/core/api/api_methods.dart';
// // import 'package:al_omda/core/api/api_constances.dart';

// // class CartRepository {
// //   final ApiMethods api;

// //   CartRepository({required this.api});

// //   Future<Either<String, bool>> addToCart(int productId) async {
// //     try {
// //       final response = await api.post(
// //         ApiConstances.addToCart,
// //         data: {"product_id": productId, "quantity": 1},
// //       );

// //       // 👇 التأكد من وجود الحقل "success" أو "message"
// //       if (response is Map && response.containsKey("data")) {
// //         final data = response["data"];
// //         if (data is Map && data.containsKey("msg")) {
// //           final msg = data["msg"];
// //           if (msg is Map && msg.containsKey("message")) {
// //             final String message = msg["message"];

// //             if (message.contains("added")) {
// //               return Right(true);
// //             }
// //           }
// //         }
// //       }

// //       return Left("فشل في إضافة المنتج للسلة");
// //     } catch (e) {
// //       return Left("خطأ في الاتصال بالشبكة");
// //     }
// //   }

// //   Future<Either<String, List<ProductsModel>>> getCartItems() async {
// //     try {
// //       final response = await api.get(ApiConstances.cart);

// //       if (response is Map<String, dynamic> && response.containsKey('data')) {
// //         final List<dynamic> items = response['data']['cart']['items'];
// //         final List<ProductsModel> products =
// //             items.map((item) => ProductsModel.fromJson(item)).toList();
// //         return Right(products);
// //       }

// //       return Left("لا توجد منتجات في السلة");
// //     } catch (e) {
// //       return Left("فشل في جلب بيانات السلة");
// //     }
// //   }
// // }
// import 'package:al_omda/core/api/api_constances.dart';
// import 'package:al_omda/features/cart/data/cart_remote_data_source.dart';
// import 'package:al_omda/features/cart/data/models/cart_model.dart';
// import 'package:dartz/dartz.dart';

// import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';

// class CartRepository implements BaseCartRepository {
//   final CartRemoteDataSource cartRemoteDataSource;

//   CartRepository(this.cartRemoteDataSource);

//   @override
//   Future<Either<String, List<CartItemModel>>> getCartItems() async {
//     try {
//       final List<CartItemModel> cartItems =
//           await cartRemoteDataSource.getCartItemsFromApi();
//       return Right(cartItems);
//     } catch (e) {
//       return Left("فشل في جلب بيانات السلة");
//     }
//   }

//   @override
//   Future<Either<String, bool>> addToCart(int productId) async {
//     try {
//       final bool result = await cartRemoteDataSource.addProductToCart(
//         productId,
//       );
//       return result ? Right(true) : Left("فشل في إضافة المنتج");
//     } catch (e) {
//       return Left("خطأ في الاتصال بالشبكة");
//     }
//   }

//   @override
//   Future<Either<String, bool>> updateQuantity(
//     int productId,
//     int newQuantity,
//   ) async {
//     try {
//       final response = await cartRemoteDataSource.api.post(
//         ApiConstances.addToCart,
//         data: {"product_id": productId, "quantity": newQuantity},
//       );

//       final success = response['success'] ?? false;
//       return success ? Right(true) : Left("فشل في تحديث الكمية");
//     } catch (e) {
//       return Left("خطأ في التحديث");
//     }
//   }

//   @override
//   Future<Either<String, bool>> removeFromCart(int productId) async {
//     try {
//       final response = await cartRemoteDataSource.api.post(
//         ApiConstances.removeFromCart,
//         data: {"product_id": productId},
//       );

//       final success = response['success'] ?? false;
//       return success ? Right(true) : Left("فشل في الحذف");
//     } catch (e) {
//       return Left("خطأ في الحذف");
//     }
//   }
// }

import 'package:al_omda/features/cart/data/cart_remote_data_source.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';
import 'package:al_omda/features/cart/domain/repository/base_cart_repository.dart';
import 'package:dartz/dartz.dart';


class CartRepository implements BaseCartRepository {
  final CartRemoteDataSource cartRemoteDataSource;

  CartRepository(this.cartRemoteDataSource);

  @override
  Future<Either<String, List<CartItemModel>>> getCartItems() async {
    try {
      final List<CartItemModel> items = await cartRemoteDataSource.getCartItemsFromApi();
      return Right(items);
    } catch (e) {
      return Left("فشل في جلب بيانات السلة");
    }
  }

  @override
  Future<Either<String, List<CartItemModel>>> addToCart(int productId) async {
    try {
      final List<CartItemModel> updatedCart =
          await cartRemoteDataSource.addProductToCart(productId);
      return Right(updatedCart);
    } catch (e) {
      return Left("فشل في إضافة المنتج للسلة");
    }
  }

  @override
  Future<Either<String, List<CartItemModel>>> updateQuantity(
      int productId, int newQuantity) async {
    try {
      final List<CartItemModel> updatedCart =
          await cartRemoteDataSource.updateQuantity(productId, newQuantity);
      return Right(updatedCart);
    } catch (e) {
      return Left("فشل في تحديث الكمية");
    }
  }

  @override
  Future<Either<String, List<CartItemModel>>> removeFromCart(int productId) async {
    try {
      final List<CartItemModel> updatedCart =
          await cartRemoteDataSource.removeFromCart(productId);
      return Right(updatedCart);
    } catch (e) {
      return Left("فشل في حذف المنتج من السلة");
    }
  }
}
// import 'package:al_omda/core/api/api_constances.dart';
// import 'package:al_omda/core/api/api_methods.dart';
// import 'package:al_omda/features/cart/data/models/cart_model.dart';

// abstract class CartRemoteDataSource {
//   Future<List<CartItemModel>> getCartItemsFromApi();
//   Future<List<CartItemModel>> addProductToCart(int productId);
//   Future<List<CartItemModel>> removeFromCart(int productId);
//   Future<List<CartItemModel>> updateQuantity(int productId, int newQuantity);
// }

// class CartRemoteDataSourceImpl implements CartRemoteDataSource {
//   final ApiMethods api;

//   CartRemoteDataSourceImpl(this.api);

//   @override
//   Future<List<CartItemModel>> getCartItemsFromApi() async {
//     final response = await api.get(ApiConstances.cart);

//     if (response is Map && response.containsKey("data")) {
//       final items = response["data"]["items"] as List;
//       return items.map((item) => CartItemModel.fromJson(item)).toList();
//     }

//     return [];
//   }

//   @override
//   Future<List<CartItemModel>> addProductToCart(int productId) async {
//     final response = await api.post(
//       ApiConstances.addToCart,
//       data: {"product_id": productId, "quantity": 1},
//     );

//     if (response is Map && response.containsKey("data")) {
//       final items = response["data"]["cart"]["items"] as List;
//       return items.map((item) => CartItemModel.fromJson(item)).toList();
//     }

//     return [];
//   }

//   @override
//   Future<List<CartItemModel>> removeFromCart(int productId) async {
//     final response = await api.post(
//       ApiConstances.removeFromCart,
//       data: {"product_id": productId},
//     );

//     if (response is Map && response.containsKey("data")) {
//       final items = response["data"]["cart"]["items"] as List;
//       return items.map((item) => CartItemModel.fromJson(item)).toList();
//     }

//     return [];
//   }

//   @override
//   Future<List<CartItemModel>> updateQuantity(
//     int productId,
//     int newQuantity,
//   ) async {
//     try {
//       // إرسال الكمية الجديدة
//       final response = await api.post(
//         ApiConstances.addToCart,
//         data: {"product_id": productId, "quantity": newQuantity},
//       );

//       // إعادة تحميل العربة
//       return getCartItemsFromApi();
//     } catch (e) {
//       print("Error updating quantity: $e");
//       return [];
//     }
//   }
// }

import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItemsFromApi();
  Future<List<CartItemModel>> addProductToCart(int productId);
  Future<List<CartItemModel>> updateQuantity(int productId, int newQuantity);
  Future<List<CartItemModel>> removeFromCart(int productId);
}

class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final ApiMethods api;

  CartRemoteDataSourceImpl(this.api);

  @override
  Future<List<CartItemModel>> getCartItemsFromApi() async {
    final response = await api.get(ApiConstances.cart);

    if (response is Map && response.containsKey("data")) {
      final items = response["data"]["items"] as List;
      return items.map((item) => CartItemModel.fromJson(item)).toList();
    }

    return [];
  }

  @override
  Future<List<CartItemModel>> addProductToCart(int productId) async {
    final response = await api.post(
      ApiConstances.addToCart,
      data: {"product_id": productId, "quantity": 1},
    );

    if (response is Map && response.containsKey("data")) {
      final items = response["data"]["cart"]["items"] as List;
      return items.map((item) => CartItemModel.fromJson(item)).toList();
    }

    return [];
  }

  @override
  Future<List<CartItemModel>> updateQuantity(
    int productId,
    int newQuantity,
  ) async {
    final response = await api.post(
      ApiConstances.addToCart,
      data: {"product_id": productId, "quantity": newQuantity},
    );

    if (response is Map && response.containsKey("data")) {
      final items = response["data"]["cart"]["items"] as List;
      return items.map((item) => CartItemModel.fromJson(item)).toList();
    }

    return [];
  }

  @override
  Future<List<CartItemModel>> removeFromCart(int productId) async {
    final response = await api.post(
      ApiConstances.removeFromCart,
      data: {"product_id": productId},
    );

    print("Remove Response: $response");

    if (response is Map && response.containsKey("data")) {
      final dynamic data = response["data"];

      // حل المشكلة: تحليل هيكل الاستجابة بشكل صحيح
      if (data is Map && data.containsKey("cart") && data["cart"] is Map) {
        final cart = data["cart"] as Map;
        if (cart.containsKey("items") && cart["items"] is List) {
          final items = cart["items"] as List;
          return items.map((item) => CartItemModel.fromJson(item)).toList();
        }
      }
      // بعض APIs ترجع العناصر مباشرة
      else if (data is Map &&
          data.containsKey("items") &&
          data["items"] is List) {
        final items = data["items"] as List;
        return items.map((item) => CartItemModel.fromJson(item)).toList();
      }
    }

    throw Exception("Invalid response structure");
  }
}

import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItemsFromApi();
  Future<List<CartItemModel>> addProductToCart(int productId);
  Future<List<CartItemModel>> updateQuantity(int productId, int newQuantity);
  Future<List<CartItemModel>> removeFromCart(int productId);
  Future<bool> makeOrder({
    required String date,
    required String time,
    required int paymentId,
    required int addressId,
  });
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

    // إذا كانت الاستجابة تحتوي على رسالة فقط
    if (response is Map && response.containsKey("data")) {
      final dynamic data = response["data"];

      // الحالة 1: استجابة ناجحة بدون بيانات سلة
      if (data is Map && data.containsKey("msg")) {
        // نحتاج إلى إعادة جلب السلة يدويًا
        return await getCartItemsFromApi();
      }
      // الحالة 2: استجابة تحتوي على بيانات سلة مباشرة
      else if (data is Map && data.containsKey("cart") && data["cart"] is Map) {
        final cart = data["cart"] as Map;
        if (cart.containsKey("items") && cart["items"] is List) {
          final items = cart["items"] as List;
          return items.map((item) => CartItemModel.fromJson(item)).toList();
        }
      }
      // الحالة 3: استجابة تحتوي على العناصر مباشرة
      else if (data is Map &&
          data.containsKey("items") &&
          data["items"] is List) {
        final items = data["items"] as List;
        return items.map((item) => CartItemModel.fromJson(item)).toList();
      }
    }

    // إذا لم نتمكن من الحصول على البيانات، نعيد جلب السلة يدويًا
    return await getCartItemsFromApi();
  }

  @override
  Future<bool> makeOrder({
    required String date,
    required String time,
    required int paymentId,
    required int addressId,
  }) async {
    final response = await api.post(
      ApiConstances.makeOrder,
      data: {
        'shipping_day': date,
        'shipping_time': time,
        'payment_id': paymentId,
        'address_id': addressId,
      },
    );
    print("Response from server: $response");
    return response['status'] == true;
  }
}

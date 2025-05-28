import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';


class CartRemoteDataSource {
  final ApiMethods api;

  CartRemoteDataSource({required this.api});

  Future<List<CartItemModel>> getCartItemsFromApi() async {
    final response = await api.get(ApiConstances.cart);

    if (response is Map && response.containsKey("data")) {
      final items = response["data"]["cart"]["items"] as List;
      return items.map((item) => CartItemModel.fromJson(item)).toList();
    }

    return [];
  }

  Future<bool> addProductToCart(int productId) async {
    final response = await api.post(ApiConstances.addToCart, data: {
      "product_id": productId,
      "quantity": 1,
    });

    return response is Map &&
        response.containsKey("data") &&
        response["data"] is Map &&
        response["data"]["msg"] is Map &&
        response["data"]["msg"]["message"].contains("added");
  }
}
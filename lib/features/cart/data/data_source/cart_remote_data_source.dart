import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/features/cart/data/models/cart_model.dart';

abstract class CartRemoteDataSource {
  Future<List<CartItemModel>> getCartItemsFromApi();
  // Future<List<CartItemModel>> addProductToCart(int productId, int newQuantity);
  // Future<List<CartItemModel>> removeFromCart(int productId);
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

  


}

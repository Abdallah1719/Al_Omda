import 'package:al_omda/features/cart/data/models/cart_items_model.dart';
import 'package:al_omda/features/cart/data/models/cart_summary_model.dart';
import 'package:equatable/equatable.dart';

class CartModel extends Equatable {
  final List<CartItemsModel> items;
  final CartSummaryModel summary;

  const CartModel({required this.items, required this.summary});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return CartModel(
      items:
          (data['items'] as List<dynamic>)
              .map((item) => CartItemsModel.fromJson(item))
              .toList(),
      summary: CartSummaryModel.fromJson(data),
    );
  }

  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get itemCount => items.length;

  @override
  List<Object?> get props => [items, summary];
}

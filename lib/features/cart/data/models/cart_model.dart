import 'package:al_omda/features/cart/domain/entities/cart.dart';

class CartItemModel extends CartItem {
  const CartItemModel({
    required super.productId,
    required super.title,
    required super.price,
    required super.image,
    required super.unitName,
    required super.weight,
    required super.quantity,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    print("Parsing Cart Item: $json"); // 👈 للمساعدة في التشخيص

    return CartItemModel(
      productId: json['id'] ?? 0, // 👈 القيمة الافتراضية مهمة
      title: json['title'] ?? 'Unknown Product',
      price: json['price'],
      image: json['image'] ?? '',
      unitName: json['unit_name'] ?? 'Unit',
      weight: json['weight']?.toString() ?? '',
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': productId,
      'title': title,
      'price': price,
      'image': image,
      'unit_name': unitName,
      'weight': weight,
      'quantity': quantity,
    };
  }
}

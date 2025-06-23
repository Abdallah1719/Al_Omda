import 'package:equatable/equatable.dart';

class CartItemsModel extends Equatable {
  final int productId;
  final String title;
  final int price;
  final String image;
  final String unitName;
  final String weight;
  final int quantity;
  final int total;

  const CartItemsModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.unitName,
    required this.weight,
    required this.quantity,
    required this.total,
  });

  factory CartItemsModel.fromJson(Map<String, dynamic> json) {
    return CartItemsModel(
      productId: json['id'] ?? 0,
      title: json['title'] ?? 'Unknown Product',
      price: json['price'],
      image: json['image'] ?? '',
      unitName: json['unit_name'] ?? 'Unit',
      weight: json['weight']?.toString() ?? '',
      quantity: json['quantity'] ?? 1,
      total: json['total'] ?? 0,
    );
  }

  @override
  List<Object?> get props => [
    productId,
    title,
    price,
    image,
    unitName,
    weight,
    quantity,
  ];
}

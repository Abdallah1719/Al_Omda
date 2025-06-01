import 'package:equatable/equatable.dart';

class CartItem extends Equatable {
  final int productId;
  final String title;
  final int price;
  final String image;
  final String unitName;
  final String weight;
  final int quantity;

  const CartItem({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.unitName,
    required this.weight,
    required this.quantity,
  });
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

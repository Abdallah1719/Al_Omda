// class CartItem {
//   final int productId;
//   final String title;
//   final int price;
//   final String image;
//   final String unitName;
//   final String weight;
//   final int quantity;

//   const CartItem({
//     required this.productId,
//     required this.title,
//     required this.price,
//     required this.image,
//     required this.unitName,
//     required this.weight,
//     required this.quantity,
//   });
// }

class CartItem {
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

  CartItem copyWith({
    int? productId,
    String? title,
    int? price,
    String? image,
    String? unitName,
    String? weight,
    int? quantity,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      unitName: unitName ?? this.unitName,
      weight: weight ?? this.weight,
      quantity: quantity ?? this.quantity,
    );
  }

  @override
  List<Object?> get props => [productId, title, price, image, unitName, weight, quantity];
}
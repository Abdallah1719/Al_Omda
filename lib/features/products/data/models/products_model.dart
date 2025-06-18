class ProductModel {
  final int id;
  final String title;
  final int price;
  final String image;
  final String weight;
  final String unitName;
  final bool cart;
  final int cartQuantity;
  final bool inStock;
  
  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.weight,
    required this.unitName,
    required this.cart,
    required this.cartQuantity,
    required this.inStock,
  });

  ProductModel copyWith({bool? cart, int? cartQuantity}) {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      image: image,
      weight: weight,
      unitName: unitName,
      cart: cart ?? this.cart,
      cartQuantity: cartQuantity ?? this.cartQuantity,
      inStock: inStock,
    );
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    image: json["image"] ?? '',
    price: json['price']?.toInt() ?? 0,
    unitName: json["unit_name"] ?? 'Unknown',
    weight: json["weight"] ?? '',
    cart: json["cart"] ?? false,
    cartQuantity: json["cart_quantity"] ?? 0,
    inStock: json["in_stock"] ?? true,
  );

}

class ProductInCart {
  final ProductModel product;
  final int quantity;

  const ProductInCart({
    required this.product,
    required this.quantity,
  });

  // عشان نسهل الوصول للـ ID
  int get productId => product.id;
}
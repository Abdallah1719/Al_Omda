// import 'package:equatable/equatable.dart';

// class CartItemModel extends Equatable {
//   final int productId;
//   final String title;
//   final int price;
//   final String image;
//   final String unitName;
//   final String weight;
//   final int quantity;
//   final int total;

//   const CartItemModel({
//     required this.productId,
//     required this.title,
//     required this.price,
//     required this.image,
//     required this.unitName,
//     required this.weight,
//     required this.quantity,
//     required this.total,
//   });

//   factory CartItemModel.fromJson(Map<String, dynamic> json) {
//     return CartItemModel(
//       productId: json['id'] ?? 0,
//       title: json['title'] ?? 'Unknown Product',
//       price: json['price'],
//       image: json['image'] ?? '',
//       unitName: json['unit_name'] ?? 'Unit',
//       weight: json['weight']?.toString() ?? '',
//       quantity: json['quantity'] ?? 1,
//       total: json['total'] ?? 0,
//     );
//   }
//   @override
//   List<Object?> get props => [
//     productId,
//     title,
//     price,
//     image,
//     unitName,
//     weight,
//     quantity,
//   ];
// }

// =====================================
import 'package:equatable/equatable.dart';

// Model للمنتج في الكارت
class CartItemModel extends Equatable {
  final int productId;
  final String title;
  final int price;
  final String image;
  final String unitName;
  final String weight;
  final int quantity;
  final int total;

  const CartItemModel({
    required this.productId,
    required this.title,
    required this.price,
    required this.image,
    required this.unitName,
    required this.weight,
    required this.quantity,
    required this.total,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
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

// Model للملخص الإجمالي للكارت
class CartSummaryModel extends Equatable {
  final double total;
  final int totalItems;
  final double discountValue;

  const CartSummaryModel({
    required this.total,
    required this.totalItems,
    required this.discountValue,
  });

  factory CartSummaryModel.fromJson(Map<String, dynamic> json) {
    return CartSummaryModel(
      total: (json['total'] ?? 0).toDouble(),
      totalItems: json['totalItems'] ?? 0,
      discountValue: (json['discount_value'] ?? 0).toDouble(),
    );
  }

  // الإجمالي بعد الخصم
  double get finalTotal => total - discountValue;

  // التحقق من وجود خصم
  bool get hasDiscount => discountValue > 0;

  @override
  List<Object?> get props => [total, totalItems, discountValue];
}

// Model شامل للكارت كله
class CartModel extends Equatable {
  final List<CartItemModel> items;
  final CartSummaryModel summary;

  const CartModel({required this.items, required this.summary});

  factory CartModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return CartModel(
      items:
          (data['items'] as List<dynamic>)
              .map((item) => CartItemModel.fromJson(item))
              .toList(),
      summary: CartSummaryModel.fromJson(data),
    );
  }

  // بعض الـ helper methods
  bool get isEmpty => items.isEmpty;
  bool get isNotEmpty => items.isNotEmpty;
  int get itemCount => items.length;

  @override
  List<Object?> get props => [items, summary];
}

import 'package:equatable/equatable.dart';

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
  double get finalTotal => total - discountValue;
  bool get hasDiscount => discountValue > 0;
  @override
  List<Object?> get props => [total, totalItems, discountValue];
}

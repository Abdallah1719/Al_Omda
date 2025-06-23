
import 'package:al_omda/features/cart/presentation/controller/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/cart/presentation/controller/cubit/cart_state.dart';

class TotalsSection extends StatelessWidget {
  const TotalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, cartState) {
        double subtotal = 0.0;
        double finalTotal = 0.0;
        const double deliveryFee = 20.0;
        const double discountValue = 0.0;

        if (cartState is CartLoaded) {
          subtotal = cartState.cartModel.summary.total;
          finalTotal = subtotal + deliveryFee - discountValue;
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            children: [
              if (cartState is CartLoaded && cartState.cartModel.items.isNotEmpty) ...[
                _buildCartItemsHeader(),
                const SizedBox(height: 8),
                ...cartState.cartModel.items.map(
                  (item) => _buildCartItemRow(item),
                ),
                const SizedBox(height: 8),
                const Divider(thickness: 1),
              ],
              _buildTotalRow('Subtotal:', '${subtotal.toStringAsFixed(0)} L.E'),
              if (discountValue > 0)
                _buildTotalRow(
                  'Discount:',
                  '-${discountValue.toStringAsFixed(0)} L.E',
                ),
              _buildTotalRow(
                'Delivery Fee:',
                '${deliveryFee.toStringAsFixed(0)} L.E',
              ),
              const Divider(thickness: 1),
              _buildTotalRow(
                'Total:',
                '${finalTotal.toStringAsFixed(0)} L.E',
                isTotal: true,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCartItemsHeader() {
    return const Row(
      children: [
        Icon(Icons.shopping_cart, size: 20, color: Colors.green),
        SizedBox(width: 8),
        Text(
          'Order Items:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildTotalRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 18 : 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemRow(dynamic item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const SizedBox(width: 28),
          Expanded(
            child: Text(
              '${_getProductName(item)} x${item.quantity ?? 0}',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ),
          Text(
            '${_getItemTotal(item).toStringAsFixed(0)} L.E',
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  String _getProductName(dynamic item) {
    try {
      if (item?.productName != null) return item.productName.toString();
      if (item?.name != null) return item.name.toString();
      if (item?.product?.name != null) return item.product.name.toString();
      if (item?.title != null) return item.title.toString();
      return 'Product';
    } catch (e) {
      return 'Product';
    }
  }

  int _getItemTotal(dynamic item) {
    final price = item.price ?? 0.0;
    final quantity = item.quantity ?? 0;
    return price * quantity;
  }
}
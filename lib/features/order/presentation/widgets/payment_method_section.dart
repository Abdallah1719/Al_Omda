
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';

class PaymentMethodSection extends StatelessWidget {
  final OrderCubit cubit;

  const PaymentMethodSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final selectedPaymentMethod = cubit.selectedPaymentMethod;
        final paymentError = cubit.validatePaymentMethod(selectedPaymentMethod);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._paymentMethods.map(
              (method) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: RadioListTile<String>(
                  title: Row(
                    children: [
                      Icon(method['icon'], size: 20),
                      const SizedBox(width: 8),
                      Text(method['name']),
                    ],
                  ),
                  value: method['id'].toString(),
                  groupValue: selectedPaymentMethod,
                  onChanged: (value) {
                    if (value != null) {
                      cubit.updatePaymentMethod(value);
                    }
                  },
                  activeColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color:
                          selectedPaymentMethod == method['id'].toString()
                              ? Colors.green
                              : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
            if (paymentError != null) ...[
              const SizedBox(height: 4),
              Text(
                paymentError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  static const List<Map<String, dynamic>> _paymentMethods = [
    {'id': 1, 'name': 'Cash on Delivery', 'icon': Icons.money},
    {'id': 2, 'name': 'Credit Card', 'icon': Icons.credit_card},
    {'id': 3, 'name': 'Mobile Wallet', 'icon': Icons.phone_android},
  ];
}


import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';

class ShippingTimeSection extends StatelessWidget {
  final OrderCubit cubit;

  const ShippingTimeSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final selectedTime = cubit.selectedTime;
        final timeError = cubit.validateTime(selectedTime);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildTimeChip(context, cubit, 'Now - 60 min'),
                _buildTimeChip(context, cubit, '5 - 6 PM'),
                _buildTimeChip(context, cubit, '6 - 7 PM'),
                _buildTimeChip(context, cubit, '7 - 8 PM'),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: timeError == null ? Colors.green.shade50 : Colors.red.shade50,
                border: Border.all(
                  color: timeError == null ? Colors.green : Colors.red,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedTime != null
                    ? 'Selected Time: $selectedTime'
                    : 'Please Select Time',
                style: TextStyle(
                  fontSize: 16,
                  color: timeError == null ? Colors.green.shade700 : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (timeError != null) ...[
              const SizedBox(height: 4),
              Text(
                timeError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTimeChip(BuildContext context, OrderCubit cubit, String time) {
    final isSelected = cubit.selectedTime == time;

    return ActionChip(
      label: Text(
        time,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.normal,
        ),
      ),
      backgroundColor: isSelected ? Colors.green : Colors.grey[200],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onPressed: () {
        cubit.updateSelectedTime(time);
      },
    );
  }
}
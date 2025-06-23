
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';

class ShippingDateSection extends StatelessWidget {
  final OrderCubit cubit;

  const ShippingDateSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      builder: (context, state) {
        final selectedDate = cubit.selectedDate;
        final dateError = cubit.validateDate(selectedDate);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Shipping Day',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _selectShippingDate(context, cubit),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Select Shipping Date',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: dateError == null ? Colors.green.shade50 : Colors.red.shade50,
                border: Border.all(
                  color: dateError == null ? Colors.green : Colors.red,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                selectedDate ?? 'No Date Selected',
                style: TextStyle(
                  fontSize: 16,
                  color: dateError == null ? Colors.green.shade700 : Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (dateError != null) ...[
              const SizedBox(height: 4),
              Text(
                dateError,
                style: const TextStyle(color: Colors.red, fontSize: 12),
              ),
            ],
          ],
        );
      },
    );
  }

  Future<void> _selectShippingDate(BuildContext context, OrderCubit cubit) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );

    if (pickedDate != null) {
      String formattedDate =
          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')} ${_getDayOfWeek(pickedDate)}";

      cubit.updateSelectedDate(formattedDate);
    }
  }

  String _getDayOfWeek(DateTime date) {
    switch (date.weekday) {
      case 1: return 'Mon';
      case 2: return 'Tue';
      case 3: return 'Wed';
      case 4: return 'Thu';
      case 5: return 'Fri';
      case 6: return 'Sat';
      case 7: return 'Sun';
      default: return '';
    }
  }
}
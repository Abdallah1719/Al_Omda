
import 'package:al_omda/features/order/presentation/controller/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:al_omda/features/order/presentation/controller/cubit/order_cubit.dart';

class AddressSection extends StatelessWidget {
  final OrderCubit cubit;

  const AddressSection({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Address',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Expanded(
                child: BlocBuilder<OrderCubit, OrderState>(
                  builder: (context, state) {
                    final addressText = cubit.selectedAddressText;
                    final hasAddresses = cubit.availableAddresses.isNotEmpty;

                    return Text(
                      hasAddresses ? addressText : 'Loading addresses...',
                      style: TextStyle(
                        fontSize: 16,
                        color: hasAddresses ? Colors.black : Colors.grey,
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => _showAddressOptions(context, cubit),
                    child: const Row(
                      children: [
                        Icon(Icons.edit, size: 18, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Change',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  GestureDetector(
                    onTap: () => _addNewAddress(context, cubit),
                    child: const Row(
                      children: [
                        Icon(Icons.add, size: 18, color: Colors.green),
                        SizedBox(width: 4),
                        Text(
                          'Add New',
                          style: TextStyle(fontSize: 14, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'Make sure this address is correct.',
          style: TextStyle(fontSize: 12, color: Colors.grey),
        ),
        BlocBuilder<OrderCubit, OrderState>(
          builder: (context, state) {
            final addressError = cubit.validateAddress(cubit.selectedAddressId);
            if (addressError != null) {
              return Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  addressError,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  void _showAddressOptions(BuildContext context, OrderCubit cubit) {
    if (cubit.availableAddresses.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No addresses available. Please add an address first.'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Address',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...cubit.availableAddresses.map(
              (address) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: RadioListTile<int>(
                  title: Text(
                    '${address.street}\n${address.city}, ${address.id}',
                    style: const TextStyle(fontSize: 14),
                  ),
                  value: address.id,
                  groupValue: cubit.selectedAddressId,
                  onChanged: (value) {
                    if (value != null) {
                      cubit.updateSelectedAddress(value);
                      Navigator.of(context).pop();
                    }
                  },
                  activeColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(
                      color: cubit.selectedAddressId == address.id
                          ? Colors.green
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      cubit.refreshAddresses();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    child: const Text(
                      'Refresh',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _addNewAddress(BuildContext context, OrderCubit cubit) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: const Text(
          'This feature will navigate to add address screen.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
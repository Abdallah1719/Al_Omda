import 'package:flutter/material.dart';

class DeliveryFeeSection extends StatelessWidget {
  const DeliveryFeeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Delivery Fee:',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('20 L.E', style: TextStyle(fontSize: 16, color: Colors.green)),
      ],
    );
  }
}

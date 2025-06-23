
import 'package:al_omda/features/cart/data/models/cart_summary_model.dart';
import 'package:flutter/material.dart';


class CartSummaryWidget extends StatelessWidget {
  final CartSummaryModel summary;

  const CartSummaryWidget({super.key, required this.summary});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ملخص الطلب",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("عدد المنتجات:"),
              Text(
                "${summary.totalItems} منتج",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("إجمالي السعر:"),
              Text(
                "${summary.total.toStringAsFixed(2)} جنيه",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            ],
          ),

          if (summary.hasDiscount) ...[
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("الخصم:", style: TextStyle(color: Colors.green)),
                Text(
                  "- ${summary.discountValue.toStringAsFixed(2)} جنيه",
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "المطلوب دفعه:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${summary.finalTotal.toStringAsFixed(2)} جنيه",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ] else
            Divider(height: 20),

          if (!summary.hasDiscount)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "الإجمالي:",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${summary.total.toStringAsFixed(2)} جنيه",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

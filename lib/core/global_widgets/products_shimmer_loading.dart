import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:flutter/material.dart';

class ProductsShimmerLoading extends StatelessWidget {
  const ProductsShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.65,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        itemCount: 6, // Show 6 shimmer items
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product image shimmer
                  Expanded(
                    flex: 3,
                    child: ShimmerWidget.rectangular(
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Product title shimmer
                  ShimmerWidget.rectangular(width: double.infinity, height: 16),
                  SizedBox(height: 4),
                  // Product subtitle shimmer
                  ShimmerWidget.rectangular(width: 120, height: 14),
                  SizedBox(height: 8),
                  // Price shimmer
                  ShimmerWidget.rectangular(width: 80, height: 18),
                  SizedBox(height: 4),
                  // Rating shimmer
                  Row(
                    children: [
                      ShimmerWidget.rectangular(width: 60, height: 12),
                      Spacer(),
                      ShimmerWidget.circular(width: 24, height: 24),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

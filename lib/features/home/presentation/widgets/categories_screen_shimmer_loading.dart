
import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:flutter/material.dart';

class CategoriesScreenShimmerLoading extends StatelessWidget {
  const CategoriesScreenShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      itemCount: 8, // Show 8 shimmer items
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Category icon/image shimmer
                ShimmerWidget.circular(height: 60, width: 60),
                SizedBox(height: 12),
                // Category name shimmer
                ShimmerWidget.rectangular(height: 16, width: 100),
                SizedBox(height: 6),
                // Category subtitle shimmer
                ShimmerWidget.rectangular(height: 12, width: 80),
              ],
            ),
          ),
        );
      },
    );
  }
}

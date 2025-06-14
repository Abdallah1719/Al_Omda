
import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CategoriesShimmerLoading extends StatelessWidget {
  const CategoriesShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        viewportFraction: 0.4,
        enableInfiniteScroll: false,
        padEnds: false,
        initialPage: 0,
        onPageChanged: (index, reason) {},
      ),
      items: List.generate(
        5,
        (index) => Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerWidget.circular(height: 100, width: 100),
              SizedBox(height: 12),
              ShimmerWidget.rectangular(height: 15, width: 120),
              SizedBox(height: 8),
              ShimmerWidget.rectangular(height: 12, width: 80),
            ],
          ),
        ),
      ),
    );
  }
}

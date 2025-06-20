
import 'package:al_omda/core/global_widgets/shimmer_loaing.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeSliderShimmerLoading extends StatelessWidget {
  const HomeSliderShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 175.0,
        viewportFraction: 0.8,
        autoPlay: false, 
        enlargeCenterPage: false,
        onPageChanged: (index, reason) {},
      ),
      items: List.generate(
        3,
        (index) => Padding(
          padding: const EdgeInsets.only(right: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: const ShimmerWidget.rectangular(
              width: double.infinity,
              height: 174.0,
            ),
          ),
        ),
      ),
    );
  }
}

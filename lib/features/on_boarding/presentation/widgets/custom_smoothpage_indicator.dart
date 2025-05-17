import 'package:al_omda/core/utils/index.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSmoothPageIndicator extends StatelessWidget {
  const CustomSmoothPageIndicator({super.key, required this.controller});
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: 3,
      effect: ExpandingDotsEffect(
        activeDotColor: R.colors.primaryColor,
        dotColor: R.colors.lightgreen,
        dotHeight: 12,
        dotWidth: 12,
      ),
    );
  }
}

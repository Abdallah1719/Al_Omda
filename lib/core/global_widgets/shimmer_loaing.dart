import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';


class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    required this.shapeBorder,
    this.child,
    // this.radius,
  });
  final double width;
  final double height;
  final Widget? child;
  // final double? radius;
  final ShapeBorder shapeBorder;
  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    // this.radius = 8.0,
    required this.height,
    this.shapeBorder = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
    ),
    this.child,
  });
  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return Shimmer(
     
        color: Colors.grey[300]!,
      
        duration:const Duration(seconds: 3),
      
      
   
      child: Container(
        padding: const EdgeInsets.all(16.0),
        width: width,
        height: height,
        decoration: ShapeDecoration(
          shape: shapeBorder,
          color: Colors.grey[100],
        ),
        child: child,
      ),
    );
  }
}

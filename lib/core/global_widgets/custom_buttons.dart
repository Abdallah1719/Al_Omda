import 'package:al_omda/core/utils/index.dart';
import 'package:al_omda/core/utils/size_config.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, this.text, this.onPressed});
  final String? text;
  // final VoidCallback? onTap;
  // final Color? color;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text!,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color:
              R
                  .colors
                  .white, // لون النص (قد يتم تجاهله إذا كان هناك foregroundColor)
        ),
      ),
    );
    //  GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     height: 60,
    //     width: SizeConfig.screenWidth,
    //     decoration: BoxDecoration(
    //       color: color,
    //       borderRadius: BorderRadius.circular(8),
    //     ),
    //     child: Center(
    //       child: Text(
    //         text!,
    //         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
    //           color: R.colors.white,
    //           fontWeight: FontWeight.bold,
    //           fontSize: 18,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}

class CustomButtonWithIcon extends StatelessWidget {
  const CustomButtonWithIcon({
    super.key,
    required this.text,
    this.onTap,
    this.iconData,
    this.color,
  });
  final String text;
  final IconData? iconData;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xFF707070)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, color: color),
            HorizintalSpace(2),
            Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
                fontSize: 12,
                color: const Color(0xff000000),
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, this.text, this.onTap, this.color});
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: R.colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

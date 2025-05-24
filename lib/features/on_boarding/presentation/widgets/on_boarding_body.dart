import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/on_boarding/data/on_boarding_model.dart';
import 'package:al_omda/features/on_boarding/presentation/widgets/custom_smoothpage_indicator.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  const OnBoardingBody({
    super.key,
    required this.controller,
    this.onPageChanged,
  });
  final PageController controller;
  final void Function(int)? onPageChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: PageView.builder(
        onPageChanged: onPageChanged,
        physics: BouncingScrollPhysics(),
        controller: controller,
        itemCount: onBoardingList.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              VerticalSpace(6),
              Container(
                width: 273,
                height: 246,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(onBoardingList[index].image),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              VerticalSpace(3),

              Text(
                onBoardingList[index].onBoadingTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              VerticalSpace(2),
              Text(
                onBoardingList[index].onBoardingText,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              VerticalSpace(6),
              Center(child: CustomSmoothPageIndicator(controller: controller)),
            ],
          );
        },
      ),
    );
  }
}

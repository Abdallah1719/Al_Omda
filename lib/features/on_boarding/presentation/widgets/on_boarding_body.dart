import 'package:al_omda/core/global_widgets/custom_buttons.dart';
import 'package:al_omda/core/utils/app_assets.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/on_boarding/presentation/widgets/custom_smoothpage_indicator.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';

class OnBoardingBody extends StatelessWidget {
  OnBoardingBody({super.key});
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: PageView.builder(
        controller: _controller,
        itemCount: 3,
        itemBuilder: (context, index) {
          return Column(
            children: [
              VerticalSpace(6),
              Image.asset(Assets.imagesOnboarding1),
              VerticalSpace(3),

              Text(
                S.of(context).onBoardingTitle1,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              VerticalSpace(2),
              Text(
                S.of(context).onBoardingText1,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              VerticalSpace(9),
              CustomSmoothPageIndicator(controller: _controller),
              VerticalSpace(3),
            ],
          );
        },
      ),
    );
  }
}

import 'package:al_omda/core/global_widgets/custom_buttons.dart';
import 'package:al_omda/core/routes/routes_methods.dart';
import 'package:al_omda/core/utils/index.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/on_boarding/data/on_boarding_model.dart';
import 'package:al_omda/features/on_boarding/presentation/widgets/get_onboarding_buttons.dart';
import 'package:al_omda/features/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController controller = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: R.padding.p16),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              VerticalSpace(4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  S.of(context).skip,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              OnBoardingBody(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {});
                  currentIndex = index;
                },
              ),
              VerticalSpace(5),
              GetOnboardingButtons(
                controller: controller,
                currentIndex: currentIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

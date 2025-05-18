import 'package:al_omda/core/global_widgets/custom_buttons.dart';
import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/routes/routes_methods.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/index.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/on_boarding/data/on_boarding_model.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';

class GetOnboardingButtons extends StatelessWidget {
  const GetOnboardingButtons({
    super.key,
    required this.currentIndex,
    required this.controller,
  });
  final int currentIndex;
  final PageController controller;

  @override
  Widget build(BuildContext context) {
    if (currentIndex == onBoardingList.length - 1) {
      return Column(
        children: [
          CustomGeneralButton(
            color: R.colors.primaryColor,
            text: S.of(context).getStarted,
            onTap: () {
              getIt<CacheHelper>().saveData(
                key: "isOnBoardingVisited",
                value: true,
              );
              RoutesMethods.customReplacementNavigate(context, "/home");
            },
          ),
          VerticalSpace(2),
          GestureDetector(
            onTap: () {
              getIt<CacheHelper>().saveData(
                key: "isOnBoardingVisited",
                value: true,
              );
              RoutesMethods.customReplacementNavigate(context, "/login");
            },
            child: Text(
              S.of(context).loginNow,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      );
    } else {
      return CustomGeneralButton(
        color: R.colors.primaryColor,
        text: S.of(context).next,
        onTap: () {
          controller.nextPage(
            duration: Duration(milliseconds: 200),
            curve: Curves.bounceIn,
          );
        },
      );
    }
  }
}

import 'package:al_omda/core/global_widgets/custom_buttons.dart';
import 'package:al_omda/core/utils/index.dart';
import 'package:al_omda/core/utils/space_widget.dart';
import 'package:al_omda/features/on_boarding/presentation/widgets/on_boarding_body.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: R.padding.p16),
          child: Column(
            children: [
              VerticalSpace(4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  S.of(context).skip,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              OnBoardingBody(),
              VerticalSpace(3),
              CustomGeneralButton(text: S.of(context).next),
              VerticalSpace(15),
            ],
          ),
        ),
      ),
    );
  }
}

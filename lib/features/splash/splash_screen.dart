import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/routes/routes_constances.dart';
import 'package:al_omda/core/routes/routes_methods.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/core/utils/app_assets.dart';
import 'package:al_omda/core/utils/index.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: R.colors.primaryColor,
      body: SplashScreenBody(),
    );
  }
}

class SplashScreenBody extends StatefulWidget {
  const SplashScreenBody({super.key});

  @override
  State<SplashScreenBody> createState() => _SplashScreenBodyState();
}

class _SplashScreenBodyState extends State<SplashScreenBody>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation<double>? fadingAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    fadingAnimation = Tween<double>(
      begin: .2,
      end: 1.2,
    ).animate(animationController!);

    animationController?.repeat(reverse: true);
    bool isOnBoardingVisited =
        getIt<CacheHelper>().getData(key: "isOnBoardingVisited") ?? false;
    if (isOnBoardingVisited == true) {
      goToNextView(context, RoutesConstances.homePath);
    } else {
      goToNextView(context, RoutesConstances.onBoardingPath);
    }
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FadeTransition(
          opacity: fadingAnimation!,
          child: Image.asset(Assets.imagesSplashLogo),
        ),
      ],
    );
  }

  void goToNextView(context, path) {
    Future.delayed(Duration(seconds: 3), () {
      RoutesMethods.replacementNavigate(context, path);
    });
  }
}

import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:al_omda/features/splash/presentation/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => SplashScreen()),
    GoRoute(
      path: "/onBoarding",
      builder: (context, state) => OnBoardingScreen(),
    ),
  ],
);

// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
// import 'package:al_omda/features/splash/presentation/screens/splash_screen.dart';

// GoRouter createAppRouter(Locale appLocale, ThemeData appTheme) {
//   return GoRouter(
//     initialLocation: '/',
//     routes: [
//       GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
//       GoRoute(
//         path: '/onBoarding',
//         builder: (context, state) => const OnBoardingScreen(),
//       ),
//     ],
//   );
// }

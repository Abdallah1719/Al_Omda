import 'package:al_omda/features/auth/presentation/screens/login_screen.dart';
import 'package:al_omda/features/home/presentation/screens/home_screen.dart';
import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:al_omda/features/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: "/", builder: (context, state) => SplashScreen()),
    GoRoute(
      path: "/onBoarding",
      builder: (context, state) => OnBoardingScreen(),
    ),
    GoRoute(path: "/login", builder: (context, state) => LoginScreen()),
    GoRoute(path: "/home", builder: (context, state) => HomeScreen()),
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

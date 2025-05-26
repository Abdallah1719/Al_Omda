// // import 'package:al_omda/features/account/presentation/screens/account_info_screen.dart';
// // import 'package:al_omda/features/account/presentation/screens/account_screen.dart';
// // import 'package:al_omda/features/auth/presentation/screens/forget_password_screen.dart';
// // import 'package:al_omda/features/auth/presentation/screens/login_screen.dart';
// // import 'package:al_omda/features/auth/presentation/screens/register_screen.dart';
// // import 'package:al_omda/features/categories/presentation/screens/categories_screen.dart';
// // import 'package:al_omda/features/home/presentation/screens/home_screen.dart';
// // import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
// // import 'package:al_omda/features/products/presentation/screens/products_screen.dart';
// // import 'package:al_omda/features/splash/splash_screen.dart';
// // import 'package:go_router/go_router.dart';

// // final GoRouter router = GoRouter(
// //   routes: [
// //     GoRoute(path: "/", builder: (context, state) => SplashScreen()),
// //     GoRoute(
// //       path: "/onBoarding",
// //       builder: (context, state) => OnBoardingScreen(),
// //     ),
// //     GoRoute(path: "/login", builder: (context, state) => LoginPage()),
// //     GoRoute(path: "/register", builder: (context, state) => RegisterScreen()),
// //     GoRoute(
// //       path: "/forgetPassword",
// //       builder: (context, state) => ForgetPasswordScreen(),
// //     ),
// //     GoRoute(path: "/home", builder: (context, state) => HomeScreen()),
// //     GoRoute(
// //       path: "/categories",
// //       builder: (context, state) => CategoriesScreen(),
// //     ),
// //     GoRoute(path: "/products", builder: (context, state) => ProductsScreen()),
// //     GoRoute(
// //       path: "/accountscreen",
// //       builder: (context, state) => Accountscreen(),
// //     ),

// //     GoRoute(
// //       path: "/accountInfoScreen",
// //       builder: (context, state) => AccountInfoScreen(),
// //     ),
// //   ],
// // );

// // // import 'package:flutter/material.dart';
// // // import 'package:go_router/go_router.dart';
// // // import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
// // // import 'package:al_omda/features/splash/presentation/screens/splash_screen.dart';

// // // GoRouter createAppRouter(Locale appLocale, ThemeData appTheme) {
// // //   return GoRouter(
// // //     initialLocation: '/',
// // //     routes: [
// // //       GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
// // //       GoRoute(
// // //         path: '/onBoarding',
// // //         builder: (context, state) => const OnBoardingScreen(),
// // //       ),
// // //     ],
// // //   );
// // // }

// import 'package:al_omda/features/account/presentation/screens/account_info_screen.dart';
// import 'package:al_omda/features/account/presentation/screens/account_screen.dart';
// import 'package:al_omda/features/auth/presentation/screens/forget_password_screen.dart';
// import 'package:al_omda/features/auth/presentation/screens/login_screen.dart';
// import 'package:al_omda/features/auth/presentation/screens/register_screen.dart';
// import 'package:al_omda/features/categories/presentation/screens/categories_screen.dart';
// import 'package:al_omda/features/home/presentation/screens/home_screen.dart';
// import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
// import 'package:al_omda/features/products/presentation/screens/products_screen.dart';
// import 'package:al_omda/features/splash/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// GoRouter createAppRouter(Locale appLocale, ThemeData appTheme) {
//   return GoRouter(
//     initialLocation: '/',
//     routes: [
//       GoRoute(path: "/", builder: (context, state) => const SplashScreen()),
//       GoRoute(
//         path: "/onBoarding",
//         builder: (context, state) => const OnBoardingScreen(),
//       ),
//       GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
//       GoRoute(
//         path: "/register",
//         builder: (context, state) => const RegisterScreen(),
//       ),
//       GoRoute(
//         path: "/forgetPassword",
//         builder: (context, state) => const ForgetPasswordScreen(),
//       ),
//       GoRoute(path: "/home", builder: (context, state) => const HomeScreen()),
//       GoRoute(
//         path: "/categories",
//         builder: (context, state) => const CategoriesScreen(),
//       ),
//       GoRoute(
//         path: "/products",
//         builder: (context, state) => const ProductsScreen(),
//       ),
//       GoRoute(
//         path: "/accountscreen",
//         builder: (context, state) => const Accountscreen(),
//       ),
//       GoRoute(
//         path: "/accountInfoScreen",
//         builder: (context, state) => const AccountInfoScreen(),
//       ),
//     ],
//   );
// }

// app_router.dart

import 'package:flutter/material.dart';
import 'package:al_omda/features/splash/splash_screen.dart';
import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:al_omda/features/auth/presentation/screens/login_screen.dart';
import 'package:al_omda/features/auth/presentation/screens/register_screen.dart';
import 'package:al_omda/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:al_omda/features/home/presentation/screens/home_screen.dart';
import 'package:al_omda/features/categories/presentation/screens/categories_screen.dart';
import 'package:al_omda/features/products/presentation/screens/products_screen.dart';
import 'package:al_omda/features/account/presentation/screens/account_screen.dart';
import 'package:al_omda/features/account/presentation/screens/account_info_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case '/onBoarding':
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case '/forgetPassword':
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case '/categories':
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());

      case '/products':
        return MaterialPageRoute(builder: (_) => const ProductsScreen());

      case '/accountscreen':
        return MaterialPageRoute(builder: (_) => const Accountscreen());

      case '/accountInfoScreen':
        return MaterialPageRoute(builder: (_) => const AccountInfoScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

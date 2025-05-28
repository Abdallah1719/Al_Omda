import 'package:al_omda/core/routes/routes_constances.dart';
import 'package:al_omda/features/account/presentation/screens/my_addresess_screen.dart';
import 'package:al_omda/features/account/presentation/screens/my_orders_screen.dart';
import 'package:flutter/material.dart';
import 'package:al_omda/features/splash/splash_screen.dart';
import 'package:al_omda/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:al_omda/features/auth/presentation/screens/login_screen.dart';
import 'package:al_omda/features/auth/presentation/screens/register_screen.dart';
import 'package:al_omda/features/auth/presentation/screens/forget_password_screen.dart';
import 'package:al_omda/features/home/presentation/screens/home_screen.dart';
import 'package:al_omda/features/home/presentation/screens/categories_screen.dart';
import 'package:al_omda/features/products/presentation/screens/products_screen.dart';
import 'package:al_omda/features/account/presentation/screens/account_screen.dart';
import 'package:al_omda/features/account/presentation/screens/account_info_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesConstances.splashPath:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case RoutesConstances.onBoardingPath:
        return MaterialPageRoute(builder: (_) => const OnBoardingScreen());

      case RoutesConstances.loginPath:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case RoutesConstances.registerPath:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());

      case RoutesConstances.forgetPasswordPath:
        return MaterialPageRoute(builder: (_) => const ForgetPasswordScreen());

      case RoutesConstances.homePath:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case RoutesConstances.categoriesPath:
        return MaterialPageRoute(builder: (_) => const CategoriesScreen());

      case RoutesConstances.productsPath:
        return MaterialPageRoute(builder: (_) => const ProductsScreen());

      case RoutesConstances.accountPath:
        return MaterialPageRoute(builder: (_) => const Accountscreen());

      case RoutesConstances.accountInfoPath:
        return MaterialPageRoute(builder: (_) => const AccountInfoScreen());
      case RoutesConstances.myAddresessPath:
        return MaterialPageRoute(builder: (_) => const MyAddresessScreen());
      case RoutesConstances.myOrdersPath:
        return MaterialPageRoute(builder: (_) => const MyOrdersScreen());

      default:
        return MaterialPageRoute(
          builder:
              (_) =>
                  const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}

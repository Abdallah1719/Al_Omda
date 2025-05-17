import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RoutesMethods {
  // push Navigate
  static void customPushNavigate(context, String path) {
    GoRouter.of(context).push(path);
  }

  // pushReplacement Navigate
  static void customReplacementNavigate(context, String path) {
    GoRouter.of(context).pushReplacement(path);
  }

  //navigate to a new page with bottom tab bar
  static void pushNamed<T>({
    required BuildContext context,
    required String route,
    T? arguments,
  }) => context.push(route, extra: arguments as T);

  static void replaceNamed<T>({
    required BuildContext context,
    required String route,
    T? arguments,
  }) => context.pushReplacement(route, extra: arguments as T);

  static void popNamed(BuildContext context) => context.pop();
}
//pop nmaed and remove until method
/*
pushNamedAndRemoveUntil(
  context,
  route, (route) => false,
  // arguments: arguments,
) 
*/
import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RoutesMethods {
  // push Navigate
  static void customPushNavigate(context, String path) {
    print("جارٍ التنقل إلى: $path");
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
  static void pushWithCubit({
    required BuildContext context,
    required String path,
    required HomeCubit cubit,
    required Widget screen,
  }) {
    GoRouter.of(
      context,
    ).push(path, extra: BlocProvider.value(value: cubit, child: screen));
  }
}
//pop nmaed and remove until method
/*
pushNamedAndRemoveUntil(
  context,
  route, (route) => false,
  // arguments: arguments,
) 
*/
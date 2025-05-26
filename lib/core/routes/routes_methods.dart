// import 'package:al_omda/features/home/presentation/controller/cubit/home_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';

// class RoutesMethods {
//   // push Navigate
//   static void customPushNavigate(context, String path) {
//     print("جارٍ التنقل إلى: $path");
//     GoRouter.of(context).push(path);
//   }

//   // pushReplacement Navigate
//   static void customReplacementNavigate(context, String path) {
//     GoRouter.of(context).pushReplacement(path);
//   }

//   //navigate to a new page with bottom tab bar
//   static void pushNamed<T>({
//     required BuildContext context,
//     required String route,
//     T? arguments,
//   }) => context.push(route, extra: arguments as T);

//   static void replaceNamed<T>({
//     required BuildContext context,
//     required String route,
//     T? arguments,
//   }) => context.pushReplacement(route, extra: arguments as T);

//   static void popNamed(BuildContext context) => context.pop();
//   static void pushWithCubit({
//     required BuildContext context,
//     required String path,
//     required HomeCubit cubit,
//     required Widget screen,
//   }) {
//     GoRouter.of(
//       context,
//     ).push(path, extra: BlocProvider.value(value: cubit, child: screen));
//   }
// }
// //pop nmaed and remove until method
// /*
// pushNamedAndRemoveUntil(
//   context,
//   route, (route) => false,
//   // arguments: arguments,
// )
// */

import 'package:flutter/material.dart';

class RoutesMethods {
  // ✅ التنقل العادي (push)
  static void pushNavigate(BuildContext context, String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  // ✅ التنقل مع استبدال الصفحة الحالية (pushReplacement)
  static void replacementNavigate(BuildContext context, String routeName) {
    Navigator.pushReplacementNamed(context, routeName);
  }

  // ✅ التنقل مع إزالة جميع الصفحات السابقة (pushAndRemoveUntil)
  static void pushAndRemoveUntil(BuildContext context, String routeName) {
    Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
  }

  // ✅ العودة إلى الصفحة السابقة (pop)
  static void pop(BuildContext context) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
  }

  // ✅ التنقل مع تمرير بيانات (arguments)
  static void pushNamedWithArgs<T>({
    required BuildContext context,
    required String routeName,
    T? arguments,
  }) {
    Navigator.pushNamed(context, routeName, arguments: arguments);
  }

  // ✅ استرجاع البيانات في الصفحة الجديدة
  static T? getArgs<T>(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is T) {
      return arguments;
    }
    return null;
  }

  // ✅ التنقل مع توفير Cubit خاص بالصفحة (إذا لزم الأمر)
  static void pushWithCubit({
    required BuildContext context,
    required String routeName,
    required Widget screen,
  }) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  // ✅ التنقل مع استبدال الصفحة الحالية وتوفير بيانات
  static void replaceWithArgs<T>({
    required BuildContext context,
    required String routeName,
    T? arguments,
  }) {
    Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
  }
}

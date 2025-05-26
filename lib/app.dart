// import 'package:al_omda/core/routes/app_router.dart';
// import 'package:al_omda/core/theme/cubit/theme_cubit.dart';
// import 'package:al_omda/core/utils/size_config.dart';
// import 'package:al_omda/features/splash/splash_screen.dart';
// import 'package:al_omda/generated/l10n.dart';
// import 'package:al_omda/l10n/cubit/locale_cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AlOmda extends StatelessWidget {
//   const AlOmda({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(create: (context) => LocaleCubit()..loadSavedLocale()),
//         BlocProvider(create: (context) => ThemeCubit()..loadSavedTheme()),
//       ],
//       child: BlocBuilder<LocaleCubit, String>(
//         builder: (context, localeState) {
//           return BlocBuilder<ThemeCubit, ThemeState>(
//             builder: (context, state) {
//               if (state is! LoadSavedState) {
//                 return const SplashScreen();
//               }

//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         // routerConfig: router,
//         localizationsDelegates: LocaleCubit.localizationsDelegates,
//         supportedLocales: S.delegate.supportedLocales,
//         locale: Locale(localeState),
//         theme: ,
//         home: const SplashScreen(),
//          onGenerateRoute: AppRouter.generateRoute,

// // // import 'package:al_omda/core/routes/app_router.dart';
// // // import 'package:al_omda/core/theme/cubit/theme_cubit.dart';
// // // import 'package:al_omda/core/utils/size_config.dart';
// // // import 'package:al_omda/features/splash/splash_screen.dart';
// // // import 'package:al_omda/generated/l10n.dart';
// // // import 'package:al_omda/l10n/cubit/local_cubit.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_bloc/flutter_bloc.dart';

// // // class AlOmda extends StatelessWidget {
// // //   const AlOmda({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     SizeConfig().init(context);

// // //     return MultiBlocProvider(
// // //       providers: [
// // //         BlocProvider(create: (context) => LocaleCubit()..loadSavedLocale()),
// // //         BlocProvider(create: (context) => ThemeCubit()..loadSavedTheme()),
// // //       ],
// // //       child: const AppContent(),
// // //     );
// // //   }
// // // }

// // // class AppContent extends StatelessWidget {
// // //   const AppContent({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final themeState = context.watch<ThemeCubit>().state;
// // //     final localeState = context.watch<LocaleCubit>().state;

// // //     if (themeState is! LoadSavedState || localeState is! LoadSavedLocaleState) {
// // //       return const MaterialApp(home: SplashScreen());
// // //     }

// // //     final currentTheme = themeState.themeData;
// // //     final appRouter = createAppRouter(Locale(localeState.locale), currentTheme);

// // //     return MaterialApp.router(
// // //       debugShowCheckedModeBanner: false,
// // //       routerConfig: appRouter,
// // //       localizationsDelegates:LocaleCubit.localizationsDelegates,
// // //       supportedLocales: S.delegate.supportedLocales,
// // //       locale: Locale(localeState.locale),
// // //       theme: currentTheme,
// // //     );
// // //   }
// // // }

// // import 'package:al_omda/core/routes/app_router.dart';
// // import 'package:al_omda/core/theme/cubit/theme_cubit.dart';
// // import 'package:al_omda/core/utils/size_config.dart';
// // import 'package:al_omda/features/splash/splash_screen.dart';
// // import 'package:al_omda/generated/l10n.dart';
// // import 'package:al_omda/l10n/cubit/local_cubit.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_bloc/flutter_bloc.dart';

// // class AlOmda extends StatelessWidget {
// //   const AlOmda({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     SizeConfig().init(context);

// //     return MultiBlocProvider(
// //       providers: [
// //         BlocProvider(create: (context) => LocaleCubit()..loadSavedLocale()),
// //         BlocProvider(create: (context) => ThemeCubit()..loadSavedTheme()),
// //       ],
// //       child: const AppContent(),
// //     );
// //   }
// // }

// // // class AppContent extends StatelessWidget {
// // //   const AppContent({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final themeState = context.watch<ThemeCubit>().state;
// // //     final localeState = context.watch<LocaleCubit>().state;

// // //     // التأكد من أن البيانات تم تحميلها
// // //     if (themeState is! LoadSavedState || localeState is! LoadSavedLocaleState) {
// // //       return const MaterialApp(home: SplashScreen());
// // //     }

// // //     final currentTheme = themeState.themeData;
// // //     final appRouter = createAppRouter(Locale(localeState.locale), currentTheme);

// // //     return MaterialApp.router(
// // //       debugShowCheckedModeBanner: false,
// // //       routerConfig: appRouter,
// // //       localizationsDelegates: LocaleCubit.localizationsDelegates,
// // //       supportedLocales: S.delegate.supportedLocales,
// // //       locale: Locale(localeState.locale),
// // //       theme: currentTheme,
// // //     );
// // //   }
// // // }

// // class AppContent extends StatelessWidget {
// //   const AppContent({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return BlocBuilder<ThemeCubit, ThemeState>(
// //       builder: (context, themeState) {
// //         return BlocBuilder<LocaleCubit, LocaleState>(
// //           builder: (context, localeState) {
// //             if (themeState is! LoadSavedState ||
// //                 localeState is! LoadSavedLocaleState) {
// //               print("ThemeState: $themeState | LocaleState: $localeState");
// //               return const MaterialApp(home: SplashScreen());
// //             }

// //             final currentTheme = themeState.themeData;
// //             final currentLocale = Locale(localeState.locale);
// //             final appRouter = createAppRouter(currentLocale, currentTheme);

// //             return MaterialApp.router(
// //               debugShowCheckedModeBanner: false,
// //               routerConfig: appRouter,
// //               localizationsDelegates: LocaleCubit.localizationsDelegates,
// //               supportedLocales: S.delegate.supportedLocales,
// //               locale: currentLocale,
// //               theme: currentTheme,
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// // }

// main.dart

import 'package:al_omda/core/routes/app_router.dart';
import 'package:al_omda/features/splash/splash_screen.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:al_omda/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/cubit/theme_cubit.dart';

class AlOmda extends StatelessWidget {
  const AlOmda({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleCubit, LocaleState>(
          builder: (context, localeState) {
            if (themeState is! LoadSavedState ||
                localeState is! LoadSavedLocaleState) {
              return const MaterialApp(home: SplashScreen());
            }

            final currentTheme = themeState.themeData;
            final currentLocale = Locale(localeState.locale);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Al Omda',
              locale: currentLocale,
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              theme: currentTheme,
              home: const SplashScreen(),
              onGenerateRoute:
                  AppRouter.generateRoute, // ✅ هنا تم استخدام AppRouter
            );
          },
        );
      },
    );
  }
}

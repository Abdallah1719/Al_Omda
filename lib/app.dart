import 'package:al_omda/core/routes/app_router.dart';
import 'package:al_omda/core/theme/cubit/theme_cubit.dart';
import 'package:al_omda/core/utils/size_config.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:al_omda/l10n/cubit/local_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlOmda extends StatelessWidget {
  const AlOmda({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit()..loadSavedLocale()),
        BlocProvider(create: (context) => ThemeCubit()..loadSavedTheme()),
      ],
      // child: BlocBuilder<LocaleCubit, String>(
      //   builder: (context, localeState) {
      //     return BlocBuilder<ThemeCubit, ThemeState>(
      //       builder: (context, state) {
      //         if (state is! LoadSavedState) {
      //           return const SplashScreen();
      //         }
      //         final currentTheme = (context.read<ThemeCubit>().currentTheme());
      //         final router = createAppRouter(Locale(localeState), currentTheme);
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        localizationsDelegates: LocaleCubit.localizationsDelegates,
        supportedLocales: S.delegate.supportedLocales,
        // locale: Locale(localeState),
        // theme: currentTheme,
      ),
    );
  }
}

import 'package:al_omda/core/routes/app_router.dart';
import 'package:al_omda/core/utils/size_config.dart';
import 'package:al_omda/features/splash/splash_screen.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:al_omda/l10n/cubit/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/cubit/theme_cubit.dart';

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
      child: BlocBuilder<LocaleCubit, String>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              if (state is LoadSavedState) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Al Omda',
                  supportedLocales: S.delegate.supportedLocales,
                  localizationsDelegates: LocaleCubit.localizationsDelegates,
                  locale: Locale(locale.isNotEmpty ? locale : 'en'),
                  theme: context.read<ThemeCubit>().currentTheme(),
                  home: const SplashScreen(),
                  onGenerateRoute: AppRouter.generateRoute,
                );
              } else {
                return const MaterialApp(home: SplashScreen());
              }
            },
          );
        },
      ),
    );
  }
}

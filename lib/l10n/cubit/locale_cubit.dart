import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class LocaleCubit extends Cubit<String> {
  LocaleCubit() : super('en');

  static List<LocalizationsDelegate> localizationsDelegates = [
    S.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  static bool isArabic() {
    return Intl.getCurrentLocale() == 'ar';
  }

  void toggleLocale() async {
    final newLocale = state == 'en' ? 'ar' : 'en';
    await getIt<CacheHelper>().saveData(key: 'locale', value: newLocale);
    emit(newLocale);
  }

  void loadSavedLocale() async {
    final savedLocale =
        await getIt<CacheHelper>().getData(key: 'locale') ?? 'en';
    emit(savedLocale);
  }
}

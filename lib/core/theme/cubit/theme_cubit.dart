import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeInitial());

  bool lightMode = true;
  toggleTheme() async {
    lightMode ? lightMode = false : lightMode = true;
    await CacheHelper().saveData(key: 'lightMode', value: lightMode);
    emit(ThemeMode());
  }

  ThemeData currentTheme() {
    return lightMode ? AppTheme.lightMode : AppTheme.darkMode;
  }

  void loadSavedTheme() async {
    lightMode = await CacheHelper().getData(key: 'lightMode') ?? true;
    emit(LoadSavedState());
  }
}

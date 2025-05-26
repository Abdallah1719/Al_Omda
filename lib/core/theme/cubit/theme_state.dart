// part of 'theme_cubit.dart';

// @immutable
// sealed class ThemeState {}

// final class ThemeInitial extends ThemeState {}

// final class ThemeMode extends ThemeState {}

// final class LoadSavedState extends ThemeState {}
part of 'theme_cubit.dart';

@immutable
abstract class ThemeState {}

class ThemeInitial extends ThemeState {}

class ThemeLoading extends ThemeState {}

class ThemeLoaded extends ThemeState {
  final ThemeData themeData;

  ThemeLoaded(this.themeData);
}

class LoadSavedState extends ThemeState {
  final ThemeData themeData;

  LoadSavedState(this.themeData);
}

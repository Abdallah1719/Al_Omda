// // part of 'local_cubit.dart';

// // abstract class LocaleState {}

// // class LocaleInitial extends LocaleState {}

// // class LocaleLoaded extends LocaleState {
// //   final String locale;

// //   LocaleLoaded(this.locale);
// // }

// // locale_state.dart
// part of 'local_cubit.dart';

// @immutable
// abstract class LocaleState {}

// class LocaleInitial extends LocaleState {}

// class LoadSavedLocaleState extends LocaleState {
//   final String locale;

//   LoadSavedLocaleState(this.locale);
// }
part of 'locale_cubit.dart';

@immutable
abstract class LocaleState {}

class LocaleInitial extends LocaleState {}

class LocaleLoading extends LocaleState {}

class LoadSavedLocaleState extends LocaleState {
  final String locale;

  LoadSavedLocaleState(this.locale);
}

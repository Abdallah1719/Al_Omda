part of 'auth_cubit.dart';

class LoginState {}

final class LoginInitial extends LoginState {}

final class Loginlodding extends LoginState {}

final class Loginsucess extends LoginState {}

final class Loginfailure extends LoginState {
  final String errorMassage;

  Loginfailure({required this.errorMassage});
}

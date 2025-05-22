part of 'auth_cubit.dart';

class AuthState {}

final class AuthInitial extends AuthState {}

final class Loginlodding extends AuthState {}

final class Loginsucess extends AuthState {}

final class Loginfailure extends AuthState {
  final String errorMassage;

  Loginfailure({required this.errorMassage});
}

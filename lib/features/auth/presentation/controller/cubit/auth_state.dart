part of 'auth_cubit.dart';

class AuthState {}

final class AuthInitial extends AuthState {}
final class Authlodding extends AuthState {}
final class AuthFailure extends AuthState {
  final String errorMassage;

  AuthFailure({required this.errorMassage});
}
final class Loginsucess extends AuthState {}
class LogoutSuccess extends AuthState {}


part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final AccountInfoModel account;

  AccountSuccess(this.account);
}

class AccountError extends AccountState {
  final String message;

  AccountError(this.message);
}

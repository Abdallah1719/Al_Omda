part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountSuccess extends AccountState {
  final AccountInfoModel account;

  AccountSuccess(this.account);
}

class MyAddresessSuccess extends AccountState {
  final MyAddresessList myAddresessList;
  MyAddresessSuccess(this.myAddresessList);
}

class MyOrdersSuccess extends AccountState {
  final MyOrdersList myOrdersList;
  MyOrdersSuccess(this.myOrdersList);
}

class AccountError extends AccountState {
  final String message;

  AccountError(this.message);
}

class AccountEditing extends AccountState {
  final AccountInfoModel account;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;

  AccountEditing({
    required this.account,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
  });
}

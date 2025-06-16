part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountInfoLoaded extends AccountState {
  final AccountInfoModel accountInfo;
  AccountInfoLoaded(this.accountInfo);
}

class MyAddressesLoaded extends AccountState {
  final List<MyAddresessModel> myAddresessList;
  MyAddressesLoaded(this.myAddresessList);
}

class MyOrdersLoaded extends AccountState {
  final MyOrdersList myOrdersList;
  MyOrdersLoaded(this.myOrdersList);
}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}

part of 'account_cubit.dart';

abstract class AccountState {}

// Account Stat
class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountError extends AccountState {
  final String message;
  AccountError(this.message);
}

// Account Info State
class AccountInfoLoaded extends AccountState {
  final AccountInfoModel accountInfo;
  AccountInfoLoaded(this.accountInfo);
}

// MyAddresses State
class MyAddressesLoaded extends AccountState {
  final List<MyAddresessModel> myAddresessList;
  MyAddressesLoaded(this.myAddresessList);
}

// MyOrders State
class MyOrdersLoaded extends AccountState {
  final List<MyOrdersModel> myOrdersList;
  MyOrdersLoaded(this.myOrdersList);
}

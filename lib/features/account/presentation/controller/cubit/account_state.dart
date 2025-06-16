// part of 'account_cubit.dart';

// abstract class AccountState {}

// class AccountInitial extends AccountState {}

// class AccountLoading extends AccountState {}

// class AccountInfoSuccess extends AccountState {
//   final AccountInfoModel accountInfo;
//   AccountInfoSuccess(this.accountInfo);
// }

// class MyAddresessSuccess extends AccountState {
//   final MyAddresessList myAddresessList;
//   MyAddresessSuccess(this.myAddresessList);
// }

// class MyOrdersSuccess extends AccountState {
//   final MyOrdersList myOrdersList;
//   MyOrdersSuccess(this.myOrdersList);
// }

// class AccountError extends AccountState {
//   final String message;
//   AccountError(this.message);
// }

// class AccountInfoEditing extends AccountState {
//   final AccountInfoModel accountInfo;
//   final TextEditingController firstNameController;
//   final TextEditingController lastNameController;
//   final TextEditingController emailController;

//   AccountInfoEditing({
//     required this.accountInfo,
//     required this.firstNameController,
//     required this.lastNameController,
//     required this.emailController,
//   });
// }

// States مبسطة
part of 'account_cubit.dart';

abstract class AccountState {}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountInfoLoaded extends AccountState {
  final AccountInfoModel accountInfo;
  AccountInfoLoaded(this.accountInfo);
}

class MyAddressesLoaded extends AccountState {
  final MyAddresessList myAddresessList;
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
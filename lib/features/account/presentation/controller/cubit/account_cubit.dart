import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:al_omda/features/account/data/models/my_orders_model.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final BaseAccountRepository baseAccountRepository;
  AccountCubit(this.baseAccountRepository) : super(AccountInitial());
  // Account Info
  Future<void> getAccountInfo() async {
    emit(AccountLoading());
    final result = await baseAccountRepository.getAccountInfo();
    result.fold(
      (error) => emit(AccountError(error)),
      (accountInfo) => emit(AccountInfoLoaded(accountInfo)),
    );
  }
  // Edit Account Info
  Future<void> updateAccountInfo({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    if (firstName.trim().isEmpty) {
      emit(AccountError('First Name Required'));
      return;
    }
    if (lastName.trim().isEmpty) {
      emit(AccountError(' Last Name Required'));
      return;
    }
    if (email.trim().isEmpty || !email.contains('@')) {
      emit(AccountError('Email Required'));
      return;
    }
    emit(AccountLoading());
    final formData = {
      "firstName": firstName.trim(),
      "lastName": lastName.trim(),
      "email": email.trim(),
    };
    final result = await baseAccountRepository.updateAccountInfo(formData);
    result.fold(
      (error) => emit(AccountError(error)),
      (updatedAccountInfo) => emit(AccountInfoLoaded(updatedAccountInfo)),
    );
  }

  // My Addresess List
  Future<void> getMyAddresess() async {
    emit(AccountLoading());
    final result = await baseAccountRepository.getMyAddresess();
    result.fold(
      (error) => emit(AccountError(error)),
      (addresses) => emit(MyAddressesLoaded(addresses)),
    );
  }

  // My Orders List
  Future<void> getOrders() async {
    emit(AccountLoading());
    final result = await baseAccountRepository.getMyOrders();
    result.fold(
      (error) => emit(AccountError(error)),
      (orders) => emit(MyOrdersLoaded(orders)),
    );
  }
}

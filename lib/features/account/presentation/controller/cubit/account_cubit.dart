import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:al_omda/features/account/data/models/my_orders_model.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final BaseAccountRepository baseAccountRepository;
  AccountCubit(this.baseAccountRepository) : super(AccountInitial());

  Future<void> getAccountInfo() async {
    emit(AccountLoading());

    final result = await baseAccountRepository.getAccountInfo();
    result.fold(
      (error) => emit(AccountError(error)),
      (accountInfo) => emit(AccountInfoLoaded(accountInfo)),
    );
  }

  Future<void> updateAccountInfo({
    required String firstName,
    required String lastName,
    required String email,
  }) async {
    if (firstName.trim().isEmpty) {
      emit(AccountError('الاسم الأول مطلوب'));
      return;
    }
    if (lastName.trim().isEmpty) {
      emit(AccountError('الاسم الأخير مطلوب'));
      return;
    }
    if (email.trim().isEmpty || !email.contains('@')) {
      emit(AccountError('بريد إلكتروني غير صحيح'));
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

  Future<void> getMyAddresess() async {
    emit(AccountLoading());

    try {
      final result = await baseAccountRepository.getMyAddresess();
      result.fold((error) => emit(AccountError(error)), (
        List<MyAddresessModel> addresses,
      ) {
        final myAddresessList = MyAddresessList(
          addresses: addresses,
        ); // ← هنا نستخدم اللست مباشرة
        emit(MyAddressesLoaded(myAddresessList));
      });
    } catch (e) {
      emit(AccountError('حدث خطأ غير متوقع'));
    }
  }

  Future<void> getOrders() async {
    emit(AccountLoading());

    try {
      final result = await baseAccountRepository.getMyOrders();
      result.fold((error) => emit(AccountError(error)), (
        List<MyOrdersModel> orders,
      ) {
        final myOrdersList = MyOrdersList(
          orders: orders,
        ); // ← هنا نستخدم اللست مباشرة
        emit(MyOrdersLoaded(myOrdersList));
      });
    } catch (e) {
      emit(AccountError('حدث خطأ غير متوقع'));
    }
  }
}

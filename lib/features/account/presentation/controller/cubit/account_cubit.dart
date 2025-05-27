import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  final BaseAccountRepository baseAccountRepository;

  AccountCubit(this.baseAccountRepository) : super(AccountInitial());

  Future<void> getAccountInfo() async {
    emit(AccountLoading());

    try {
      final result = await baseAccountRepository.getAccountInfo();
      result.fold(
        (error) => emit(AccountError(error)),
        (account) => emit(AccountSuccess(account)),
      );
    } catch (e) {
      emit(AccountError('حدث خطأ غير متوقع'));
    }
  }

  void navigateToEditScreen() {
    final state = this.state;
    print('Current State in navigateToEditScreen: $state'); // <-- print جديد

    if (state is AccountSuccess) {
      print('navigateToEditScreen: state is AccountSuccess'); // ✅ تم التحقق

      final account = state.account;

      final firstNameCtrl = TextEditingController(text: account.firstName);
      final lastNameCtrl = TextEditingController(text: account.lastName);
      final emailCtrl = TextEditingController(text: account.email);

      emit(
        AccountEditing(
          account: account,
          firstNameController: firstNameCtrl,
          lastNameController: lastNameCtrl,
          emailController: emailCtrl,
        ),
      );
    } else {
      print(
        'navigateToEditScreen: state is NOT AccountSuccess',
      ); // ❌ مش AccountSuccess
    }
  }

  Future<void> updateProfileInfo({
    required TextEditingController firstNameController,
    required TextEditingController lastNameController,
    required TextEditingController emailController,
  }) async {
    emit(AccountLoading());

    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();

    if (firstName.isEmpty) {
      emit(AccountError('الاسم الأول مطلوب'));
      return;
    }

    if (lastName.isEmpty) {
      emit(AccountError('الاسم الأخير مطلوب'));
      return;
    }

    if (email.isEmpty || !email.contains('@')) {
      emit(AccountError('بريد إلكتروني غير صحيح'));
      return;
    }

    final formData = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
    };

    print("Form Data Being Sent: $formData"); // <-- مهم جداً

    try {
      final result = await baseAccountRepository.updateAccountInfo(formData);
      result.fold(
        (error) => emit(AccountError(error)),
        (updatedAccount) => emit(AccountSuccess(updatedAccount)),
      );
    } catch (e) {
      emit(AccountError('فشل في تحديث البيانات'));
    }
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
        emit(MyAddresessSuccess(myAddresessList));
      });
    } catch (e) {
      emit(AccountError('حدث خطأ غير متوقع'));
    }
  }
}

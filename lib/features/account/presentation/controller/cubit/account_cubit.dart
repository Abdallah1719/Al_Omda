import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
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
}

import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
import 'package:dartz/dartz.dart';

class AccountRepository implements BaseAccountRepository {
  final ApiMethods api;

  AccountRepository(this.api);

  @override
  Future<Either<String, AccountInfoModel>> getAccountInfo() async {
    try {
      final response = await api.post(ApiConstances.accountInfoPath);
      final account = AccountInfoModel.fromJson(response);
      return Right(account);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}

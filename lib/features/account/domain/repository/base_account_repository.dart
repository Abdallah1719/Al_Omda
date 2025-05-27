import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAccountRepository {
  Future<Either<String, AccountInfoModel>> getAccountInfo();
  Future<Either<String, AccountInfoModel>> updateAccountInfo(
    Map<String, dynamic> data,
  );
  Future<Either<String, List<MyAddresessModel>>> getMyAddresess();
}

import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAccountRepository {
  Future<Either<String, AccountInfoModel>> getAccountInfo();
}

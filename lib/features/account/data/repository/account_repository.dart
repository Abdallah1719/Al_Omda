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

  @override
  Future<Either<String, AccountInfoModel>> updateAccountInfo(
    Map<String, dynamic> data,
  ) async {
    try {
      // --- التحقق من البيانات ---
      if (data['firstName'] == null ||
          data['firstName'].toString().trim().isEmpty) {
        return Left("الاسم الأول مطلوب");
      }
      if (data['lastName'] == null ||
          data['lastName'].toString().trim().isEmpty) {
        return Left("الاسم الأخير مطلوب");
      }
      if (data['email'] == null || data['email'].toString().trim().isEmpty) {
        return Left("البريد الإلكتروني مطلوب");
      } else if (!data['email'].toString().contains('@')) {
        return Left("البريد الإلكتروني غير صحيح");
      }

      // --- طباعة البيانات ---
      print("Form Data Being Sent: $data");

      // --- إرسال البيانات ---
      final response = await api.post(
        ApiConstances.updateProfilePath,
        data: data,
        isFormData: true,
      );

      final userData = response['data']['user'];
      return Right(AccountInfoModel.fromJson(userData));
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}

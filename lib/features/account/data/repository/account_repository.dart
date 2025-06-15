import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/features/account/data/models/account_info_model.dart';
import 'package:al_omda/features/account/data/models/my_addresess_model.dart';
import 'package:al_omda/features/account/data/models/my_orders_model.dart';
import 'package:al_omda/features/account/domain/repository/base_account_repository.dart';
import 'package:dartz/dartz.dart';

class AccountRepository implements BaseAccountRepository {
  final ApiMethods api;
  AccountRepository(this.api);
  @override
  Future<Either<String, AccountInfoModel>> getAccountInfo() async {
    try {
      final response = await api.post(ApiConstances.accountInfoPath);
      final accountInfo = AccountInfoModel.fromJson(response);
      return Right(accountInfo);
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

  @override
  Future<Either<String, List<MyAddresessModel>>> getMyAddresess() async {
    try {
      final response = await api.get(ApiConstances.myAddressesPath);

      // التأكد من أن الـ response هو Map<String, dynamic>
      if (response is Map<String, dynamic>) {
        final dataList = response['data'] as List?;

        if (dataList != null && dataList.isNotEmpty) {
          final List<MyAddresessModel> addresses =
              dataList
                  .map(
                    (item) =>
                        MyAddresessModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList();

          return Right(addresses);
        } else {
          return Left("لا توجد بيانات لعرضها");
        }
      } else {
        return Left("البيانات المستلمة ليست بالشكل المتوقع");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left("حدث خطأ غير متوقع: $e");
    }
  }

  @override
  Future<Either<String, List<MyOrdersModel>>> getMyOrders() async {
    try {
      final response = await api.get(ApiConstances.myOrdersPath);

      // التأكد من أن الـ response هو Map<String, dynamic>
      if (response is Map<String, dynamic>) {
        final dataList = response['data'] as List?;

        if (dataList != null && dataList.isNotEmpty) {
          final List<MyOrdersModel> orders =
              dataList
                  .map(
                    (item) =>
                        MyOrdersModel.fromJson(item as Map<String, dynamic>),
                  )
                  .toList();

          return Right(orders);
        } else {
          return Left("لا توجد بيانات لعرضها");
        }
      } else {
        return Left("البيانات المستلمة ليست بالشكل المتوقع");
      }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left("حدث خطأ غير متوقع: $e");
    }
  }
}

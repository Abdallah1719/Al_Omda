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

  // Account Info
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

  // Edit Account Info
  @override
  Future<Either<String, AccountInfoModel>> updateAccountInfo(
    Map<String, dynamic> data,
  ) async {
    try {
      await api.post(
        ApiConstances.updateProfilePath,
        data: data,
        isFormData: true,
      );
      final accountResponse = await api.post(ApiConstances.accountInfoPath);
      final accountInfo = AccountInfoModel.fromJson(accountResponse);
      return Right(accountInfo);
      // }
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  // My Addresess List
  @override
  Future<Either<String, List<MyAddresessModel>>> getMyAddresess() async {
    try {
      final response = await api.get(ApiConstances.myAddressesPath);
      final dataList = response['data'] as List;
      final List<MyAddresessModel> addressesList =
          dataList
              .map(
                (item) =>
                    MyAddresessModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return Right(addressesList);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  // My Orders List
  @override
  Future<Either<String, List<MyOrdersModel>>> getMyOrders() async {
    try {
      final response = await api.get(ApiConstances.myOrdersPath);
      final dataList = response['data'] as List;
      final List<MyOrdersModel> ordersList =
          dataList
              .map(
                (item) => MyOrdersModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return Right(ordersList);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }
}

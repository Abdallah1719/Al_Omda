import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:dio/dio.dart';

abstract class BaseLoginDataSource {
  Future loginUser({
    required final String mobile,
    required final String password,
  });
}

class LoginDataSource extends BaseLoginDataSource {
  final ApiMethods api;

  LoginDataSource(this.api);

  @override
  Future loginUser({required String mobile, required String password}) async {
    try {
      final response = await api.post(
        ApiConstances.loginPath,
        data: {'mobile': mobile, 'password': password},
      );
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }
}

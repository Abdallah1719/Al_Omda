import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/core/error/failure.dart';
import 'package:al_omda/features/auth/domain/entities/login.dart';
import 'package:al_omda/features/auth/domain/repository/base_login_repository.dart';
import 'package:dartz/dartz.dart';

class LoginRepository implements BaseLoginRepository {
  final ApiMethods api;

  LoginRepository({required this.api});
  @override
  Future<Either<Failure, Login>> loginUser({
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await api.post(
        ApiConstances.loginPath,
        data: {'mobile': mobile, 'password': password},
      );
      return Right(response);
    } on ServerException catch (e) {
      return left(e.errorMessageModel.statusMessage);
    }
  }
}

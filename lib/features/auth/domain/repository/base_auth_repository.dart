import 'package:al_omda/features/auth/data/models/login_model.dart';
import 'package:dartz/dartz.dart';

abstract class BaseAuthRepository {
  Future<Either<String, LoginModel>> loginUser({
    required String mobile,
    required String password,
  });
    Future<Either<String, String>> logoutUser();
}

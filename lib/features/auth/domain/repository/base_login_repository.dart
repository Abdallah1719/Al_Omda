import 'package:al_omda/core/error/failure.dart';
import 'package:al_omda/features/auth/domain/entities/login.dart';
import 'package:dartz/dartz.dart';

abstract class BaseLoginRepository {
  Future<Either<Failure, Login>> loginUser({
    required String mobile,
    required String password,
  });
}

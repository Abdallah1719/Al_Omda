import 'package:al_omda/core/api/api_constances.dart';
import 'package:al_omda/core/api/api_methods.dart';
import 'package:al_omda/core/error/exception.dart';
import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:al_omda/features/auth/data/models/login_model.dart';
import 'package:al_omda/features/auth/domain/repository/base_auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepository implements BaseAuthRepository {
  final ApiMethods api;

  AuthRepository(this.api);
  @override
  Future<Either<String, LoginModel>> loginUser({
    required String mobile,
    required String password,
  }) async {
    try {
      final response = await api.post(
        ApiConstances.loginPath,
        data: {'mobile': mobile, 'password': password},
      );
      final user = LoginModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(user.token);
      getIt<CacheHelper>().saveData(key: "token", value: user.token);
      getIt<CacheHelper>().saveData(key: "prv", value: decodedToken["prv"]);
      return Right(user);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
   @override
  Future<Either<String, String>> logoutUser() async {
    try {
      final token = getIt<CacheHelper>().getData(key: "token");
      if (token != null) {
        await api.post(
          ApiConstances.logoutPath, 
        );
      }
      
      // مسح البيانات من الكاش
      await getIt<CacheHelper>().removeData(key: "token");
      await getIt<CacheHelper>().removeData(key: "prv");
      
      return const Right("تم تسجيل الخروج بنجاح");
    } on ServerException catch (e) {
      // حتى لو فشل طلب السيرفر، امسح البيانات المحلية
      await getIt<CacheHelper>().removeData(key: "token");
      await getIt<CacheHelper>().removeData(key: "prv");
      return left(e.errorModel.errorMessage);
    } catch (e) {
      // في حالة أي خطأ آخر، امسح البيانات المحلية
      await getIt<CacheHelper>().removeData(key: "token");
      await getIt<CacheHelper>().removeData(key: "prv");
      return const Right("تم تسجيل الخروج بنجاح");
    }
  }
}


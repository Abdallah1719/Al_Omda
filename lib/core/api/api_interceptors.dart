import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['lang'] = 'en';
    final token = getIt<CacheHelper>().getData(key: "token");
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

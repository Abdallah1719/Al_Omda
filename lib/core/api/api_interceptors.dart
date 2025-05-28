import 'package:al_omda/core/local_data_source/cache_helper.dart';
import 'package:al_omda/core/services/service_locator.dart';
import 'package:dio/dio.dart';

class ApiInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final locale = await getIt<CacheHelper>().getData(key: "locale") ?? 'en';

    // ← تعديل هنا: نضيف اللغة في الـ Query Parameter
    options.queryParameters['lang'] = locale;
    // final locale = await getIt<CacheHelper>().getData(key: "locale") ?? 'en';
    // if (locale != null) {
    //   options.headers['lang'] = locale;
    // }
    final token = getIt<CacheHelper>().getData(key: "token");
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}

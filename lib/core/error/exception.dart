// import 'package:al_omda/core/error/error_message_model.dart';
// import 'package:dio/dio.dart';

// class ServerException implements Exception {
//   final ErrorModel errorModel;

//   const ServerException({required this.errorModel});
// }

// void handleDioExceptions(DioException e) {
//   final ErrorModel defaultError = ErrorModel(
//     errorMessage: e.message ?? 'There is something wrong',
//   );
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//     case DioExceptionType.sendTimeout:
//     case DioExceptionType.receiveTimeout:
//     case DioExceptionType.badCertificate:
//     case DioExceptionType.cancel:
//     case DioExceptionType.connectionError:
//     case DioExceptionType.unknown:
//       final data = e.response?.data;
//       final errorModel = _getErrorModel(data, defaultError);
//       throw ServerException(errorModel: errorModel);

//     case DioExceptionType.badResponse:
//       if (e.response != null) {
//         final data = e.response!.data;
//         final errorModel = _getErrorModel(data, defaultError);
//         throw ServerException(errorModel: errorModel);
//       } else {
//         throw ServerException(errorModel: defaultError);
//       }
//   }
// }

// ErrorModel _getErrorModel(dynamic data, ErrorModel fallback) {
//   if (data is Map<String, dynamic>) {
//     return ErrorModel.fromJson(data);
//   }
//   return fallback;
// }

// extension ListExtensions on List {
//   T? firstWhereOrNull<T>(bool Function(T element) test) {
//     for (var element in this) {
//       if (test(element)) return element as T;
//     }
//     return null;
//   }
// }

import 'package:al_omda/core/error/error_message_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  const ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.sendTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.badCertificate:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.cancel:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.connectionError:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.unknown:
      throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
        case 401: //unauthorized
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
        case 403: //forbidden
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
        case 404: //not found
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
        case 409: //cofficient
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
        case 422: //  Unprocessable Entity
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
        case 504: // Server exception
          throw ServerException(
            errorModel: ErrorModel.fromJson(e.response?.data),
          );
      }
  }
}
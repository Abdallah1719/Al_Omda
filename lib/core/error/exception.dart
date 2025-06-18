// import 'package:al_omda/core/error/error_message_model.dart';
// import 'package:dio/dio.dart';

// class ServerException implements Exception {
//   final ErrorModel errorModel;

//   const ServerException({required this.errorModel});
// }

// void handleDioExceptions(DioException e) {
//   switch (e.type) {
//     case DioExceptionType.connectionTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.sendTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.receiveTimeout:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.badCertificate:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.cancel:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.connectionError:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.unknown:
//       throw ServerException(errorModel: ErrorModel.fromJson(e.response?.data));
//     case DioExceptionType.badResponse:
//       switch (e.response?.statusCode) {
//         case 400: // Bad request
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 401: //unauthorized
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 403: //forbidden
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 404: //not found
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 409: //cofficient
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 422: //  Unprocessable Entity
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//         case 504: // Server exception
//           throw ServerException(
//             errorModel: ErrorModel.fromJson(e.response?.data),
//           );
//       }
//   }
// }

import 'package:al_omda/core/error/error_message_model.dart';
import 'package:dio/dio.dart';

class ServerException implements Exception {
  final ErrorModel errorModel;

  const ServerException({required this.errorModel});
}

void handleDioExceptions(DioException e) {
  // Helper function to create default error model when response is null
  ErrorModel createDefaultErrorModel(String defaultMessage) {
    // Create default ErrorModel - modify this according to your ErrorModel structure
    return ErrorModel(
      errorMessage: defaultMessage,
      // Add any other required properties for your ErrorModel
    );
  }

  // Helper function to safely extract error model from response
  ErrorModel extractErrorModel(Response? response, String fallbackMessage) {
    if (response?.data != null) {
      try {
        return ErrorModel.fromJson(response!.data);
      } catch (e) {
        // In case of JSON parsing failure
        return createDefaultErrorModel(fallbackMessage);
      }
    }
    return createDefaultErrorModel(fallbackMessage);
  }

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(
        errorModel: extractErrorModel(
          e.response,
          "Connection timeout. Please check your internet connection and try again",
        ),
      );

    case DioExceptionType.sendTimeout:
      throw ServerException(
        errorModel: extractErrorModel(
          e.response,
          "Send timeout. Please try again",
        ),
      );

    case DioExceptionType.receiveTimeout:
      throw ServerException(
        errorModel: extractErrorModel(
          e.response,
          "Receive timeout. Please try again",
        ),
      );

    case DioExceptionType.badCertificate:
      throw ServerException(
        errorModel: extractErrorModel(
          e.response,
          "Bad certificate. Please try again later",
        ),
      );

    case DioExceptionType.cancel:
      throw ServerException(
        errorModel: extractErrorModel(e.response, "Request was cancelled"),
      );

    case DioExceptionType.connectionError:
      throw ServerException(
        errorModel: extractErrorModel(
          e.response,
          "Connection error. Please check your internet connection",
        ),
      );

    case DioExceptionType.unknown:
      throw ServerException(
        errorModel: extractErrorModel(
          e.response,
          "An unexpected error occurred. Please try again",
        ),
      );

    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: // Bad request
          throw ServerException(
            errorModel: extractErrorModel(
              e.response,
              "Bad request. Please check the data you sent",
            ),
          );

        case 401: // Unauthorized
          throw ServerException(
            errorModel: extractErrorModel(
              e.response,
              "Unauthorized. Please login again",
            ),
          );

        case 403: // Forbidden
          throw ServerException(
            errorModel: extractErrorModel(
              e.response,
              "Forbidden. You don't have permission to access this resource",
            ),
          );

        case 404: // Not found
          throw ServerException(
            errorModel: extractErrorModel(e.response, "Resource not found"),
          );

        case 409: // Conflict
          throw ServerException(
            errorModel: extractErrorModel(e.response, "Data conflict occurred"),
          );

        case 422: // Unprocessable Entity
          throw ServerException(
            errorModel: extractErrorModel(e.response, "Invalid data provided"),
          );

        case 504: // Gateway Timeout
          throw ServerException(
            errorModel: extractErrorModel(
              e.response,
              "Server timeout. Please try again later",
            ),
          );

        default:
          throw ServerException(
            errorModel: extractErrorModel(
              e.response,
              "Server error occurred. Please try again later",
            ),
          );
      }
  }
}

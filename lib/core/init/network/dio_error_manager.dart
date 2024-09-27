import 'package:dio/dio.dart';
import 'package:pdv_windows/core/init/network/exception.dart';

class DioErrorManager {
  static ApiException handleError(DioException error) {
    print(error);
    var message = error.response?.data['RESULT'][0]["message"];
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(
          message: message ?? 'Connection Timeout error occurred',
          code: 599,
        );
      case DioExceptionType.sendTimeout:
        return ApiException(
          message: message ?? 'Send Timeout error occurred',
          code: 400,
        );
      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: message ?? 'Receive Timeout error occurred',
          code: 598,
        );
      case DioExceptionType.badCertificate:
        return ApiException(
          message: message ?? 'Bad Certificate error occurred',
          code: 400,
        );
      case DioExceptionType.badResponse:
        return ApiException(
          message: message ?? 'Bad Response error occurred',
          code: 400,
        );
      case DioExceptionType.cancel:
        return ApiException(
          message: message ?? 'Request has been cancelled',
          code: 500,
        );
      case DioExceptionType.connectionError:
        return ApiException(
          message: message ?? 'Connection error occurred',
          code: 502,
        );
      case DioExceptionType.unknown:
        return ApiException(
          message: message ?? 'Unexpected error occurred',
          code: 500,
        );
      default:
        return ApiException(
          message: 'Unexpected error occurred',
          code: -1,
        );
    }
  }
}

import 'package:dio/dio.dart';

class ServerException implements Exception {
  final String message;

  ServerException({required this.message});

  factory ServerException.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerException(message: 'Connection timeout');
      case DioExceptionType.sendTimeout:
        return ServerException(message: 'Send timeout');
      case DioExceptionType.receiveTimeout:
        return ServerException(message: 'Receive timeout');
      case DioExceptionType.badCertificate:
        return ServerException(message: 'Bad certificate');
      case DioExceptionType.badResponse:
        return _handleResponseError(dioError.response);
      case DioExceptionType.cancel:
        return ServerException(message: 'Request cancelled');
      case DioExceptionType.connectionError:
        return ServerException(message: 'Connection error');
      case DioExceptionType.unknown:
        return ServerException(message: 'Unknown error');
    }
  }

  static ServerException _handleResponseError(Response? response) {
    final statusCode = response?.statusCode ?? 500;
    final errorMessage = response?.data?['message'] ?? 'Unknown server error';

    switch (statusCode) {
      case 400:
        return ServerException(message: 'Bad request: $errorMessage');
      case 401:
        return ServerException(message: 'Unauthorized: $errorMessage');
      case 403:
        return ServerException(message: 'Forbidden: $errorMessage');
      case 404:
        return ServerException(message: 'Not found: $errorMessage');
      case 500:
        return ServerException(message: 'Server error: $errorMessage');
      default:
        return ServerException(
          message: 'HTTP error $statusCode: $errorMessage',
        );
    }
  }
}

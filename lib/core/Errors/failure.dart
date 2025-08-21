import 'package:dio/dio.dart';

class Failure {
  final String errorMessage;
  final String code;
  Failure({required this.errorMessage, this.code = 'No Status Code Found'});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage, super.code});

  factory ServerFailure.fromDioError({required DioException dioException}) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(
          errorMessage: "Connection timeout with API server.",
        );
      case DioExceptionType.sendTimeout:
        return ServerFailure(errorMessage: "Send timeout with API server.");
      case DioExceptionType.receiveTimeout:
        return ServerFailure(errorMessage: "Receive timeout with API server.");
      case DioExceptionType.badCertificate:
        return ServerFailure(
          errorMessage:
              "Connection to API server failed due to an invalid certificate.",
        );
      case DioExceptionType.cancel:
        return ServerFailure(
          errorMessage:
              "Connection to API was cancelled. Please try again later.",
        );
      case DioExceptionType.connectionError:
        return ServerFailure(
          errorMessage:
              "Connection to API server failed due to an internet connection issue.",
        );
      case DioExceptionType.unknown:
        return ServerFailure(
          errorMessage: "Unexpected error occurred. Please try again later.",
        );
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response);
    }
  }

  factory ServerFailure.fromResponse(Response? response) {
    if (response == null) {
      return ServerFailure(errorMessage: "No response received from server.");
    }

    // Handle specific status codes first
    switch (response.statusCode) {
      case 404:
        return ServerFailure(errorMessage: "Resource not found", code: '404');
      case 500:
        return ServerFailure(
          errorMessage: "Server error. Please try again later.",
          code: '500',
        );
      case 409:
        // Handle conflict error specifically
        return ServerFailure._handleConflictError(response);
      default:
        // Handle general errors with flexible error message extraction
        return ServerFailure._extractErrorFromResponse(response);
    }
  }

  // Handle 409 Conflict errors specifically
  factory ServerFailure._handleConflictError(Response response) {
    try {
      final responseData = response.data;
      if (responseData is Map<String, dynamic>) {
        // Try different possible error field names
        final errorMessage = responseData['error'] ??
            responseData['message'] ??
            responseData['msg'] ??
            'Conflict error occurred';
        return ServerFailure(
          errorMessage: errorMessage.toString(),
          code: '409',
        );
      }
      return ServerFailure(
        errorMessage: "User already exists",
        code: '409',
      );
    } catch (e) {
      return ServerFailure(
        errorMessage: "User already exists",
        code: '409',
      );
    }
  }

  // Extract error message from response data with fallback options
  factory ServerFailure._extractErrorFromResponse(Response response) {
    try {
      final responseData = response.data;

      if (responseData is Map<String, dynamic>) {
        // Try different possible error field names in order of preference
        final errorMessage = responseData['error'] ??
            responseData['message'] ??
            responseData['msg'] ??
            responseData['detail'] ??
            'Server error occurred';

        final code = responseData['code']?.toString() ??
            responseData['status']?.toString() ??
            response.statusCode.toString();

        return ServerFailure(
          errorMessage: errorMessage.toString(),
          code: code,
        );
      } else if (responseData is String) {
        // If response data is a string, use it directly
        return ServerFailure(
          errorMessage: responseData,
          code: response.statusCode.toString(),
        );
      } else {
        // Fallback for unknown response format
        return ServerFailure(
          errorMessage: "Server error occurred",
          code: response.statusCode.toString(),
        );
      }
    } catch (e) {
      // Final fallback if everything fails
      return ServerFailure(
        errorMessage: "Unexpected server error",
        code: response.statusCode.toString(),
      );
    }
  }
}

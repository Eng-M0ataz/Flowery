import 'failure.dart';

sealed class ApiResult<T> {}

class ApiSuccessResult<T> extends ApiResult<T> {
  final T data;
  ApiSuccessResult({required this.data});
}

class ApiErrorResult<T> extends ApiResult<T> {
  final Failure failure;
  ApiErrorResult({required this.failure});
}
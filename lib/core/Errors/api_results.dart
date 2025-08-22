import 'package:flower_e_commerce_app/core/Errors/failure.dart';

sealed class ApiResult<T> {
  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) error,
  }) {
    if (this is ApiSuccessResult<T>) {
      return success((this as ApiSuccessResult<T>).data);
    } else if (this is ApiErrorResult<T>) {
      return error((this as ApiErrorResult<T>).failure);
    }
    throw Exception("Unhandled ApiResult type");
  }
}

class ApiSuccessResult<T> extends ApiResult<T> {
  final T data;
  ApiSuccessResult({required this.data});
}

class ApiErrorResult<T> extends ApiResult<T> {
  final Failure failure;
  ApiErrorResult({required this.failure});
}

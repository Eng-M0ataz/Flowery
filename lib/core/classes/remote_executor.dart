import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

abstract interface class RemoteExecutor {
  Future<ApiResult<TResult>> execute<TDto, TResult>({
    required Future<TDto> Function() request,
    TResult Function(TDto response)? mapper,
  });
}

@injectable
class FirebaseRemoteExecutor implements RemoteExecutor {
  @override
  Future<ApiResult<TResult>> execute<TDto, TResult>({
    required Future<TDto> Function() request,
    TResult Function(TDto response)? mapper,
  }) async {
    try {
      final TDto response = await request();

      if (mapper == null) {
        return ApiSuccessResult<TResult>(data: response as TResult);
      }

      final mappedResult = mapper(response);
      return ApiSuccessResult<TResult>(data: mappedResult);
    } on FirebaseException catch (e) {
      return ApiErrorResult<TResult>(failure: FirebaseFailure.fromException(e));
    } catch (e) {
      return ApiErrorResult<TResult>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}

@injectable
class ApiRemoteExecutor implements RemoteExecutor {
  @override
  Future<ApiResult<TResult>> execute<TDto, TResult>({
    required Future<TDto> Function() request,
    TResult Function(TDto response)? mapper,
  }) async {
    try {
      final TDto response = await request();
      if (mapper == null) {
        return ApiSuccessResult<TResult>(data: response as TResult);
      }
      return ApiSuccessResult<TResult>(data: mapper(response));
    } on DioException catch (e) {
      return ApiErrorResult<TResult>(
        failure: ServerFailure.fromDioError(dioException: e),
      );
    } catch (e) {
      return ApiErrorResult<TResult>(
        failure: Failure(errorMessage: e.toString()),
      );
    }
  }
}

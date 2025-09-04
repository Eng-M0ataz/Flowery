import 'package:dio/dio.dart';
import '../Errors/api_results.dart';
import '../Errors/failure.dart';

Future<ApiResult<TResult>> executeApi<TDto, TResult>(
    Future<TDto> Function() request,
    TResult Function(TDto response) mapper,
    ) async {
  try {
    final response = await request();
    return ApiSuccessResult<TResult>(data: mapper(response));
  } on DioException catch (e) {
    return ApiErrorResult<TResult>(
      failure: ServerFailure.fromDioError(dioException: e),
    );
  } catch (e) {
    return ApiErrorResult<TResult>(
      failure: Failure(
        errorMessage: e.toString(),
      ),
    );
  }
}
import 'package:dio/dio.dart';
import '../Errors/api_results.dart';
import '../Errors/failure.dart';



Future<ApiResult<TResult>> executeApi<TDto, TResult>({
  required Future<TDto> Function() request,
  TResult Function(TDto response)? mapper,
}) async {
  try {
    TDto response = await request();
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
      failure: Failure(
        errorMessage: e.toString(),
      ),
    );
  }
}

import 'package:dio/dio.dart';
import '../Errors/api_results.dart';
import '../Errors/failure.dart';

Future<ApiResult<T>> executeApi<T>(
  Future<dynamic> Function() request,
  T Function(dynamic response) mapper,
) async {
  try {
    final response = await request();
    return ApiSuccessResult<T>(data: mapper(response));
  } on DioException catch (e) {
    return ApiErrorResult<T>(
      failure: ServerFailure.fromDioError(dioException: e),
    );
  } catch (e) {
    return ApiErrorResult<T>(
      failure: Failure(errorMessage: e.toString()),
    );
  }
}

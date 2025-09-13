import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('executeApi', () {
    test('returns ApiSuccessResult when request succeeds without mapper',
        () async {
      final result = await executeApi<String, String>(
        request: () async => 'ok',
      );
      expect(result, isA<ApiSuccessResult<String>>());
      expect((result as ApiSuccessResult<String>).data, 'ok');
    });

    test('returns ApiSuccessResult mapped when mapper provided', () async {
      final result = await executeApi<String, int>(
        request: () async => '123',
        mapper: (r) => int.parse(r),
      );
      expect(result, isA<ApiSuccessResult<int>>());
      expect((result as ApiSuccessResult<int>).data, 123);
    });

    test('returns ApiErrorResult on DioException', () async {
      final result = await executeApi<String, String>(
        request: () async =>
            throw DioException(requestOptions: RequestOptions(path: '/')),
      );
      expect(result, isA<ApiErrorResult<String>>());
      expect((result as ApiErrorResult<String>).failure, isA<Failure>());
    });

    test('returns ApiErrorResult on generic exception', () async {
      final result = await executeApi<String, String>(
        request: () async => throw Exception('boom'),
      );
      expect(result, isA<ApiErrorResult<String>>());
      expect((result as ApiErrorResult<String>).failure.errorMessage,
          contains('boom'));
    });
  });
}

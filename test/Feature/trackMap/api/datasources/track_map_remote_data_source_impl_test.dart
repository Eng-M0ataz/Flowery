import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/client/track_map_api_service.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/datasources/track_map_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/polyline_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_map_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([TrackMapApiService])
void main() {
  late TrackMapRemoteDataSourceImpl dataSource;
  late MockTrackMapApiService mockApiService;

  setUp(() {
    mockApiService = MockTrackMapApiService();
    dataSource = TrackMapRemoteDataSourceImpl(mockApiService);
  });

  group('TrackMapRemoteDataSourceImpl', () {
    const String testApiKey = 'test-api-key';
    const String testFieldMask = 'routes.polyline.encodedPolyline';

    final testRequestBody = RouteRequestBodyDto(
      origin: LocationDto(
        location: LatLngDto(latitude: 30.0444, longitude: 31.2357),
      ),
      destination: LocationDto(
        location: LatLngDto(latitude: 30.0445, longitude: 31.2358),
      ),
      travelMode: 'DRIVE',
      routingPreference: 'TRAFFIC_AWARE',
    );

    group('getRoute', () {
      test(
          'should return ApiSuccessResult with RouteResponseEntity when API call is successful',
          () async {
        // Arrange
        final testPolylineDto =
            PolylineDto(encodedPolyline: 'test-encoded-polyline');
        final testRouteDto = RouteDto(polyline: testPolylineDto);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenAnswer((_) async => testResponseDto);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNotNull);
        expect(successResult.data.routes!.length, equals(1));
        expect(successResult.data.routes!.first.polyline?.encodedPolyline,
            equals('test-encoded-polyline'));

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
        verifyNoMoreInteractions(mockApiService);
      });

      test(
          'should return ApiSuccessResult with empty routes when API returns empty routes',
          () async {
        // Arrange
        final testResponseDto = RouteResponseDto(routes: []);

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenAnswer((_) async => testResponseDto);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNotNull);
        expect(successResult.data.routes!.length, equals(0));

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });

      test(
          'should return ApiSuccessResult with null routes when API returns null routes',
          () async {
        // Arrange
        final testResponseDto = RouteResponseDto(routes: null);

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenAnswer((_) async => testResponseDto);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNull);

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });

      test(
          'should return ApiSuccessResult with null polyline when route has null polyline',
          () async {
        // Arrange
        final testRouteDto = RouteDto(polyline: null);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenAnswer((_) async => testResponseDto);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNotNull);
        expect(successResult.data.routes!.length, equals(1));
        expect(successResult.data.routes!.first.polyline, isNull);

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });

      test(
          'should return ApiErrorResult with ServerFailure when DioException occurs',
          () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.connectionTimeout,
        );

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenThrow(dioException);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiErrorResult<RouteResponseEntity>>());

        final errorResult = result as ApiErrorResult<RouteResponseEntity>;
        expect(errorResult.failure, isA<ServerFailure>());
        expect(errorResult.failure.errorMessage,
            equals('Connection timeout with API server.'));

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });

      test(
          'should return ApiErrorResult with ServerFailure when DioException with bad response occurs',
          () async {
        // Arrange
        final response = Response(
          requestOptions: RequestOptions(path: '/test'),
          statusCode: 404,
          data: {'message': 'Not found'},
        );
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/test'),
          type: DioExceptionType.badResponse,
          response: response,
        );

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenThrow(dioException);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiErrorResult<RouteResponseEntity>>());

        final errorResult = result as ApiErrorResult<RouteResponseEntity>;
        expect(errorResult.failure, isA<ServerFailure>());
        expect(errorResult.failure.errorMessage, equals('Resource not found'));
        expect(errorResult.failure.code, equals('404'));

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });

      test(
          'should return ApiErrorResult with Failure when generic exception occurs',
          () async {
        // Arrange
        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenThrow(Exception('Generic error'));

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiErrorResult<RouteResponseEntity>>());

        final errorResult = result as ApiErrorResult<RouteResponseEntity>;
        expect(errorResult.failure, isA<Failure>());
        expect(errorResult.failure.errorMessage,
            equals('Exception: Generic error'));

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });

      test('should handle multiple routes correctly', () async {
        // Arrange
        final testPolylineDto1 = PolylineDto(encodedPolyline: 'polyline-1');
        final testPolylineDto2 = PolylineDto(encodedPolyline: 'polyline-2');
        final testRouteDto1 = RouteDto(polyline: testPolylineDto1);
        final testRouteDto2 = RouteDto(polyline: testPolylineDto2);
        final testResponseDto =
            RouteResponseDto(routes: [testRouteDto1, testRouteDto2]);

        when(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .thenAnswer((_) async => testResponseDto);

        // Act
        final result = await dataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNotNull);
        expect(successResult.data.routes!.length, equals(2));
        expect(successResult.data.routes![0].polyline?.encodedPolyline,
            equals('polyline-1'));
        expect(successResult.data.routes![1].polyline?.encodedPolyline,
            equals('polyline-2'));

        verify(mockApiService.getRoute(
                testApiKey, testFieldMask, testRequestBody))
            .called(1);
      });
    });
  });
}

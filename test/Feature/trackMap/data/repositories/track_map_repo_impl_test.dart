import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/mapper/route_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/polyline_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/data/dataSources/track_map_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/data/repositories/track_map_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_map_repo_impl_test.mocks.dart';

@GenerateMocks([TrackMapRemoteDataSource])
void main() {
  provideDummy<ApiResult<RouteResponseEntity>>(
    ApiSuccessResult<RouteResponseEntity>(
      data: RouteResponseEntity(routes: []),
    ),
  );
  late TrackMapRepoImpl repository;
  late MockTrackMapRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTrackMapRemoteDataSource();
    repository = TrackMapRepoImpl(mockRemoteDataSource);
  });

  group('TrackMapRepoImpl', () {
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
          'should return ApiSuccessResult when remote data source returns success',
          () async {
        // Arrange
        final testPolylineDto =
            PolylineDto(encodedPolyline: 'test-encoded-polyline');
        final testRouteDto = RouteDto(polyline: testPolylineDto);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
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

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test(
          'should return ApiSuccessResult with empty routes when remote data source returns empty routes',
          () async {
        // Arrange
        final testResponseDto = RouteResponseDto(routes: []);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNotNull);
        expect(successResult.data.routes!.length, equals(0));

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });

      test(
          'should return ApiSuccessResult with null routes when remote data source returns null routes',
          () async {
        // Arrange
        final testResponseDto = RouteResponseDto(routes: null);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        final successResult = result as ApiSuccessResult<RouteResponseEntity>;
        expect(successResult.data.routes, isNull);

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });

      test(
          'should return ApiSuccessResult with null polyline when route has null polyline',
          () async {
        // Arrange
        final testRouteDto = RouteDto(polyline: null);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
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

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });

      test('should return ApiErrorResult when remote data source returns error',
          () async {
        // Arrange
        final serverFailure =
            ServerFailure(errorMessage: 'Server error', code: '500');
        final expectedResult =
            ApiErrorResult<RouteResponseEntity>(failure: serverFailure);

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiErrorResult<RouteResponseEntity>>());

        final errorResult = result as ApiErrorResult<RouteResponseEntity>;
        expect(errorResult.failure, isA<ServerFailure>());
        expect(errorResult.failure.errorMessage, equals('Server error'));
        expect(errorResult.failure.code, equals('500'));

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });

      test(
          'should return ApiErrorResult with generic failure when remote data source returns generic error',
          () async {
        // Arrange
        final genericFailure = Failure(errorMessage: 'Generic error');
        final expectedResult =
            ApiErrorResult<RouteResponseEntity>(failure: genericFailure);

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        expect(result, isA<ApiErrorResult<RouteResponseEntity>>());

        final errorResult = result as ApiErrorResult<RouteResponseEntity>;
        expect(errorResult.failure, isA<Failure>());
        expect(errorResult.failure.errorMessage, equals('Generic error'));

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });

      test('should handle multiple routes correctly', () async {
        // Arrange
        final testPolylineDto1 = PolylineDto(encodedPolyline: 'polyline-1');
        final testPolylineDto2 = PolylineDto(encodedPolyline: 'polyline-2');
        final testRouteDto1 = RouteDto(polyline: testPolylineDto1);
        final testRouteDto2 = RouteDto(polyline: testPolylineDto2);
        final testResponseDto =
            RouteResponseDto(routes: [testRouteDto1, testRouteDto2]);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
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

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });

      test('should pass parameters correctly to remote data source', () async {
        // Arrange
        final testPolylineDto = PolylineDto(encodedPolyline: 'test-polyline');
        final testRouteDto = RouteDto(polyline: testPolylineDto);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: anyNamed('apiKey'),
          fieldMask: anyNamed('fieldMask'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => expectedResult);

        // Act
        await repository.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        );

        // Assert
        // Verify that the exact parameters were passed
        final captured = verify(mockRemoteDataSource.getRoute(
          apiKey: captureAnyNamed('apiKey'),
          fieldMask: captureAnyNamed('fieldMask'),
          body: captureAnyNamed('body'),
        )).captured;

        expect(captured[0], equals(testApiKey));
        expect(captured[1], equals(testFieldMask));
        expect(captured[2], equals(testRequestBody));
      });

      test('should handle different request body configurations', () async {
        // Arrange
        final customRequestBody = RouteRequestBodyDto(
          origin: LocationDto(
            location: LatLngDto(latitude: 40.7128, longitude: -74.0060),
          ),
          destination: LocationDto(
            location: LatLngDto(latitude: 40.7589, longitude: -73.9851),
          ),
          travelMode: 'WALKING',
          routingPreference: 'TRAFFIC_UNAWARE',
        );

        final testResponseDto = RouteResponseDto(routes: []);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: customRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: customRequestBody,
        );

        // Assert
        expect(result, isA<ApiSuccessResult<RouteResponseEntity>>());

        verify(mockRemoteDataSource.getRoute(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: customRequestBody,
        )).called(1);
      });
    });
  });
}

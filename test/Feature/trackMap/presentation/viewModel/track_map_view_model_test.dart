import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/mapper/route_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/polyline_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/useCases/get_route_use_case.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_event.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_state.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_map_view_model_test.mocks.dart';

@GenerateMocks([GetRouteUseCase])
void main() {
  provideDummy<ApiResult<RouteResponseEntity>>(
    ApiSuccessResult<RouteResponseEntity>(
      data: RouteResponseEntity(routes: []),
    ),
  );
  late TrackMapViewModel viewModel;
  late MockGetRouteUseCase mockGetRouteUseCase;

  setUp(() {
    mockGetRouteUseCase = MockGetRouteUseCase();
    viewModel = TrackMapViewModel(mockGetRouteUseCase);
  });

  group('TrackMapViewModel', () {
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

    final testEvent = GetRouteEvent(
      apiKey: testApiKey,
      fieldMask: testFieldMask,
      body: testRequestBody,
    );

    test('initial state should be TrackMapState with default values', () {
      // Assert
      expect(viewModel.state, equals(const TrackMapState()));
      expect(viewModel.state.isLoading, equals(false));
      expect(viewModel.state.routeResponse, isNull);
      expect(viewModel.state.failure, isNull);
    });

    group('doIntent', () {
      test('should handle GetRouteEvent correctly', () async {
        // Arrange
        final testPolylineDto =
            PolylineDto(encodedPolyline: 'test-encoded-polyline');
        final testRouteDto = RouteDto(polyline: testPolylineDto);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockGetRouteUseCase.call(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        await viewModel.doIntent(testEvent);

        // Assert
        verify(mockGetRouteUseCase.call(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
      });
    });

    group('_handleGetRoute', () {
      blocTest<TrackMapViewModel, TrackMapState>(
        'should emit loading state then success state when use case returns success',
        build: () {
          final testPolylineDto =
              PolylineDto(encodedPolyline: 'test-encoded-polyline');
          final testRouteDto = RouteDto(polyline: testPolylineDto);
          final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
          final expectedResult = ApiSuccessResult<RouteResponseEntity>(
            data: testResponseDto.toEntity(),
          );

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.routeResponse?.routes?.length, 'routes length',
                  equals(1))
              .having(
                  (s) =>
                      s.routeResponse?.routes?.first.polyline?.encodedPolyline,
                  'encodedPolyline',
                  equals('test-encoded-polyline')),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      blocTest<TrackMapViewModel, TrackMapState>(
        'should emit loading state then error state when use case returns error',
        build: () {
          final serverFailure =
              ServerFailure(errorMessage: 'Server error', code: '500');
          final expectedResult =
              ApiErrorResult<RouteResponseEntity>(failure: serverFailure);

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.failure, 'failure', isA<ServerFailure>())
              .having((s) => s.failure?.errorMessage, 'errorMessage',
                  equals('Server error')),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      blocTest<TrackMapViewModel, TrackMapState>(
        'should emit loading state then error state when use case returns generic failure',
        build: () {
          final genericFailure = Failure(errorMessage: 'Generic error');
          final expectedResult =
              ApiErrorResult<RouteResponseEntity>(failure: genericFailure);

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.failure, 'failure', isA<Failure>())
              .having((s) => s.failure?.errorMessage, 'errorMessage',
                  equals('Generic error')),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      blocTest<TrackMapViewModel, TrackMapState>(
        'should handle empty routes response correctly',
        build: () {
          final testResponseDto = RouteResponseDto(routes: []);
          final expectedResult = ApiSuccessResult<RouteResponseEntity>(
            data: testResponseDto.toEntity(),
          );

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.routeResponse?.routes?.length, 'routes length',
                  equals(0)),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      blocTest<TrackMapViewModel, TrackMapState>(
        'should handle null routes response correctly',
        build: () {
          final testResponseDto = RouteResponseDto(routes: null);
          final expectedResult = ApiSuccessResult<RouteResponseEntity>(
            data: testResponseDto.toEntity(),
          );

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.routeResponse?.routes, 'routes', isNull),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      blocTest<TrackMapViewModel, TrackMapState>(
        'should handle multiple routes response correctly',
        build: () {
          final testPolylineDto1 = PolylineDto(encodedPolyline: 'polyline-1');
          final testPolylineDto2 = PolylineDto(encodedPolyline: 'polyline-2');
          final testRouteDto1 = RouteDto(polyline: testPolylineDto1);
          final testRouteDto2 = RouteDto(polyline: testPolylineDto2);
          final testResponseDto =
              RouteResponseDto(routes: [testRouteDto1, testRouteDto2]);
          final expectedResult = ApiSuccessResult<RouteResponseEntity>(
            data: testResponseDto.toEntity(),
          );

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.routeResponse?.routes?.length, 'routes length',
                  equals(2))
              .having(
                  (s) => s.routeResponse?.routes?[0].polyline?.encodedPolyline,
                  'first polyline',
                  equals('polyline-1'))
              .having(
                  (s) => s.routeResponse?.routes?[1].polyline?.encodedPolyline,
                  'second polyline',
                  equals('polyline-2')),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      blocTest<TrackMapViewModel, TrackMapState>(
        'should handle route with null polyline correctly',
        build: () {
          final testRouteDto = RouteDto(polyline: null);
          final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
          final expectedResult = ApiSuccessResult<RouteResponseEntity>(
            data: testResponseDto.toEntity(),
          );

          when(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).thenAnswer((_) async => expectedResult);

          return viewModel;
        },
        act: (bloc) => bloc.doIntent(testEvent),
        expect: () => [
          isA<TrackMapState>().having((s) => s.isLoading, 'isLoading', isTrue),
          isA<TrackMapState>()
              .having((s) => s.isLoading, 'isLoading', isFalse)
              .having((s) => s.routeResponse?.routes?.length, 'routes length',
                  equals(1))
              .having((s) => s.routeResponse?.routes?.first.polyline,
                  'polyline', isNull),
        ],
        verify: (_) {
          verify(mockGetRouteUseCase.call(
            apiKey: testApiKey,
            fieldMask: testFieldMask,
            body: testRequestBody,
          )).called(1);
        },
      );

      test('should pass correct parameters to use case', () async {
        // Arrange
        final testPolylineDto = PolylineDto(encodedPolyline: 'test-polyline');
        final testRouteDto = RouteDto(polyline: testPolylineDto);
        final testResponseDto = RouteResponseDto(routes: [testRouteDto]);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockGetRouteUseCase.call(
          apiKey: anyNamed('apiKey'),
          fieldMask: anyNamed('fieldMask'),
          body: anyNamed('body'),
        )).thenAnswer((_) async => expectedResult);

        // Act
        await viewModel.doIntent(testEvent);

        // Assert
        verify(mockGetRouteUseCase.call(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: testRequestBody,
        )).called(1);
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

        final customEvent = GetRouteEvent(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: customRequestBody,
        );

        final testResponseDto = RouteResponseDto(routes: []);
        final expectedResult = ApiSuccessResult<RouteResponseEntity>(
          data: testResponseDto.toEntity(),
        );

        when(mockGetRouteUseCase.call(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: customRequestBody,
        )).thenAnswer((_) async => expectedResult);

        // Act
        await viewModel.doIntent(customEvent);

        // Assert
        verify(mockGetRouteUseCase.call(
          apiKey: testApiKey,
          fieldMask: testFieldMask,
          body: customRequestBody,
        )).called(1);
      });
    });
  });
}

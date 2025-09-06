// lib/test/Feature/auth/api/client/api_service_test.dart
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/sign_in_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';

import 'api_service_test.mocks.dart';

@GenerateMocks([Dio, ApiServices])
void main() {
  late MockDio mockDio;
  late MockApiServices mockApiServices;

  setUp(() {
    mockDio = MockDio();
    mockApiServices = MockApiServices();
  });

  group('ApiServices Tests', () {
    test('should create ApiServices instance with Dio', () {
      // Arrange & Act
      final apiServices = ApiServices(mockDio);

      // Assert
      expect(apiServices, isNotNull);
    });

    test('should call signIn and return SigninResponseDto on success', () async {
      // Arrange
      final request = SigninRequestDto(
        email: 'test@example.com',
        password: 'password123',
      );

      final expectedResponse = SigninResponseDto(
        message: 'Login successful',
        token: 'test_token_123',
        user: UserDto(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'test@example.com',
          role: 'user',
        ),
      );

      when(mockApiServices.signIn(request: anyNamed('request')))
          .thenAnswer((_) async => expectedResponse);

      // Act
      final result = await mockApiServices.signIn(request: request);

      // Assert
      expect(result, equals(expectedResponse));
      expect(result.message, equals('Login successful'));
      expect(result.token, equals('test_token_123'));
      expect(result.user?.email, equals('test@example.com'));
      verify(mockApiServices.signIn(request: anyNamed('request'))).called(1);
    });

    test('should throw DioException when API call fails', () async {
      // Arrange
      final request = SigninRequestDto(
        email: 'test@example.com',
        password: 'wrong_password',
      );

      when(mockApiServices.signIn(request: anyNamed('request')))
          .thenThrow(DioException(
        requestOptions: RequestOptions(path: '/signin'),
        message: 'Invalid credentials',
        type: DioExceptionType.badResponse,
      ));

      // Act & Assert
      expect(
            () async => await mockApiServices.signIn(request: request),
        throwsA(isA<DioException>()),
      );
    });
  });
}
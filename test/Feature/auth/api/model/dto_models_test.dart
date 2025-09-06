// lib/test/Feature/auth/api/model/dto_models_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/sign_in_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';

void main() {
  group('DTO Models Tests', () {
    group('SigninRequestDto', () {
      test('should create SigninRequestDto with required fields', () {
        // Arrange & Act
        final dto = SigninRequestDto(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(dto.email, equals('test@example.com'));
        expect(dto.password, equals('password123'));
      });

      test('should serialize to JSON correctly', () {
        // Arrange
        final dto = SigninRequestDto(
          email: 'test@example.com',
          password: 'password123',
        );

        // Act
        final json = dto.toJson();

        // Assert
        expect(json, {
          'email': 'test@example.com',
          'password': 'password123',
        });
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'email': 'test@example.com',
          'password': 'password123',
        };

        // Act
        final dto = SigninRequestDto.fromJson(json);

        // Assert
        expect(dto.email, equals('test@example.com'));
        expect(dto.password, equals('password123'));
      });
    });

    group('UserDto', () {
      test('should create UserDto with all optional fields', () {
        // Arrange & Act
        final dto = UserDto(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          gender: 'male',
          phone: '+1234567890',
          photo: 'profile.jpg',
          role: 'user',
          wishlist: ['item1', 'item2'],
          addresses: ['address1', 'address2'],
          createdAt: '2023-01-01T00:00:00.000Z',
        );

        // Assert
        expect(dto.Id, equals('1'));
        expect(dto.firstName, equals('John'));
        expect(dto.lastName, equals('Doe'));
        expect(dto.email, equals('john.doe@example.com'));
        expect(dto.gender, equals('male'));
        expect(dto.phone, equals('+1234567890'));
        expect(dto.photo, equals('profile.jpg'));
        expect(dto.role, equals('user'));
        expect(dto.wishlist, equals(['item1', 'item2']));
        expect(dto.addresses, equals(['address1', 'address2']));
        expect(dto.createdAt, equals('2023-01-01T00:00:00.000Z'));
      });

      test('should create UserDto with null values', () {
        // Arrange & Act
        final dto = UserDto();

        // Assert
        expect(dto.Id, isNull);
        expect(dto.firstName, isNull);
        expect(dto.lastName, isNull);
        expect(dto.email, isNull);
        expect(dto.gender, isNull);
        expect(dto.phone, isNull);
        expect(dto.photo, isNull);
        expect(dto.role, isNull);
        expect(dto.wishlist, isNull);
        expect(dto.addresses, isNull);
        expect(dto.createdAt, isNull);
      });

      test('should serialize to JSON correctly', () {
        // Arrange
        final dto = UserDto(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          role: 'user',
        );

        // Act
        final json = dto.toJson();

        // Assert
        expect(json['_id'], equals('1'));
        expect(json['firstName'], equals('John'));
        expect(json['lastName'], equals('Doe'));
        expect(json['email'], equals('john.doe@example.com'));
        expect(json['role'], equals('user'));
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          '_id': '1',
          'firstName': 'John',
          'lastName': 'Doe',
          'email': 'john.doe@example.com',
          'gender': 'male',
          'phone': '+1234567890',
          'photo': 'profile.jpg',
          'role': 'user',
          'wishlist': ['item1', 'item2'],
          'addresses': ['address1', 'address2'],
          'createdAt': '2023-01-01T00:00:00.000Z',
        };

        // Act
        final dto = UserDto.fromJson(json);

        // Assert
        expect(dto.Id, equals('1'));
        expect(dto.firstName, equals('John'));
        expect(dto.lastName, equals('Doe'));
        expect(dto.email, equals('john.doe@example.com'));
        expect(dto.role, equals('user'));
      });

      test('should convert to UserEntity correctly', () {
        // Arrange
        final dto = UserDto(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          role: 'user',
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.Id, equals('1'));
        expect(entity.firstName, equals('John'));
        expect(entity.lastName, equals('Doe'));
        expect(entity.email, equals('john.doe@example.com'));
        expect(entity.role, equals('user'));
      });
    });

    group('SigninResponseDto', () {
      test('should create SigninResponseDto with all fields', () {
        // Arrange
        final userDto = UserDto(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          role: 'user',
        );

        // Act
        final dto = SigninResponseDto(
          message: 'Login successful',
          user: userDto,
          token: 'test_token_123',
        );

        // Assert
        expect(dto.message, equals('Login successful'));
        expect(dto.token, equals('test_token_123'));
        expect(dto.user, equals(userDto));
      });

      test('should create SigninResponseDto with null values', () {
        // Arrange & Act
        final dto = SigninResponseDto();

        // Assert
        expect(dto.message, isNull);
        expect(dto.user, isNull);
        expect(dto.token, isNull);
      });

      test('should serialize to JSON correctly', () {
        // Arrange
        final userDto = UserDto(Id: '1', firstName: 'John');
        final dto = SigninResponseDto(
          message: 'Login successful',
          user: userDto,
          token: 'test_token_123',
        );

        // Act
        final json = dto.toJson();

        // Assert
        expect(json['message'], equals('Login successful'));
        expect(json['token'], equals('test_token_123'));
        expect(json['user'], isNotNull);
      });

      test('should deserialize from JSON correctly', () {
        // Arrange
        final json = {
          'message': 'Login successful',
          'token': 'test_token_123',
          'user': {
            '_id': '1',
            'firstName': 'John',
            'lastName': 'Doe',
            'email': 'john.doe@example.com',
            'role': 'user',
          },
        };

        // Act
        final dto = SigninResponseDto.fromJson(json);

        // Assert
        expect(dto.message, equals('Login successful'));
        expect(dto.token, equals('test_token_123'));
        expect(dto.user?.Id, equals('1'));
        expect(dto.user?.firstName, equals('John'));
      });

      test('should convert to SigninResponseEntity correctly', () {
        // Arrange
        final userDto = UserDto(
          Id: '1',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          role: 'user',
        );

        final dto = SigninResponseDto(
          message: 'Login successful',
          user: userDto,
          token: 'test_token_123',
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.message, equals('Login successful'));
        expect(entity.token, equals('test_token_123'));
        expect(entity.user?.Id, equals('1'));
        expect(entity.user?.firstName, equals('John'));
      });

      test('should convert to SigninResponseEntity with null user correctly', () {
        // Arrange
        final dto = SigninResponseDto(
          message: 'Login successful',
          user: null,
          token: 'test_token_123',
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.message, equals('Login successful'));
        expect(entity.token, equals('test_token_123'));
        expect(entity.user, isNull);
      });
    });
  });
}
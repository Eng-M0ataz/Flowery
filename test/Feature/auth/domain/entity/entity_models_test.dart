import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/user_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';

void main() {
  group('Entity Models Tests', () {
    group('SigninRequestEntity', () {
      test('should create SigninRequestEntity with required fields', () {
        // Arrange & Act
        final entity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        // Assert
        expect(entity.email, equals('test@example.com'));
        expect(entity.password, equals('password123'));
      });

      test('should convert to DTO correctly', () {
        // Arrange
        final entity = SigninRequestEntity(
          email: 'test@example.com',
          password: 'password123',
        );

        // Act
        final dto = entity.toDto();

        // Assert
        expect(dto, isA<SigninRequestDto>());
        expect(dto.email, equals('test@example.com'));
        expect(dto.password, equals('password123'));
      });

      test('should maintain data integrity during conversion', () {
        // Arrange
        final originalEmail = 'user@domain.com';
        final originalPassword = 'securePassword';
        final entity = SigninRequestEntity(
          email: originalEmail,
          password: originalPassword,
        );

        // Act
        final dto = entity.toDto();

        // Assert
        expect(dto.email, equals(originalEmail));
        expect(dto.password, equals(originalPassword));
      });
    });

    group('UserEntity', () {
      test('should create UserEntity with all optional fields', () {
        // Arrange & Act
        final entity = UserEntity(
          Id: '123',
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
        expect(entity.Id, equals('123'));
        expect(entity.firstName, equals('John'));
        expect(entity.lastName, equals('Doe'));
        expect(entity.email, equals('john.doe@example.com'));
        expect(entity.gender, equals('male'));
        expect(entity.phone, equals('+1234567890'));
        expect(entity.photo, equals('profile.jpg'));
        expect(entity.role, equals('user'));
        expect(entity.wishlist, equals(['item1', 'item2']));
        expect(entity.addresses, equals(['address1', 'address2']));
        expect(entity.createdAt, equals('2023-01-01T00:00:00.000Z'));
      });

      test('should create UserEntity with null values', () {
        // Arrange & Act
        final entity = UserEntity();

        // Assert
        expect(entity.Id, isNull);
        expect(entity.firstName, isNull);
        expect(entity.lastName, isNull);
        expect(entity.email, isNull);
        expect(entity.gender, isNull);
        expect(entity.phone, isNull);
        expect(entity.photo, isNull);
        expect(entity.role, isNull);
        expect(entity.wishlist, isNull);
        expect(entity.addresses, isNull);
        expect(entity.createdAt, isNull);
      });

      test('should handle empty lists correctly', () {
        // Arrange & Act
        final entity = UserEntity(
          Id: '123',
          firstName: 'John',
          wishlist: [],
          addresses: [],
        );

        // Assert
        expect(entity.wishlist, isEmpty);
        expect(entity.addresses, isEmpty);
        expect(entity.Id, equals('123'));
        expect(entity.firstName, equals('John'));
      });

      test('should handle mixed data types in lists', () {
        // Arrange & Act
        final entity = UserEntity(
          wishlist: ['string', 123, true],
          addresses: [{'street': '123 Main St'}, 'Simple Address'],
        );

        // Assert
        expect(entity.wishlist?[0], equals('string'));
        expect(entity.wishlist?[1], equals(123));
        expect(entity.wishlist?[2], equals(true));
        expect(entity.addresses?.length, equals(2));
      });
    });

    group('SigninResponseEntity', () {
      test('should create SigninResponseEntity with all fields', () {
        // Arrange
        final userEntity = UserEntity(
          Id: '123',
          firstName: 'John',
          lastName: 'Doe',
          email: 'john.doe@example.com',
          role: 'user',
        );

        // Act
        final entity = SigninResponseEntity(
          message: 'Login successful',
          user: userEntity,
          token: 'jwt_token_123',
        );

        // Assert
        expect(entity.message, equals('Login successful'));
        expect(entity.token, equals('jwt_token_123'));
        expect(entity.user, equals(userEntity));
        expect(entity.user?.firstName, equals('John'));
        expect(entity.user?.email, equals('john.doe@example.com'));
      });

      test('should create SigninResponseEntity with null values', () {
        // Arrange & Act
        final entity = SigninResponseEntity(
          message: null,
          user: null,
          token: null,
        );

        // Assert
        expect(entity.message, isNull);
        expect(entity.user, isNull);
        expect(entity.token, isNull);
      });

      test('should create SigninResponseEntity with partial data', () {
        // Arrange & Act
        final entity = SigninResponseEntity(
          message: 'Partial success',
          user: null,
          token: 'token_only',
        );

        // Assert
        expect(entity.message, equals('Partial success'));
        expect(entity.token, equals('token_only'));
        expect(entity.user, isNull);
      });

      test('should handle user entity with minimal data', () {
        // Arrange
        final userEntity = UserEntity(
          Id: '123',
          email: 'user@example.com',
        );

        // Act
        final entity = SigninResponseEntity(
          message: 'Success',
          user: userEntity,
          token: 'token',
        );

        // Assert
        expect(entity.user?.Id, equals('123'));
        expect(entity.user?.email, equals('user@example.com'));
        expect(entity.user?.firstName, isNull);
        expect(entity.user?.lastName, isNull);
      });

      test('should maintain object references correctly', () {
        // Arrange
        final userEntity = UserEntity(
          Id: '123',
          firstName: 'John',
        );

        final entity1 = SigninResponseEntity(
          message: 'Success',
          user: userEntity,
          token: 'token',
        );

        final entity2 = SigninResponseEntity(
          message: 'Success',
          user: userEntity,
          token: 'token',
        );

        // Act & Assert
        expect(entity1.user, equals(entity2.user));
        expect(identical(entity1.user, entity2.user), isTrue);
      });
    });
  });
}
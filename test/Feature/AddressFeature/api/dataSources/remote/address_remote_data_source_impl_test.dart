import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/client/address_api_service.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/dataSources/remote/address_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/address_dto.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/response/address_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([AddressApiServices])
void main() {
  late MockAddressApiServices mockApiService;
  late AddressRemoteDataSourceImpl dataSource;

  setUp(() {
    mockApiService = MockAddressApiServices();
    dataSource = AddressRemoteDataSourceImpl(
      apiServicest: mockApiService,
    );
  });

  group('AddressRemoteDataSourceImpl', () {
    group('getAddresses', () {
      final mockAddressDto = AddressDto(
        id: 'address123',
        username: 'John Doe',
        phone: '+1234567890',
        street: 'Main Street',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
      );

      final mockResponseDto = AddressResponseDto(
        message: 'Addresses retrieved successfully',
        addresses: [mockAddressDto],
      );

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.getAddresses())
            .thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await dataSource.getAddresses();

        // Assert
        expect(result, isA<ApiSuccessResult<AddressResponseEntity>>());
        if (result is ApiSuccessResult<AddressResponseEntity>) {
          expect(result.data.message, equals(mockResponseDto.message));
          expect(result.data.addresses.length, equals(1));
          expect(result.data.addresses.first.id, equals(mockAddressDto.id));
          expect(result.data.addresses.first.username,
              equals(mockAddressDto.username));
          expect(
              result.data.addresses.first.phone, equals(mockAddressDto.phone));
        } else {
          fail('Expected success but got failure');
        }
        verify(mockApiService.getAddresses()).called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/addresses'),
          response: Response(
            requestOptions: RequestOptions(path: '/addresses'),
            statusCode: 500,
          ),
        );
        when(mockApiService.getAddresses()).thenThrow(dioException);

        // Act
        final result = await dataSource.getAddresses();

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.getAddresses()).called(1);
      });

      test('should return error when other Exception occurs', () async {
        // Arrange
        when(mockApiService.getAddresses())
            .thenThrow(Exception('Network error'));

        // Act
        final result = await dataSource.getAddresses();

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(
              result.failure.errorMessage, equals('Exception: Network error'));
        }
        verify(mockApiService.getAddresses()).called(1);
      });

      test('should return empty list when no addresses found', () async {
        // Arrange
        final emptyResponseDto = AddressResponseDto(
          message: 'No addresses found',
          addresses: [],
        );
        when(mockApiService.getAddresses())
            .thenAnswer((_) async => emptyResponseDto);

        // Act
        final result = await dataSource.getAddresses();

        // Assert
        expect(result, isA<ApiSuccessResult<AddressResponseEntity>>());
        if (result is ApiSuccessResult<AddressResponseEntity>) {
          expect(result.data.addresses.length, equals(0));
          expect(result.data.message, equals('No addresses found'));
        }
        verify(mockApiService.getAddresses()).called(1);
      });
    });

    group('deleteAddress', () {
      const addressId = 'address123';

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.deleteAddress(addressId))
            .thenAnswer((_) async => null);

        // Act
        final result = await dataSource.deleteAddress(addressId);

        // Assert
        expect(result, isA<ApiSuccessResult<void>>());
        verify(mockApiService.deleteAddress(addressId)).called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/addresses/$addressId'),
          response: Response(
            requestOptions: RequestOptions(path: '/addresses/$addressId'),
            statusCode: 404,
          ),
        );
        when(mockApiService.deleteAddress(addressId)).thenThrow(dioException);

        // Act
        final result = await dataSource.deleteAddress(addressId);

        // Assert
        expect(result, isA<ApiErrorResult<void>>());
        if (result is ApiErrorResult<void>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.deleteAddress(addressId)).called(1);
      });

      test('should return error when other Exception occurs', () async {
        // Arrange
        when(mockApiService.deleteAddress(addressId))
            .thenThrow(Exception('Delete failed'));

        // Act
        final result = await dataSource.deleteAddress(addressId);

        // Assert
        expect(result, isA<ApiErrorResult<void>>());
        if (result is ApiErrorResult<void>) {
          expect(
              result.failure.errorMessage, equals('Exception: Delete failed'));
        }
        verify(mockApiService.deleteAddress(addressId)).called(1);
      });
    });

    group('addAddress', () {
      final addAddressRequest = AddAddressRequestModel(
        username: 'John Doe',
        phone: '+1234567890',
        street: 'Main Street',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
      );

      final mockAddressDto = AddressDto(
        id: 'address123',
        username: 'John Doe',
        phone: '+1234567890',
        street: 'Main Street',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
      );

      final mockResponseDto = AddressResponseDto(
        message: 'Address added successfully',
        addresses: [mockAddressDto],
      );

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.addAddress(addAddressRequest))
            .thenAnswer((_) async => mockResponseDto);

        // Act
        final result = await dataSource.addAddress(addAddressRequest);

        // Assert
        expect(result, isA<ApiSuccessResult<AddressResponseEntity>>());
        if (result is ApiSuccessResult<AddressResponseEntity>) {
          expect(result.data.message, equals(mockResponseDto.message));
          expect(result.data.addresses.length, equals(1));
          expect(result.data.addresses.first.username,
              equals(addAddressRequest.username));
          expect(result.data.addresses.first.phone,
              equals(addAddressRequest.phone));
          expect(result.data.addresses.first.street,
              equals(addAddressRequest.street));
        } else {
          fail('Expected success but got failure');
        }
        verify(mockApiService.addAddress(addAddressRequest)).called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/addresses'),
          response: Response(
            requestOptions: RequestOptions(path: '/addresses'),
            statusCode: 400,
            data: {'message': 'Invalid address data'},
          ),
        );
        when(mockApiService.addAddress(addAddressRequest))
            .thenThrow(dioException);

        // Act
        final result = await dataSource.addAddress(addAddressRequest);

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.addAddress(addAddressRequest)).called(1);
      });

      test('should return error when other Exception occurs', () async {
        // Arrange
        when(mockApiService.addAddress(addAddressRequest))
            .thenThrow(Exception('Add address failed'));

        // Act
        final result = await dataSource.addAddress(addAddressRequest);

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(result.failure.errorMessage,
              equals('Exception: Add address failed'));
        }
        verify(mockApiService.addAddress(addAddressRequest)).called(1);
      });
    });

    group('updateAddress', () {
      const addressId = 'address123';
      final updateAddressRequest = AddAddressRequestModel(
        username: 'John Updated',
        phone: '+1234567891',
        street: 'Updated Street',
        city: 'Alexandria',
        lat: '31.2156',
        long: '29.9553',
      );

      final mockUpdatedAddressDto = AddressDto(
        id: addressId,
        username: 'John Updated',
        phone: '+1234567891',
        street: 'Updated Street',
        city: 'Alexandria',
        lat: '31.2156',
        long: '29.9553',
      );

      final mockResponseDto = AddressResponseDto(
        message: 'Address updated successfully',
        addresses: [mockUpdatedAddressDto],
      );

      test('should return success when API call is successful', () async {
        // Arrange
        when(mockApiService.updateAddress(addressId, updateAddressRequest))
            .thenAnswer((_) async => mockResponseDto);

        // Act
        final result =
            await dataSource.updateAddress(addressId, updateAddressRequest);

        // Assert
        expect(result, isA<ApiSuccessResult<AddressResponseEntity>>());
        if (result is ApiSuccessResult<AddressResponseEntity>) {
          expect(result.data.message, equals(mockResponseDto.message));
          expect(result.data.addresses.length, equals(1));
          expect(result.data.addresses.first.id, equals(addressId));
          expect(result.data.addresses.first.username,
              equals(updateAddressRequest.username));
          expect(result.data.addresses.first.phone,
              equals(updateAddressRequest.phone));
          expect(result.data.addresses.first.street,
              equals(updateAddressRequest.street));
          expect(result.data.addresses.first.city,
              equals(updateAddressRequest.city));
        } else {
          fail('Expected success but got failure');
        }
        verify(mockApiService.updateAddress(addressId, updateAddressRequest))
            .called(1);
      });

      test('should return error when DioException occurs', () async {
        // Arrange
        final dioException = DioException(
          requestOptions: RequestOptions(path: '/addresses/$addressId'),
          response: Response(
            requestOptions: RequestOptions(path: '/addresses/$addressId'),
            statusCode: 404,
            data: {'message': 'Address not found'},
          ),
        );
        when(mockApiService.updateAddress(addressId, updateAddressRequest))
            .thenThrow(dioException);

        // Act
        final result =
            await dataSource.updateAddress(addressId, updateAddressRequest);

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.updateAddress(addressId, updateAddressRequest))
            .called(1);
      });

      test('should return error when other Exception occurs', () async {
        // Arrange
        when(mockApiService.updateAddress(addressId, updateAddressRequest))
            .thenThrow(Exception('Update failed'));

        // Act
        final result =
            await dataSource.updateAddress(addressId, updateAddressRequest);

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(
              result.failure.errorMessage, equals('Exception: Update failed'));
        }
        verify(mockApiService.updateAddress(addressId, updateAddressRequest))
            .called(1);
      });

      test('should handle validation errors properly', () async {
        // Arrange
        final validationException = DioException(
          requestOptions: RequestOptions(path: '/addresses/$addressId'),
          response: Response(
            requestOptions: RequestOptions(path: '/addresses/$addressId'),
            statusCode: 422,
            data: {
              'message': 'Validation failed',
              'errors': {
                'phone': ['Phone number is invalid'],
                'street': ['Street is required']
              }
            },
          ),
        );
        when(mockApiService.updateAddress(addressId, updateAddressRequest))
            .thenThrow(validationException);

        // Act
        final result =
            await dataSource.updateAddress(addressId, updateAddressRequest);

        // Assert
        expect(result, isA<ApiErrorResult<AddressResponseEntity>>());
        if (result is ApiErrorResult<AddressResponseEntity>) {
          expect(result.failure, isA<Failure>());
        }
        verify(mockApiService.updateAddress(addressId, updateAddressRequest))
            .called(1);
      });
    });
  });
}

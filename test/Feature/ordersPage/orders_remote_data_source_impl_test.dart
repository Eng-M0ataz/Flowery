import 'dart:async';

import 'package:flower_e_commerce_app/Feature/ordersPage/api/dataSources/orders_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/mappers/response/order_response_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/client/orders_service.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/response/orders_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

import 'orders_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OrdersService, OrdersResponseDto])
void main() {
  late OrdersRemoteDataSourceImpl dataSource;
  late MockOrdersService mockOrdersService;
  late MockOrdersResponseDto mockOrdersResponseDto;

  setUp(() {
    mockOrdersService = MockOrdersService();
    mockOrdersResponseDto = MockOrdersResponseDto();
    dataSource = OrdersRemoteDataSourceImpl(mockOrdersService);
  });

  group('OrdersRemoteDataSourceImpl', () {
    group('getAllOrders', () {
      test('should return ApiSuccessResult when API call succeeds', () async {
        // Arrange
        final mockResponseDto = OrdersResponseDto(
          message: "success",
          orders: [],
        );

        final mockEntity = OrdersResponseEntity(
          message: "success",
          orders: [],
        );

        when(mockOrdersService.getOrders())
            .thenAnswer((_) async => mockResponseDto);
        // Here you don’t really need mockOrdersResponseDto,
        // since you’re working with a real DTO.
        // The mapping is tested via `toEntity()`.
        // If your DTO has `toEntity` implemented, remove the extra mock.
        // Otherwise, keep mocking it.

        // Act
        final result = await dataSource.getAllOrders();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(
          successResult.data,
          predicate<OrdersResponseEntity>(
                (entity) =>
            entity.message == mockEntity.message &&
                entity.orders!.length == mockEntity.orders!.length,
            'OrdersResponseEntity with matching values',
          ),
        );
        verify(mockOrdersService.getOrders()).called(1);
      });

      test('should return ApiErrorResult when API call throws exception', () async {
        // Arrange
        when(mockOrdersService.getOrders())
            .thenThrow(Exception('Network error'));

        // Act
        final result = await dataSource.getAllOrders();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure, isA<Failure>());

        verify(mockOrdersService.getOrders()).called(1);
      });

      test('should return ApiErrorResult when mapping fails', () async {
        // Arrange
        when(mockOrdersService.getOrders())
            .thenAnswer((_) async => mockOrdersResponseDto);
        when(mockOrdersResponseDto.toEntity())
            .thenThrow(Exception('Mapping error'));

        // Act
        final result = await dataSource.getAllOrders();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure, isA<Failure>());

        verify(mockOrdersService.getOrders()).called(1);
      });

      test('should handle API returning invalid response', () async {
        // Arrange
        when(mockOrdersService.getOrders())
            .thenThrow(FormatException('Invalid response format'));

        // Act
        final result = await dataSource.getAllOrders();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(
          errorResult.failure.errorMessage,
          contains('Invalid response format'),
        );

        verify(mockOrdersService.getOrders()).called(1);
      });

      test('should handle timeout exception', () async {
        // Arrange
        when(mockOrdersService.getOrders()).thenThrow(
          TimeoutException('Request timeout', Duration(seconds: 30)),
        );

        // Act
        final result = await dataSource.getAllOrders();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure.errorMessage, contains('timeout'));

        verify(mockOrdersService.getOrders()).called(1);
      });
    });
  });
}

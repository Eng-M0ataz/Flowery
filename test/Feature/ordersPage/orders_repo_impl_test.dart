import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/data/dataSources/orders_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/data/repositories/orders_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

import 'orders_repo_impl_test.mocks.dart';

@GenerateMocks([OrdersRemoteDataSource])
void main() {

  provideDummy<ApiResult<OrdersResponseEntity>>(
        ApiErrorResult<OrdersResponseEntity>(
      failure: Failure(errorMessage: 'dummy', code: '0'),
    ),
  );
  late OrdersRepoImpl repository;
  late MockOrdersRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockOrdersRemoteDataSource();
    repository = OrdersRepoImpl(mockDataSource);
  });

  group('OrdersRepoImpl', () {
    group('getOrders', () {
      test('should return ApiSuccessResult when data source succeeds', () async {
        // Arrange
        final testOrders = [
          OrdersEntity(
            id: "order_1",
            user: "user_1",
            orderItems: [],
            totalPrice: 100,
            paymentType: "Cash",
            isPaid: false,
            isDelivered: false,
            state: "pending",
            orderNumber: "#TEST123",
            createdAt: "2025-09-08T06:57:05.166Z",
            updatedAt: "2025-09-08T06:57:05.166Z",
          ),
        ];

        final expectedEntity = OrdersResponseEntity(
          message: "success",
          orders: testOrders,
        );

        final expectedResult = ApiSuccessResult(data: expectedEntity);

        when(mockDataSource.getAllOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getOrders();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data, equals(expectedEntity));
        expect(successResult.data.message, equals("success"));
        expect(successResult.data.orders?.length, equals(1));

        verify(mockDataSource.getAllOrders()).called(1);
      });

      test('should return ApiErrorResult when data source fails', () async {
        // Arrange
        final testFailure = Failure(
          errorMessage: "Network connection failed",
          code: '500',
        );
        final expectedResult = ApiErrorResult<OrdersResponseEntity>(
          failure: testFailure,
        );

        when(mockDataSource.getAllOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getOrders();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure, equals(testFailure));
        expect(errorResult.failure.errorMessage, equals("Network connection failed"));
        expect(errorResult.failure.code, equals('500'));

        verify(mockDataSource.getAllOrders()).called(1);
      });

      test('should return empty orders list when data source returns empty response', () async {
        // Arrange
        final emptyEntity = OrdersResponseEntity(
          message: "success",
          orders: [],
        );
        final expectedResult = ApiSuccessResult(data: emptyEntity);

        when(mockDataSource.getAllOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getOrders();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data.orders?.isEmpty, isTrue);
        expect(successResult.data.message, equals("success"));

        verify(mockDataSource.getAllOrders()).called(1);
      });

      test('should handle multiple orders correctly', () async {
        // Arrange
        final multipleOrders = [
          OrdersEntity(
            id: "order_1",
            user: "user_1",
            totalPrice: 100,
            paymentType: "Cash",
            isPaid: false,
            isDelivered: false,
            state: "pending",
            orderNumber: "#TEST123",
          ),
          OrdersEntity(
            id: "order_2",
            user: "user_2",
            totalPrice: 200,
            paymentType: "Card",
            isPaid: true,
            isDelivered: true,
            state: "completed",
            orderNumber: "#TEST124",
          ),
        ];

        final multipleOrdersEntity = OrdersResponseEntity(
          message: "success",
          orders: multipleOrders,
        );
        final expectedResult = ApiSuccessResult(data: multipleOrdersEntity);

        when(mockDataSource.getAllOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getOrders();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data.orders?.length, equals(2));
        expect(successResult.data.orders?[0].id, equals("order_1"));
        expect(successResult.data.orders?[1].id, equals("order_2"));

        verify(mockDataSource.getAllOrders()).called(1);
      });

      test('should propagate specific failure types', () async {
        // Arrange
        final authFailure = Failure(
          errorMessage: "Authentication failed",
          code: '401',
        );
        final expectedResult = ApiErrorResult<OrdersResponseEntity>(
          failure: authFailure,
        );

        when(mockDataSource.getAllOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getOrders();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure.code, equals('401'));
        expect(errorResult.failure.errorMessage, equals("Authentication failed"));

        verify(mockDataSource.getAllOrders()).called(1);
      });

      test('should handle data source throwing exception', () async {
        // Arrange
        when(mockDataSource.getAllOrders())
            .thenThrow(Exception('Unexpected error'));

        // Act & Assert
        expect(
              () async => await repository.getOrders(),
          throwsA(isA<Exception>()),
        );

        verify(mockDataSource.getAllOrders()).called(1);
      });

      test('should pass through null orders in response', () async {
        // Arrange
        final nullOrdersEntity = OrdersResponseEntity(
          message: "success",
          orders: null,
        );
        final expectedResult = ApiSuccessResult(data: nullOrdersEntity);

        when(mockDataSource.getAllOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await repository.getOrders();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data.orders, isNull);
        expect(successResult.data.message, equals("success"));

        verify(mockDataSource.getAllOrders()).called(1);
      });
    });
  });
}
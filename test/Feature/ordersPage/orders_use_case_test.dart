import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/metadata_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/repositories/orders_repo.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/useCases/orders_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';

import 'orders_use_case_test.mocks.dart';

@GenerateMocks([OrdersRepo])
void main() {
  provideDummy<ApiResult<OrdersResponseEntity>>(
    ApiErrorResult<OrdersResponseEntity>(
      failure: Failure(errorMessage: 'dummy', code: '0'),
    ),
  );

  late OrdersUseCase useCase;
  late MockOrdersRepo mockOrdersRepo;

  setUp(() {
    mockOrdersRepo = MockOrdersRepo();
    useCase = OrdersUseCase(mockOrdersRepo);
  });

  group('OrdersUseCase', () {
    // Test data setup
    final testProduct = ProductDetailsModel(
      id: "product_1",
      title: "Test Product",
      description: "Test Description",
      imageCover: "test_cover.png",
      images: ["image1.png", "image2.png"],
      price: 100,
      priceAfterDiscount: 90,
      quantity: 50,
    );

    final testOrderItems = [
      OrderItemsEntity(
        id: "item_1",
        quantity: 2,
        price: 100,
        product: testProduct,
      ),
    ];

    final testOrders = [
      OrdersEntity(
        id: "order_1",
        user: "user_1",
        orderItems: testOrderItems,
        totalPrice: 200,
        paymentType: "Cash",
        isPaid: false,
        isDelivered: false,
        state: "pending",
        orderNumber: "#TEST123",
        createdAt: "2025-09-08T06:57:05.166Z",
        updatedAt: "2025-09-08T06:57:05.166Z",
      ),
    ];

    final testMetadata = MetadataEntity(
      currentPage: 1,
      totalPages: 1,
      limit: 10,
      totalItems: 1,
    );

    group('invoke', () {
      test('should return ApiSuccessResult when repository succeeds', () async {
        // Arrange
        final expectedEntity = OrdersResponseEntity(
          message: "success",
          orders: testOrders,
          metaData: testMetadata,
        );
        final expectedResult = ApiSuccessResult(data: expectedEntity);

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data, equals(expectedEntity));
        expect(successResult.data.message, equals("success"));
        expect(successResult.data.orders?.length, equals(1));
        expect(successResult.data.metaData?.currentPage, equals(1));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should return ApiErrorResult when repository fails', () async {
        // Arrange
        final testFailure = Failure(
          errorMessage: "Failed to fetch orders",
          code: '500',
        );
        final expectedResult = ApiErrorResult<OrdersResponseEntity>(
          failure: testFailure,
        );

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure, equals(testFailure));
        expect(errorResult.failure.errorMessage, equals("Failed to fetch orders"));
        expect(errorResult.failure.code, equals('500'));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should handle empty orders list from repository', () async {
        // Arrange
        final emptyEntity = OrdersResponseEntity(
          message: "success",
          orders: [],
          metaData: MetadataEntity(
            currentPage: 1,
            totalPages: 1,
            limit: 10,
            totalItems: 0,
          ),
        );
        final expectedResult = ApiSuccessResult(data: emptyEntity);

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data.orders?.isEmpty, isTrue);
        expect(successResult.data.metaData?.totalItems, equals(0));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should handle multiple orders with complex data', () async {
        // Arrange
        final complexOrders = [
          OrdersEntity(
            id: "order_1",
            user: "user_1",
            orderItems: testOrderItems,
            totalPrice: 200,
            paymentType: "Cash",
            isPaid: false,
            isDelivered: false,
            state: "pending",
            orderNumber: "#TEST123",
            createdAt: "2025-09-08T06:57:05.166Z",
            updatedAt: "2025-09-08T06:57:05.166Z",
          ),
          OrdersEntity(
            id: "order_2",
            user: "user_2",
            orderItems: [
              OrderItemsEntity(
                id: "item_2",
                quantity: 1,
                price: 150,
                product: testProduct,
              ),
            ],
            totalPrice: 150,
            paymentType: "Card",
            isPaid: true,
            isDelivered: true,
            state: "completed",
            orderNumber: "#TEST124",
            createdAt: "2025-09-08T07:57:05.166Z",
            updatedAt: "2025-09-08T08:57:05.166Z",
          ),
        ];

        final complexEntity = OrdersResponseEntity(
          message: "success",
          orders: complexOrders,
          metaData: MetadataEntity(
            currentPage: 1,
            totalPages: 1,
            limit: 10,
            totalItems: 2,
          ),
        );
        final expectedResult = ApiSuccessResult(data: complexEntity);

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data.orders?.length, equals(2));
        expect(successResult.data.orders?[0].state, equals("pending"));
        expect(successResult.data.orders?[1].state, equals("completed"));
        expect(successResult.data.metaData?.totalItems, equals(2));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should handle different failure scenarios', () async {
        // Arrange
        final networkFailure = Failure(
          errorMessage: "No internet connection",
          code: '0',
        );
        final expectedResult = ApiErrorResult<OrdersResponseEntity>(
          failure: networkFailure,
        );

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure.errorMessage, equals("No internet connection"));
        expect(errorResult.failure.code, equals('0'));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should handle authentication failure', () async {
        // Arrange
        final authFailure = Failure(
          errorMessage: "Authentication required",
          code: '401',
        );
        final expectedResult = ApiErrorResult<OrdersResponseEntity>(
          failure: authFailure,
        );

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<OrdersResponseEntity>>());
        final errorResult = result as ApiErrorResult<OrdersResponseEntity>;
        expect(errorResult.failure.code, equals('401'));
        expect(errorResult.failure.errorMessage, equals("Authentication required"));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should handle repository throwing exception', () async {
        // Arrange
        when(mockOrdersRepo.getOrders())
            .thenThrow(Exception('Unexpected repository error'));

        // Act & Assert
        expect(
              () async => await useCase.invoke(),
          throwsA(isA<Exception>()),
        );

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should handle null response data', () async {
        // Arrange
        final nullDataEntity = OrdersResponseEntity(
          message: "success",
          orders: null,
          metaData: null,
        );
        final expectedResult = ApiSuccessResult(data: nullDataEntity);

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<OrdersResponseEntity>>());
        final successResult = result as ApiSuccessResult<OrdersResponseEntity>;
        expect(successResult.data.orders, isNull);
        expect(successResult.data.metaData, isNull);
        expect(successResult.data.message, equals("success"));

        verify(mockOrdersRepo.getOrders()).called(1);
      });

      test('should verify invoke is called only once per call', () async {
        // Arrange
        final expectedEntity = OrdersResponseEntity(message: "success");
        final expectedResult = ApiSuccessResult(data: expectedEntity);

        when(mockOrdersRepo.getOrders())
            .thenAnswer((_) async => expectedResult);

        // Act
        await useCase.invoke();
        await useCase.invoke();

        // Assert
        verify(mockOrdersRepo.getOrders()).called(2);
      });
    });
  });
}
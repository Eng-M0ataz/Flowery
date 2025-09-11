import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/order_items.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/useCases/orders_use_case.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_view_model.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_event.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';

import 'orders_view_model_test.mocks.dart';
class DummyOrdersResponseEntity extends Fake implements OrdersResponseEntity {}

@GenerateMocks([OrdersUseCase])
void main() {
  late OrdersViewModel ordersViewModel;
  late MockOrdersUseCase mockOrdersUseCase;

  setUp(() {
    provideDummy<ApiResult<OrdersResponseEntity>>(
      ApiSuccessResult(data: OrdersResponseEntity(message: '', orders: []))
    );
    mockOrdersUseCase = MockOrdersUseCase();
    ordersViewModel = OrdersViewModel(mockOrdersUseCase);
  });

  group('OrdersViewModel', () {
    // Test data setup
    final testProduct = ProductDetailsModel(
      id: "test_id_1",
      title: "Test Product",
      description: "Test Description",
      imageCover: "test_image.png",
      images: ["image1.png", "image2.png"],
      price: 100,
      priceAfterDiscount: 90,
      quantity: 50,
    );

    final testOrderItems = [
      OrderItems(
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

    final testOrdersResponseEntity = OrdersResponseEntity(
      message: "success",
      orders: testOrders,
    );

    test('initial state should be correct', () {
      expect(ordersViewModel.state, const OrdersState());
    });

    group('GetAllOrdersEvent', () {
      blocTest<OrdersViewModel, OrdersState>(
        'emits success state when getAllOrders succeeds',
        build: () {
          when(mockOrdersUseCase.invoke()).thenAnswer(
                (_) async => ApiSuccessResult(data: testOrdersResponseEntity),
          );
          return ordersViewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllOrdersEvent()),
        expect: () => [
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.orderFailure?.errorMessage, 'failure message', null)
              .having((s) => s.orders, 'orders', testOrdersResponseEntity)
              .having((s) => s.isSuccess, 'isSuccess', true)
        ],
        verify: (cubit) {
          verify(mockOrdersUseCase.invoke()).called(1);
        },
      );

      blocTest<OrdersViewModel, OrdersState>(
        'emits failure state when getAllOrders fails',
        build: () {
          final testFailure = Failure(errorMessage: "Network error");
          when(mockOrdersUseCase.invoke()).thenAnswer(
                (_) async => ApiErrorResult(failure: testFailure),
          );
          return ordersViewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllOrdersEvent()),
        expect: () => [
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.orderFailure, 'failure', null)
              .having((s) => s.orders, 'orders', null)
              .having((s) => s.isSuccess, 'isSuccess', false),
          isA<OrdersState>()
            .having((s) => s.isLoading, 'isLoading', false)
            .having((s) => s.orderFailure?.errorMessage, 'failure message', "Network error")
            .having((s) => s.orders, 'orders', null)
            .having((s) => s.isSuccess, 'isSuccess', false)
        ],
        verify: (cubit) {
          verify(mockOrdersUseCase.invoke()).called(1);
        },
      );

      blocTest<OrdersViewModel, OrdersState>(
        'emits success state with empty orders list',
        build: () {
          final emptyOrdersResponse = OrdersResponseEntity(
            message: "success",
            orders: [],
          );
          when(mockOrdersUseCase.invoke()).thenAnswer(
                (_) async => ApiSuccessResult(data: emptyOrdersResponse),
          );
          return ordersViewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllOrdersEvent()),
        expect: () => [
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', true),
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.orders?.message, 'orders.message', "success")
              .having((s) => s.orders?.orders, 'orders.orders', isEmpty)
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.orderFailure, 'orderFailure', null),
        ],
        verify: (cubit) {
          verify(mockOrdersUseCase.invoke()).called(1);
        },
      );


      blocTest<OrdersViewModel, OrdersState>(
        'handles multiple orders correctly',
        build: () {
          final multipleOrders = [
            ...testOrders,
            OrdersEntity(
              id: "order_2",
              user: "user_2",
              orderItems: testOrderItems,
              totalPrice: 300,
              paymentType: "Card",
              isPaid: true,
              isDelivered: true,
              state: "completed",
              orderNumber: "#TEST124",
              createdAt: "2025-09-08T07:57:05.166Z",
              updatedAt: "2025-09-08T07:57:05.166Z",
            ),
          ];

          final multipleOrdersResponse = OrdersResponseEntity(
            message: "success",
            orders: multipleOrders,
          );

          when(mockOrdersUseCase.invoke()).thenAnswer(
                (_) async => ApiSuccessResult(data: multipleOrdersResponse),
          );
          return ordersViewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllOrdersEvent()),
        expect: () => [
          // First: loading
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.orderFailure, 'failure', null)
              .having((s) => s.orders, 'orders', null)
              .having((s) => s.isSuccess, 'isSuccess', false),

          // Second: success with 2 orders
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.orderFailure, 'failure', null)
              .having((s) => s.isSuccess, 'isSuccess', true)
              .having((s) => s.orders?.orders!.length, 'orders length', 2)
              .having((s) => s.orders?.orders![0].id, 'first order id', "order_1")
              .having((s) => s.orders?.orders![1].id, 'second order id', "order_2"),
        ],
        verify: (cubit) {
          verify(mockOrdersUseCase.invoke()).called(1);
        },
      );
    });

    group('Error Handling', () {
      blocTest<OrdersViewModel, OrdersState>(
        'handles use case throwing exception',
        build: () {
          when(mockOrdersUseCase.invoke()).thenThrow(Exception('Unexpected error'));
          return ordersViewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllOrdersEvent()),
        errors: () => [isA<Exception>()],
        verify: (cubit) {
          verify(mockOrdersUseCase.invoke()).called(1);
        },
      );

      blocTest<OrdersViewModel, OrdersState>(
        'handles different failure types',
        build: () {
          final networkFailure = Failure(
            errorMessage: "No internet connection",
            code: "500",
          );
          when(mockOrdersUseCase.invoke()).thenAnswer(
                (_) async => ApiErrorResult(failure: networkFailure),
          );
          return ordersViewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllOrdersEvent()),
        expect: () => [
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', true)
              .having((s) => s.orderFailure, 'failure', null)
              .having((s) => s.orders, 'orders', null)
              .having((s) => s.isSuccess, 'isSuccess', false),
          isA<OrdersState>()
              .having((s) => s.isLoading, 'isLoading', false)
              .having((s) => s.orderFailure?.errorMessage, 'failure message', "No internet connection")
              .having((s) => s.orderFailure?.code, 'failure code', "500")
              .having((s) => s.orders, 'orders', null)
              .having((s) => s.isSuccess, 'isSuccess', false),
        ],
        verify: (cubit) {
          verify(mockOrdersUseCase.invoke()).called(1);
        },
      );
    });

    tearDown(() {
      ordersViewModel.close();
    });
  });
}
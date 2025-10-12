import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce_app/Feature/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/cart/presentation/viewModel/cart_events.dart';
import 'package:flower_e_commerce_app/Feature/cart/presentation/viewModel/cart_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

import 'package:flower_e_commerce_app/Feature/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/cart/domain/useCases/clear_specific_cart_item_use_case.dart';
import 'package:flower_e_commerce_app/Feature/cart/domain/useCases/clear_user_cart_use_case.dart';
import 'package:flower_e_commerce_app/Feature/cart/domain/useCases/get_user_cart_use_case.dart';
import 'package:flower_e_commerce_app/Feature/cart/domain/useCases/update_cart_product_quantity_use_case.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  GetUserCartUseCase,
  ClearSpecificCartItemUseCase,
  ClearUserCartUseCase,
  UpdateCartProductQuantityUseCase,
])
void main() {
  late MockGetUserCartUseCase mockGetUserCartUseCase;
  late MockClearSpecificCartItemUseCase mockClearSpecificCartItemUseCase;
  late MockClearUserCartUseCase mockClearUserCartUseCase;
  late MockUpdateCartProductQuantityUseCase mockUpdateCartProductQuantityUseCase;

  late CartEntity testCartEntity;
  final testFailure = ServerFailure(errorMessage: 'Server Error');

  setUpAll(() {
    mockGetUserCartUseCase = MockGetUserCartUseCase();
    mockClearSpecificCartItemUseCase = MockClearSpecificCartItemUseCase();
    mockClearUserCartUseCase = MockClearUserCartUseCase();
    mockUpdateCartProductQuantityUseCase = MockUpdateCartProductQuantityUseCase();

    testCartEntity = CartEntity(
      products: [
        CartProductEntity(
          productId: 'p1',
          productName: 'Rose',
          productImage: 'https://example.com/rose.jpg',
          productPrice: 100,
          priceAfterDiscount: 80,
          quantity: 2,
        )
      ],
      totalPrice: 200,
      numberOfCartItems: 1,
    );

    provideDummy<ApiResult<CartEntity>>(ApiSuccessResult(data: testCartEntity));
    provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));
  });

  group('CartCubit Tests', () {
    test('Initial state should be CartState()', () {
      expect(
        CartCubit(
          mockGetUserCartUseCase,
          mockClearSpecificCartItemUseCase,
          mockClearUserCartUseCase,
          mockUpdateCartProductQuantityUseCase,
        ).state,
        CartState(),
      );
    });

    group('GetUserCartEvent', () {
      blocTest<CartCubit, CartState>(
        'emits success state when getUserCartUseCase succeeds',
        build: () {
          when(mockGetUserCartUseCase.invoke())
              .thenAnswer((_) async => ApiSuccessResult(data: testCartEntity));
          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          );
        },
        act: (cubit) => cubit.doIntent(GetUserCartEvent()),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.cartEntity, 'cartEntity', testCartEntity),
        ],
        verify: (_) {
          verify(mockGetUserCartUseCase.invoke()).called(1);
        },
      );

      blocTest<CartCubit, CartState>(
        'emits failure state when getUserCartUseCase fails',
        build: () {
          when(mockGetUserCartUseCase.invoke())
              .thenAnswer((_) async => ApiErrorResult(failure: testFailure));
          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          );
        },
        act: (cubit) => cubit.doIntent(GetUserCartEvent()),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.cartFailure, 'cartFailure', testFailure),
        ],
      );
    });

    group('UpdateCartProductQuantityEvent', () {
      blocTest<CartCubit, CartState>(
        'updates cart successfully when use case succeeds',
        build: () {
          when(mockUpdateCartProductQuantityUseCase.invoke(
            quantity: anyNamed('quantity'),
            productId: anyNamed('productId'),
          )).thenAnswer((_) async => ApiSuccessResult(data: null));

          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          )..emit(CartState(cartEntity: testCartEntity));
        },
        act: (cubit) => cubit.doIntent(
          UpdateCartProductQuantityEvent(),
          productId: 'p1',
          quantity: 2,
          isIncrement: true,
        ),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.loadingProducts?['p1'], 'loadingProducts', true),
          isA<CartState>().having((s) => s.loadingProducts?['p1'], 'loadingProducts', false),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits failure state when updateCartProductQuantityUseCase fails',
        build: () {
          when(mockUpdateCartProductQuantityUseCase.invoke(
            quantity: anyNamed('quantity'),
            productId: anyNamed('productId'),
          )).thenAnswer((_) async => ApiErrorResult(failure: testFailure));

          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          )..emit(CartState(cartEntity: testCartEntity));
        },
        act: (cubit) => cubit.doIntent(
          UpdateCartProductQuantityEvent(),
          productId: 'p1',
          quantity: 2,
          isIncrement: true,
        ),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.isCartQuantityFail, 'isCartQuantityFail', true),
        ],
      );
    });

    group('ClearSpecificCartItemEvent', () {
      blocTest<CartCubit, CartState>(
        'removes product from cart successfully',
        build: () {
          when(mockClearSpecificCartItemUseCase.invoke(productId: 'p1'))
              .thenAnswer((_) async => ApiSuccessResult(data: null));
          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          )..emit(CartState(cartEntity: testCartEntity));
        },
        act: (cubit) => cubit.doIntent(ClearSpecificCartItemEvent(), productId: 'p1'),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.cartEntity!.products.isEmpty, 'products', true),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits failure when clearSpecificCartItem fails',
        build: () {
          when(mockClearSpecificCartItemUseCase.invoke(productId: 'p1'))
              .thenAnswer((_) async => ApiErrorResult(failure: testFailure));
          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          )..emit(CartState(cartEntity: testCartEntity));
        },
        act: (cubit) => cubit.doIntent(ClearSpecificCartItemEvent(), productId: 'p1'),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.isClearSpecificCartItemFail, 'isClearSpecificCartItemFail', true),
        ],
      );
    });

    group('ClearUserCartEvent', () {
      blocTest<CartCubit, CartState>(
        'clears cart successfully',
        build: () {
          when(mockClearUserCartUseCase.invoke())
              .thenAnswer((_) async => ApiSuccessResult(data: null));
          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          )..emit(CartState(cartEntity: testCartEntity));
        },
        act: (cubit) => cubit.doIntent(ClearUserCartEvent()),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.cartEntity!.products.isEmpty, 'products', true),
        ],
      );

      blocTest<CartCubit, CartState>(
        'emits failure when clearUserCart fails',
        build: () {
          when(mockClearUserCartUseCase.invoke())
              .thenAnswer((_) async => ApiErrorResult(failure: testFailure));
          return CartCubit(
            mockGetUserCartUseCase,
            mockClearSpecificCartItemUseCase,
            mockClearUserCartUseCase,
            mockUpdateCartProductQuantityUseCase,
          )..emit(CartState(cartEntity: testCartEntity));
        },
        act: (cubit) => cubit.doIntent(ClearUserCartEvent()),
        expect: () => <dynamic>[
          isA<CartState>().having((s) => s.isClearUserCartFail, 'isClearUserCartFail', true),
        ],
      );
    });
  });
}

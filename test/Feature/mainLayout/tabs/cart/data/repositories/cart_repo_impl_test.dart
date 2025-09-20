import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/data/dataSources/cart_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/data/repositories/cart_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/repositories/cart_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_repo_impl_test.mocks.dart';

@GenerateMocks([CartRemoteDataSource])
void main() {
  late CartRepo repo;
  late MockCartRemoteDataSource mockRemoteDataSource;

  late CartEntity mockCartEntity;

  setUp(() {
    mockRemoteDataSource = MockCartRemoteDataSource();
    repo = CartRepoImpl(mockRemoteDataSource);

    mockCartEntity = CartEntity(
      products: [
        CartProductEntity(
          productId: 'p1',
          productName: 'Rose',
          productImage: 'https://example.com/rose.jpg',
          productPrice: 100,
          priceAfterDiscount: 80,
          quantity: 2,
        ),
      ],
      totalPrice: 200,
      numberOfCartItems: 1,
    );

    provideDummy<ApiResult<void>>(ApiSuccessResult(data: null));
    provideDummy<ApiResult<CartEntity>>(ApiSuccessResult(data: mockCartEntity));
  });

  group('CartRepoImpl tests', () {
    test('success case for clearSpecificCartItem', () async {
      // arrange
      when(
        mockRemoteDataSource.clearSpecificCartItem(productId: '123'),
      ).thenAnswer((_) async => ApiSuccessResult(data: null));

      // act
      final result = await repo.clearSpecificCartItem(productId: '123');

      // assert
      expect(result, isA<ApiSuccessResult<void>>());
    });

    test('failure case for clearSpecificCartItem', () async {
      // arrange
      when(
        mockRemoteDataSource.clearSpecificCartItem(productId: '123'),
      ).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: "Server error")),
      );

      // act
      final result = await repo.clearSpecificCartItem(productId: '123');

      // assert
      expect(result, isA<ApiErrorResult<void>>());
    });

    test('success case for clearUserCart', () async {
      // arrange
      when(
        mockRemoteDataSource.clearUserCart(),
      ).thenAnswer((_) async => ApiSuccessResult(data: null));

      // act
      final result = await repo.clearUserCart();

      // assert
      expect(result, isA<ApiSuccessResult<void>>());
    });

    test('failure case for clearUserCart', () async {
      // arrange
      when(mockRemoteDataSource.clearUserCart()).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: "Server error")),
      );

      // act
      final result = await repo.clearUserCart();

      // assert
      expect(result, isA<ApiErrorResult<void>>());
    });

    test('success case for getUserCart', () async {
      // arrange
      when(
        mockRemoteDataSource.getUserCart(),
      ).thenAnswer((_) async => ApiSuccessResult(data: mockCartEntity));

      // act
      final result = await repo.getUserCart();

      // assert
      expect(result, isA<ApiSuccessResult<CartEntity>>());
      expect((result as ApiSuccessResult).data.totalPrice, 200);
    });

    test('failure case for getUserCart', () async {
      // arrange
      when(mockRemoteDataSource.getUserCart()).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: "Server error")),
      );

      // act
      final result = await repo.getUserCart();

      // assert
      expect(result, isA<ApiErrorResult<CartEntity>>());
    });

    test('success case for updateCartProductQuantity', () async {
      // arrange
      final quantity = UpdateCartQuantityInput(2);
      when(
        mockRemoteDataSource.updateCartProductQuantity(
          quantity: quantity,
          productId: 'prod123',
        ),
      ).thenAnswer((_) async => ApiSuccessResult(data: null));

      // act
      final result = await repo.updateCartProductQuantity(
        quantity: quantity,
        productId: 'prod123',
      );

      // assert
      expect(result, isA<ApiSuccessResult<void>>());
    });

    test('failure case for updateCartProductQuantity', () async {
      // arrange
      final quantity = UpdateCartQuantityInput(2);
      when(
        mockRemoteDataSource.updateCartProductQuantity(
          quantity: quantity,
          productId: 'prod123',
        ),
      ).thenAnswer(
        (_) async =>
            ApiErrorResult(failure: Failure(errorMessage: "Server error")),
      );

      // act
      final result = await repo.updateCartProductQuantity(
        quantity: quantity,
        productId: 'prod123',
      );

      // assert
      expect(result, isA<ApiErrorResult<void>>());
    });
  });
}

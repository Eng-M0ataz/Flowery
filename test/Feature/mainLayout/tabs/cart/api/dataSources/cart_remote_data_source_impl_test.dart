import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/client/cart_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/dataSources/cart_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_item_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/product_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CartApiService])
void main() {
  late CartRemoteDataSourceImpl dataSource;
  late MockCartApiService mockApiService;

  late CartResponseDto mockCartResponse;

  setUp(() {
    mockApiService = MockCartApiService();
    dataSource = CartRemoteDataSourceImpl(mockApiService);

    mockCartResponse = CartResponseDto(
      message: "Success",
      cart: CartDto(
        id: "1",
        user: "user123",
        cartItems: [
          CartItemDto(
            id: "item1",
            price: 100,
            quantity: 1,
            product: ProductDto(
              id: "p1",
              title: "Flower",
              slug: "flower",
              description: "Beautiful flower",
              price: 100,
              priceAfterDiscount: 90,
            ),
          ),
        ],
        totalPrice: 100,
      ),
    );
  });

  group('CartRemoteDataSourceImpl Tests', () {
    test('success case for getUserCart returns CartEntity', () async {
      // arrange
      when(
        mockApiService.getUserCart(),
      ).thenAnswer((_) async => mockCartResponse);

      // act
      final result = await dataSource.getUserCart();

      // assert
      expect(result, isA<ApiSuccessResult<CartEntity>>());
    });

    test('failure case for getUserCart throws exception', () async {
      // arrange
      when(mockApiService.getUserCart()).thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.getUserCart();

      // assert
      expect(result, isA<ApiErrorResult>());
    });

    test('success case for clearUserCart', () async {
      // arrange
      when(
        mockApiService.clearUserCart(),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await dataSource.clearUserCart();

      // assert
      expect(result, isA<ApiSuccessResult<void>>());
    });

    test('failure case for clearUserCart throws exception', () async {
      // arrange
      when(mockApiService.clearUserCart()).thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.clearUserCart();

      // assert
      expect(result, isA<ApiErrorResult>());
    });

    test('success case for clearSpecificCartItem', () async {
      // arrange
      when(
        mockApiService.clearSpecificCartItem(productId: "p1"),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await dataSource.clearSpecificCartItem(productId: "p1");

      // assert
      expect(result, isA<ApiSuccessResult<void>>());
    });

    test('failure case for clearSpecificCartItem throws exception', () async {
      // arrange
      when(
        mockApiService.clearSpecificCartItem(productId: "p1"),
      ).thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.clearSpecificCartItem(productId: "p1");

      // assert
      expect(result, isA<ApiErrorResult>());
    });

    test('success case for updateCartProductQuantity', () async {
      // arrange
      final quantityDto = UpdateCartQuantityInput(2);

      when(
        mockApiService.updateCartProductQuantity(
          productId: "p1",
          updateCartQuantityDto: quantityDto,
        ),
      ).thenAnswer((_) async => Future.value());

      // act
      final result = await dataSource.updateCartProductQuantity(
        productId: "p1",
        quantity: quantityDto,
      );

      // assert
      expect(result, isA<ApiSuccessResult<void>>());
    });

    test(
      'failure case for updateCartProductQuantity throws exception',
      () async {
        // arrange
        final quantityDto = UpdateCartQuantityInput(2);

        when(
          mockApiService.updateCartProductQuantity(
            productId: "p1",
            updateCartQuantityDto: quantityDto,
          ),
        ).thenThrow(Exception('Server error'));

        // act
        final result = await dataSource.updateCartProductQuantity(
          productId: "p1",
          quantity: quantityDto,
        );

        // assert
        expect(result, isA<ApiErrorResult>());
      },
    );
  });
}

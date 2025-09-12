import 'package:flower_e_commerce_app/Feature/checkout/api/client/checkout_api_service.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/dataSources/checkout_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/address_dto.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/cash_order_dto.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/user_address_dto.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/visa_order_dto.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/cash_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/user_address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/visa_order_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([CheckoutApiService])
void main() {
  late CheckoutRemoteDataSourceImpl dataSource;
  late MockCheckoutApiService mockApiService;

  late CashOrderDto mockCashOrderDto;
  late VisaOrderDto mockVisaOrderDto;
  late UserAddressDto mockUserAddressDto;

  final shippingAddressEntity = ShippingAddressEntity(
    street: "Test Street",
    phone: "0100000000",
    city: "Cairo",
    lat: 30.0444,
    long: 31.2357,

  );

  setUp(() {
    mockApiService = MockCheckoutApiService();
    dataSource = CheckoutRemoteDataSourceImpl(mockApiService);

    mockCashOrderDto = CashOrderDto(
      message: "Cash Order Success",
      order: Order(
        user: "1",
        totalPrice: 500,
        paymentType: "cash",
        isPaid: false,
        isDelivered: false,
        state: "pending",
        id: "order123",
        createdAt: "2025-01-01T00:00:00Z",
        updatedAt: "2025-01-01T00:00:00Z",
        orderNumber: "ORD001",
        V: 0,
        orderItems: [],
      ),
    );

    mockVisaOrderDto = VisaOrderDto(
      message: "Visa Order Success",
      session: Session(
        id: "sess_123",
        object: "checkout.session",
        amountTotal: 1000,
        currency: "EGP",
        url: "https://checkout.stripe.com/pay/sess_123",
      ),
    );

    mockUserAddressDto = UserAddressDto(
      message: "Addresses Fetched",
      addresses: [
        AddressDto(
          street: "Test Street",
          phone: "0100000000",
          city: "Cairo",
          lat: "30.0444",
          long: "31.2357",
          username: "Eddick",
          id: "addr_1",
        ),
      ],
    );
  });

  group("CheckoutRemoteDataSourceImpl Tests", () {
    test("success case for createCashOrder", () async {
      when(mockApiService.createCashOrder(any))
          .thenAnswer((_) async => mockCashOrderDto);

      final result =
      await dataSource.createCashOrder(addressRequest: shippingAddressEntity);

      expect(result, isA<ApiSuccessResult<CashOrderEntity>>());
    });

    test("failure case for createCashOrder", () async {
      when(mockApiService.createCashOrder(any))
          .thenThrow(Exception("Server error"));

      final result =
      await dataSource.createCashOrder(addressRequest: shippingAddressEntity);

      expect(result, isA<ApiErrorResult>());
    });

    test("success case for createVisaOrder", () async {
      when(mockApiService.createVisaOrder(any))
          .thenAnswer((_) async => mockVisaOrderDto);

      final result =
      await dataSource.createVisaOrder(addressRequest: shippingAddressEntity);

      expect(result, isA<ApiSuccessResult<VisaOrderEntity>>());
    });

    test("failure case for createVisaOrder", () async {
      when(mockApiService.createVisaOrder(any))
          .thenThrow(Exception("Server error"));

      final result =
      await dataSource.createVisaOrder(addressRequest: shippingAddressEntity);

      expect(result, isA<ApiErrorResult>());
    });

    test("success case for getUserAddress", () async {
      when(mockApiService.getUserAddress())
          .thenAnswer((_) async => mockUserAddressDto);

      final result = await dataSource.getUserAddress();

      expect(result, isA<ApiSuccessResult<UserAddressResponseEntity>>());
    });

    test("failure case for getUserAddress", () async {
      when(mockApiService.getUserAddress())
          .thenThrow(Exception("Server error"));

      final result = await dataSource.getUserAddress();

      expect(result, isA<ApiErrorResult>());
    });
  });
}

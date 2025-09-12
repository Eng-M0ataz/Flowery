import 'package:flower_e_commerce_app/Feature/checkout/data/dataSources/checkout_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/checkout/data/repositories/checkout_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/cash_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/user_address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/visa_order_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'checkout_repo_impl_test.mocks.dart';

@GenerateMocks([CheckoutRemoteDataSource])
void main() {
  late CheckoutRepoImpl repo;
  late MockCheckoutRemoteDataSource mockRemoteDataSource;

  final shippingAddressEntity = ShippingAddressEntity(
    street: "Test Street",
    phone: "0100000000",
    city: "Cairo",
    lat: 30.0444,
    long: 31.2357,
  );

  setUp(() {
    mockRemoteDataSource = MockCheckoutRemoteDataSource();
    repo = CheckoutRepoImpl(mockRemoteDataSource);

    provideDummy<ApiResult<CashOrderEntity>>(
      ApiSuccessResult(
        data: CashOrderEntity(
          message: "success",
        ),
      ),
    );
    provideDummy<ApiResult<CashOrderEntity>>(
      ApiErrorResult(
        failure: Failure(errorMessage: "error"),
      ),
    );

    provideDummy<ApiResult<VisaOrderEntity>>(
      ApiSuccessResult(
        data: VisaOrderEntity(
          message: "success",
        ),
      ),
    );
    provideDummy<ApiResult<VisaOrderEntity>>(
      ApiErrorResult(
        failure: Failure(errorMessage: "error"),
      ),
    );

    provideDummy<ApiResult<UserAddressResponseEntity>>(
      ApiSuccessResult(
        data: UserAddressResponseEntity("success", []),
      ),
    );
    provideDummy<ApiResult<UserAddressResponseEntity>>(
      ApiErrorResult(
        failure: Failure(errorMessage: "error"),
      ),
    );
  });

  group("CheckoutRepoImpl Tests", () {
    test("success case for createCashOrder", () async {
      final mockResult = ApiSuccessResult<CashOrderEntity>(
        data: CashOrderEntity(message: "Cash Order Success"),
      );

      when(mockRemoteDataSource.createCashOrder(
        addressRequest: anyNamed("addressRequest"),
      )).thenAnswer((_) async => mockResult);

      final result = await repo.createCashOrder(
        addressRequest: shippingAddressEntity,
      );

      expect(result, isA<ApiSuccessResult<CashOrderEntity>>());
      expect((result as ApiSuccessResult).data.message, "Cash Order Success");
    });

    test("failure case for createCashOrder", () async {
      final mockResult = ApiErrorResult<CashOrderEntity>(
        failure: Failure(errorMessage: "Server error"),
      );

      when(mockRemoteDataSource.createCashOrder(
        addressRequest: anyNamed("addressRequest"),
      )).thenAnswer((_) async => mockResult);

      final result = await repo.createCashOrder(
        addressRequest: shippingAddressEntity,
      );

      expect(result, isA<ApiErrorResult<CashOrderEntity>>());
    });

    test("success case for createVisaOrder", () async {
      final mockResult = ApiSuccessResult<VisaOrderEntity>(
        data: VisaOrderEntity(
          message: "Visa Order Success",
        ),
      );

      when(mockRemoteDataSource.createVisaOrder(
        addressRequest: anyNamed("addressRequest"),
      )).thenAnswer((_) async => mockResult);

      final result = await repo.createVisaOrder(
        addressRequest: shippingAddressEntity,
      );

      expect(result, isA<ApiSuccessResult<VisaOrderEntity>>());
      expect((result as ApiSuccessResult).data.message, "Visa Order Success");
    });

    test("failure case for createVisaOrder", () async {
      final mockResult = ApiErrorResult<VisaOrderEntity>(
        failure: Failure(errorMessage: "Server error"),
      );

      when(mockRemoteDataSource.createVisaOrder(
        addressRequest: anyNamed("addressRequest"),
      )).thenAnswer((_) async => mockResult);

      final result = await repo.createVisaOrder(
        addressRequest: shippingAddressEntity,
      );

      expect(result, isA<ApiErrorResult<VisaOrderEntity>>());
    });

    test("success case for getUserAddress", () async {
      final mockResult = ApiSuccessResult<UserAddressResponseEntity>(
        data: UserAddressResponseEntity(
          "Addresses Fetched",
          [],
        ),
      );

      when(mockRemoteDataSource.getUserAddress())
          .thenAnswer((_) async => mockResult);

      final result = await repo.getUserAddress();

      expect(result, isA<ApiSuccessResult<UserAddressResponseEntity>>());
      expect((result as ApiSuccessResult).data.message, "Addresses Fetched");
    });

    test("failure case for getUserAddress", () async {
      final mockResult = ApiErrorResult<UserAddressResponseEntity>(
        failure: Failure(errorMessage: "Server error"),
      );

      when(mockRemoteDataSource.getUserAddress())
          .thenAnswer((_) async => mockResult);

      final result = await repo.getUserAddress();

      expect(result, isA<ApiErrorResult<UserAddressResponseEntity>>());
    });
  });
}

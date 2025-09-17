import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/user_address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/visa_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/useCases/get_user_address_use_case.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/useCases/create_cash_order_use_case.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/useCases/create_visa_order_use_case.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/viewModels/checkout_view_model.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/viewModels/checkout_state.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/viewModels/checkout_event.dart';

import 'checkout_view_model_test.mocks.dart';

@GenerateMocks([
  GetUserAddressUseCase,
  CreateCashOrderUseCase,
  CreateVisaOrderUseCase,
])
void main() {
  late MockGetUserAddressUseCase mockGetUserAddressUseCase;
  late MockCreateCashOrderUseCase mockCreateCashOrderUseCase;
  late MockCreateVisaOrderUseCase mockCreateVisaOrderUseCase;

  final testFailure = ServerFailure(errorMessage: 'Server Error');

  final testAddress = AddressEntity(
    id: "1",
    city: "Cairo",
    street: "Street 123",
    phone: "01010101010",
  );

  final testUserAddressResponse =
  UserAddressResponseEntity('success', [testAddress]);

  final testVisaOrder = VisaOrderEntity(
    message: 'success',
    url: "https://payment.test",
  );

  setUpAll(() {
    mockGetUserAddressUseCase = MockGetUserAddressUseCase();
    mockCreateCashOrderUseCase = MockCreateCashOrderUseCase();
    mockCreateVisaOrderUseCase = MockCreateVisaOrderUseCase();

    provideDummy<ApiResult<UserAddressResponseEntity>>(
      ApiSuccessResult(data: testUserAddressResponse),
    );
    provideDummy<ApiResult<void>>(
      ApiSuccessResult<void>(data: null),
    );
    provideDummy<ApiResult<VisaOrderEntity>>(
      ApiSuccessResult(data: testVisaOrder),
    );
  });

  group("CheckoutViewModel Tests", () {
    test("Initial state should be CheckoutState()", () {
      expect(
        CheckoutViewModel(
          mockGetUserAddressUseCase,
          mockCreateCashOrderUseCase,
          mockCreateVisaOrderUseCase,
        ).state,
        const CheckoutState(),
      );
    });

    blocTest<CheckoutViewModel, CheckoutState>(
      "LoadUserAddressEvent emits success",
      build: () {
        when(mockGetUserAddressUseCase.call()).thenAnswer(
              (_) async => ApiSuccessResult(data: testUserAddressResponse),
        );

        return CheckoutViewModel(
          mockGetUserAddressUseCase,
          mockCreateCashOrderUseCase,
          mockCreateVisaOrderUseCase,
        );
      },
      act: (cubit) => cubit.doIntent(event: LoadUserAddressEvent()),
      expect: () => [
        isA<CheckoutState>().having(
              (s) => s.userAddressResponse,
          "userAddressResponse",
          testUserAddressResponse,
        ),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutState>(
      "LoadUserAddressEvent emits failure",
      build: () {
        when(mockGetUserAddressUseCase.call()).thenAnswer(
              (_) async => ApiErrorResult(failure: testFailure),
        );

        return CheckoutViewModel(
          mockGetUserAddressUseCase,
          mockCreateCashOrderUseCase,
          mockCreateVisaOrderUseCase,
        );
      },
      act: (cubit) => cubit.doIntent(event: LoadUserAddressEvent()),
      expect: () => [
        isA<CheckoutState>().having(
              (s) => s.addressFailure,
          "addressFailure",
          testFailure,
        ),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutState>(
      "PlaceOrderEvent with cash emits loading then success message",
      build: () {
        when(mockCreateCashOrderUseCase.call(
          addressRequest: anyNamed("addressRequest"),
        )).thenAnswer((_) async => ApiSuccessResult<void>(data: null));

        final vm = CheckoutViewModel(
          mockGetUserAddressUseCase,
          mockCreateCashOrderUseCase,
          mockCreateVisaOrderUseCase,
        );

        // preload valid address + cash
        vm.emit(vm.state.copyWith(
          userAddressResponse: testUserAddressResponse,
          selectedAddressId: "1",
          isCash: true,
        ));
        return vm;
      },
      act: (cubit) => cubit.doIntent(event: PlaceOrderEvent()),
      expect: () => [
        isA<CheckoutState>()
            .having((s) => s.isCashOrderLoading, "isCashOrderLoading", true),
        isA<CheckoutState>().having(
              (s) => s.cashOrderSuccessMessage,
          "cashOrderSuccessMessage",
          "success", // جاي من LocaleKeys.success.tr()
        ),
      ],
    );

    blocTest<CheckoutViewModel, CheckoutState>(
      "PlaceOrderEvent with visa emits loading then VisaOrderEntity",
      build: () {
        when(mockCreateVisaOrderUseCase.call(
          addressRequest: anyNamed("addressRequest"),
        )).thenAnswer((_) async => ApiSuccessResult(data: testVisaOrder));

        final vm = CheckoutViewModel(
          mockGetUserAddressUseCase,
          mockCreateCashOrderUseCase,
          mockCreateVisaOrderUseCase,
        );

        // preload valid address + visa
        vm.emit(vm.state.copyWith(
          userAddressResponse: testUserAddressResponse,
          selectedAddressId: "1",
          isCash: false,
        ));
        return vm;
      },
      act: (cubit) => cubit.doIntent(event: PlaceOrderEvent()),
      expect: () => [
        isA<CheckoutState>()
            .having((s) => s.isVisaOrderLoading, "isVisaOrderLoading", true),
        isA<CheckoutState>().having(
              (s) => s.visaOrderResponse,
          "visaOrderResponse",
          testVisaOrder,
        ),
      ],
    );
  });
}

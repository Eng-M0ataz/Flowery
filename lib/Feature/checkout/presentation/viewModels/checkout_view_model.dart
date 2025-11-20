import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/mapper/address_entity_to_shipping.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/cash_order_entity.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import '../../../../core/Errors/failure.dart';
import '../../domain/entities/response/user_address_response_entity.dart';
import '../../domain/entities/response/visa_order_entity.dart';
import '../../domain/useCases/create_cash_order_use_case.dart';
import '../../domain/useCases/create_visa_order_use_case.dart';
import '../../domain/useCases/get_user_address_use_case.dart';
import 'checkout_event.dart';
import 'checkout_state.dart';

@injectable
class CheckoutViewModel extends Cubit<CheckoutState> {
  final GetUserAddressUseCase _getUserAddressUseCase;
  final CreateCashOrderUseCase _createCashOrderUseCase;
  final CreateVisaOrderUseCase _createVisaOrderUseCase;

  CheckoutViewModel(
    this._getUserAddressUseCase,
    this._createCashOrderUseCase,
    this._createVisaOrderUseCase,
  ) : super(const CheckoutState());

  Future<void> doIntent({required CheckoutEvent event}) async {
    switch (event) {
      case LoadUserAddressEvent():
        await _getUserAddress();
        break;

      case SelectAddressEvent(addressId: final addressId):
        _selectAddress(addressId);
        break;

      case SelectPaymentMethodEvent(isCash: final isCash):
        _selectPaymentMethod(isCash);
        break;

      case PlaceOrderEvent():
        await _placeOrder();
        break;
    }
  }

  Future<void> _placeOrder() async {
    if (state.isCashOrderLoading || state.isVisaOrderLoading) return;
    final selectedId = state.selectedAddressId;
    final addresses = state.userAddressResponse?.addresses ?? [];

    if (selectedId == null) {
      emit(state.copyWith(
        validationFailure:
            Failure(errorMessage: LocaleKeys.please_select_address.tr()),
      ));
      return;
    }

    final selectedAddress = addresses.firstWhere(
      (a) => a.id == selectedId,
      orElse: () => throw Exception(LocaleKeys.no_address_selected.tr()),
    );
    final shippingAddress = selectedAddress.toShippingAddress();

    if (state.isCash) {
      await _createCashOrder(shippingAddress);
    } else {
      await _createVisaOrder(shippingAddress);
    }
  }

  void _selectAddress(String addressId) {
    emit(state.copyWith(selectedAddressId: addressId));
  }

  void _selectPaymentMethod(bool isCash) {
    emit(state.copyWith(
      isCash: isCash,
      cashOrderFailure: null,
      visaOrderResponse: null,
      visaOrderFailure: null,
    ));
  }

  Future<void> _getUserAddress() async {
    emit(state.copyWith(isAddressLoading: true));
    final result = await _getUserAddressUseCase.call();

    switch (result) {
      case ApiSuccessResult<UserAddressResponseEntity>():
        emit(state.copyWith(
          isAddressLoading: false,
          userAddressResponse: result.data,
        ));
        break;

      case ApiErrorResult<UserAddressResponseEntity>():
        emit(state.copyWith(
          isAddressLoading: false,
          addressFailure: result.failure,
        ));
        break;
    }
  }

  Future<void> _createCashOrder(address) async {
    emit(state.copyWith(isCashOrderLoading: true));

    final result = await _createCashOrderUseCase.call(addressRequest: address);

    switch (result) {
      case ApiSuccessResult<CashOrderEntity>():
        emit(state.copyWith(
          isCashOrderLoading: false,
          cashOrderSuccessMessage: LocaleKeys.success.tr(),
          cashOrderResponse: result.data,
        ));
        break;

      case ApiErrorResult<CashOrderEntity>():
        emit(state.copyWith(
          isCashOrderLoading: false,
          cashOrderFailure: result.failure,
          cashOrderSuccessMessage: null,
        ));
        break;

    }
  }

  Future<void> _createVisaOrder(address) async {
    emit(state.copyWith(isVisaOrderLoading: true));

    final result = await _createVisaOrderUseCase.call(addressRequest: address);

    switch (result) {
      case ApiSuccessResult<VisaOrderEntity>():
        emit(state.copyWith(
          isVisaOrderLoading: false,
          visaOrderResponse: result.data,
        ));
        break;

      case ApiErrorResult<VisaOrderEntity>():
        emit(state.copyWith(
          isVisaOrderLoading: false,
          visaOrderFailure: result.failure,
        ));
        break;
    }
  }
}

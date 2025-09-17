import 'package:equatable/equatable.dart';
import '../../../../core/Errors/failure.dart';
import '../../domain/entities/response/user_address_response_entity.dart';
import '../../domain/entities/response/visa_order_entity.dart';

class CheckoutState extends Equatable {
  final bool isAddressLoading;
  final bool isCashOrderLoading;
  final bool isVisaOrderLoading;
  final bool isCash;
  final String? selectedAddressId;

  final Failure? addressFailure;
  final Failure? cashOrderFailure;
  final Failure? visaOrderFailure;
  final Failure? validationFailure;

  final UserAddressResponseEntity? userAddressResponse;
  final String? cashOrderSuccessMessage;

  final VisaOrderEntity? visaOrderResponse;

  const CheckoutState({
    this.isCash = true,
    this.isAddressLoading = true,
    this.isCashOrderLoading = false,
    this.isVisaOrderLoading = false,
    this.selectedAddressId,
    this.addressFailure,
    this.cashOrderFailure,
    this.visaOrderFailure,
    this.validationFailure,
    this.userAddressResponse,
    this.visaOrderResponse,
    this.cashOrderSuccessMessage,
  });

  CheckoutState copyWith({
    bool? isCash,
    bool? isAddressLoading,
    bool? isCashOrderLoading,
    bool? isVisaOrderLoading,
    Failure? addressFailure,
    Failure? cashOrderFailure,
    Failure? visaOrderFailure,
    Failure? validationFailure,
    UserAddressResponseEntity? userAddressResponse,
    VisaOrderEntity? visaOrderResponse,
    String? selectedAddressId,
    String? cashOrderSuccessMessage,
  }) {
    return CheckoutState(
      isAddressLoading: isAddressLoading ?? this.isAddressLoading,
      isCashOrderLoading: isCashOrderLoading ?? this.isCashOrderLoading,
      isVisaOrderLoading: isVisaOrderLoading ?? this.isVisaOrderLoading,
      addressFailure: addressFailure ?? this.addressFailure,
      cashOrderFailure: cashOrderFailure ?? this.cashOrderFailure,
      visaOrderFailure: visaOrderFailure ?? this.visaOrderFailure,
      validationFailure: validationFailure,
      userAddressResponse: userAddressResponse ?? this.userAddressResponse,
      visaOrderResponse: visaOrderResponse ?? this.visaOrderResponse,
      selectedAddressId: selectedAddressId ?? this.selectedAddressId,
      isCash: isCash ?? this.isCash,
      cashOrderSuccessMessage: cashOrderSuccessMessage,
    );
  }

  @override
  List<Object?> get props => [
        isAddressLoading,
        isCashOrderLoading,
        isVisaOrderLoading,
        addressFailure,
        cashOrderFailure,
        visaOrderFailure,
        validationFailure,
        userAddressResponse,
        visaOrderResponse,
        selectedAddressId,
        isCash,
        cashOrderSuccessMessage,
      ];
}

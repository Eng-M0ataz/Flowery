sealed class CheckoutEvent {}

class LoadUserAddressEvent extends CheckoutEvent {}

class SelectAddressEvent extends CheckoutEvent {
  final String addressId;
  SelectAddressEvent({required this.addressId});
}

class SelectPaymentMethodEvent extends CheckoutEvent {
  final bool isCash;
  SelectPaymentMethodEvent({required this.isCash});
}

class PlaceOrderEvent extends CheckoutEvent {}

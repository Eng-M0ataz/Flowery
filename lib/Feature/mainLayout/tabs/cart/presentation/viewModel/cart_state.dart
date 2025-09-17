import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class CartState {
  final bool isCartLoading;
  final bool isCheckOut;
  final bool isCartQuantityFail;
  final bool isClearSpecificCartItemFail;
  final bool isClearUserCartFail;
  final Failure? cartFailure;
  final Failure? updateQuantityFailure;
  final Failure? clearSpecificCartItemFailure;
  final Failure? clearUserCartFailure;
  final CartEntity? cartEntity;
  final Map<String, bool>? loadingProducts;
  final bool isButtonEnabled;

  CartState({
    this.isCartLoading = true,
    this.isCheckOut = false,
    this.isCartQuantityFail = false,
    this.isClearSpecificCartItemFail = false,
    this.isClearUserCartFail = false,
    this.isButtonEnabled = false,
    this.updateQuantityFailure,
    this.clearSpecificCartItemFailure,
    this.clearUserCartFailure,
    this.cartFailure,
    this.cartEntity,
    this.loadingProducts = const {},
  });

  CartState copyWith({
    bool? isCartLoading,
    bool? isCheckOut,
    bool? isClearSpecificCartItemFail,
    Failure? cartFailure,
    CartEntity? cartEntity,
    bool? isUpdating,
    Map<String, bool>? loadingProducts,
    bool? isButtonEnabled,
    Failure? updateQuantityFailure,
    bool? isCartQuantityFail,
    Failure? clearSpecificCartItemFailure,
    bool? isClearUserCartFail,
    Failure? clearUserCartFailure,
  }) {
    return CartState(
      isCartLoading: isCartLoading ?? this.isCartLoading,
      cartFailure: cartFailure ?? this.cartFailure,
      cartEntity: cartEntity ?? this.cartEntity,
      loadingProducts: loadingProducts ?? this.loadingProducts,
      isCheckOut: isCheckOut ?? this.isCheckOut,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      updateQuantityFailure:
          updateQuantityFailure ?? this.updateQuantityFailure,
      isCartQuantityFail: isCartQuantityFail ?? this.isCartQuantityFail,
      clearSpecificCartItemFailure:
          clearSpecificCartItemFailure ?? this.clearSpecificCartItemFailure,
      isClearSpecificCartItemFail:
          isClearSpecificCartItemFail ?? this.isClearSpecificCartItemFail,
      clearUserCartFailure: clearUserCartFailure ?? this.clearUserCartFailure,
      isClearUserCartFail: isClearUserCartFail ?? this.isClearUserCartFail,
    );
  }
}

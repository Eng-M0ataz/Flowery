import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/useCases/clear_specific_cart_item_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/useCases/clear_user_cart_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/useCases/get_user_cart_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/useCases/update_cart_product_quantity_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetUserCartUseCase _getUserCartUseCase;
  final ClearSpecificCartItemUseCase _clearSpecificCartItemUseCase;
  final ClearUserCartUseCase _clearUserCartUseCase;
  final UpdateCartProductQuantityUseCase _updateCartProductQuantityUseCase;

  CartCubit(
    this._getUserCartUseCase,
    this._clearSpecificCartItemUseCase,
    this._clearUserCartUseCase,
    this._updateCartProductQuantityUseCase,
  ) : super(CartState());

  void doIntent(
    CartEvents events, {
    String? productId,
    int? quantity,
    bool? isIncrement,
  }) async {
    switch (events) {
      case GetUserCartEvent():
        await _getUserCart();
      case UpdateCartProductQuantityEvent():
        await _updateCartProductQuantity(
          isIncrement: isIncrement!,
          updateCartQuantity: UpdateCartQuantityInput(
            isIncrement ? quantity! + 1 : quantity! - 1,
          ),
          productId: productId!,
        );
      case ClearSpecificCartItemEvent():
        await _clearSpecificCartItem(productId: productId!);

      case ClearUserCartEvent():
        await _clearUserCart();
    }
  }

  Future<void> _getUserCart() async {
    final result = await _getUserCartUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<CartEntity>():
        emit(
          state.copyWith(
            cartEntity: result.data,
            isCartLoading: false,
            isButtonEnabled: true,
          ),
        );
      case ApiErrorResult<CartEntity>():
        emit(state.copyWith(cartFailure: result.failure, isCartLoading: false));
    }
  }

  Future<void> _updateCartProductQuantity({
    required bool isIncrement,
    required UpdateCartQuantityInput updateCartQuantity,
    required String productId,
  }) async {
    emit(state.copyWith(loadingProducts: {productId: true}));
    final result = await _updateCartProductQuantityUseCase.invoke(
      quantity: updateCartQuantity,
      productId: productId,
    );
    switch (result) {
      case ApiSuccessResult<void>():
        _updateCartProductQuantityLocaly(
          productId: productId,
          updateCartQuantity: updateCartQuantity,
          isIncrement: isIncrement,
        );

        emit(state.copyWith(loadingProducts: {productId: false}));
      case ApiErrorResult<void>():
        emit(
          state.copyWith(
            loadingProducts: {productId: false},
            isCartQuantityFail: true,
            updateQuantityFailure: result.failure,
            clearSpecificCartItemFailure: null,
            isClearSpecificCartItemFail: false,
            isClearUserCartFail: false,
            clearUserCartFailure: null,
          ),
        );
    }
  }

  void _updateCartProductQuantityLocaly({
    required String productId,
    required UpdateCartQuantityInput updateCartQuantity,
    required bool isIncrement,
  }) {
    final cartEntity = state.cartEntity!;
    var product = cartEntity.products.firstWhere(
      (element) => element.productId == productId,
    );

    product.quantity = updateCartQuantity.quantity;

    for (var product in cartEntity.products) {
      if (product.productId == productId) {
        if (isIncrement) {
          cartEntity.totalPrice = cartEntity.totalPrice + product.productPrice!;
        } else {
          cartEntity.totalPrice = cartEntity.totalPrice - product.productPrice!;
        }
      }
    }

    emit(
      state.copyWith(
        cartEntity: cartEntity,
        isCartQuantityFail: false,
        updateQuantityFailure: null,
        isClearSpecificCartItemFail: false,
        clearSpecificCartItemFailure: null,
        isClearUserCartFail: false,
        clearUserCartFailure: null,
      ),
    );
  }

  Future<void> _clearSpecificCartItem({required String productId}) async {
    final result = await _clearSpecificCartItemUseCase.invoke(
      productId: productId,
    );
    switch (result) {
      case ApiSuccessResult<void>():
        _clearSpecificCartItemLocaly(productId: productId);
      case ApiErrorResult<void>():
        emit(
          state.copyWith(
            clearSpecificCartItemFailure: result.failure,
            isClearSpecificCartItemFail: true,
            isCartQuantityFail: false,
            updateQuantityFailure: null,
            isClearUserCartFail: false,
            clearUserCartFailure: null,
          ),
        );
    }
  }

  void _clearSpecificCartItemLocaly({required String productId}) {
    CartEntity cartEntity = state.cartEntity!;
    final double oldCartTotalPrice = cartEntity.totalPrice;
    final CartProductEntity currentProduct = cartEntity.products.firstWhere(
      (element) => element.productId == productId,
    );
    final productPrice = currentProduct.productPrice!;
    final productQuantity = currentProduct.quantity!;

    cartEntity.totalPrice = oldCartTotalPrice - productPrice * productQuantity;

    cartEntity.products.removeWhere(
      (element) => element.productId == productId,
    );
    cartEntity.numberOfCartItems--;

    emit(
      state.copyWith(
        cartEntity: cartEntity,
        isClearSpecificCartItemFail: false,
        clearSpecificCartItemFailure: null,
        isCartQuantityFail: false,
        updateQuantityFailure: null,
        isClearUserCartFail: false,
        clearUserCartFailure: null,
      ),
    );
  }

  Future<void> _clearUserCart() async {
    if (state.cartEntity!.products.isNotEmpty) {
      final result = await _clearUserCartUseCase.invoke();
      switch (result) {
        case ApiSuccessResult<void>():
          _clearUserCartLocaly();
        case ApiErrorResult<void>():
          emit(
            state.copyWith(
              clearUserCartFailure: result.failure,
              isClearUserCartFail: true,
              isCartQuantityFail: false,
              updateQuantityFailure: null,
              clearSpecificCartItemFailure: null,
              isClearSpecificCartItemFail: false,
            ),
          );
      }
    }
  }

  void _clearUserCartLocaly() {
    state.cartEntity!.products.clear();
    state.cartEntity!.totalPrice = 0;
    state.cartEntity!.numberOfCartItems = 0;
    emit(
      state.copyWith(
        cartEntity: state.cartEntity,
        clearSpecificCartItemFailure: null,
        isClearSpecificCartItemFail: false,
        isCartQuantityFail: false,
        updateQuantityFailure: null,
        isClearUserCartFail: false,
        clearUserCartFailure: null,
      ),
    );
  }
}

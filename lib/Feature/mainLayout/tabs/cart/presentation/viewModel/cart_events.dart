sealed class CartEvents {}

class GetUserCartEvent extends CartEvents {}

class UpdateCartProductQuantityEvent extends CartEvents {}

class ClearSpecificCartItemEvent extends CartEvents {}

class ClearUserCartEvent extends CartEvents {}

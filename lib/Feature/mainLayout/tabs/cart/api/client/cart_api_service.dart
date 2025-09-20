import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'cart_api_service.g.dart';

@RestApi()
@injectable
abstract class CartApiService {
  @factoryMethod
  factory CartApiService(Dio dio) = _CartApiService;

  @DELETE(ApiConstants.removeAndUpdateSpesificUserCartItem)
  Future<void> clearSpecificCartItem({@Path() required String productId});

  @GET(ApiConstants.getAndClearUserCart)
  Future<CartResponseDto> getUserCart();

  @PUT(ApiConstants.removeAndUpdateSpesificUserCartItem)
  Future<void> updateCartProductQuantity({
    @Path() required String productId,
    @Body() required UpdateCartQuantityInput updateCartQuantityDto,
  });

  @DELETE(ApiConstants.getAndClearUserCart)
  Future<void> clearUserCart();
}

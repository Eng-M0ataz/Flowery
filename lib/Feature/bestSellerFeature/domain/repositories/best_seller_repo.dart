import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class BestSellerRepo{
  Future<ApiResult<BestSellerResponseEntity>> getBestSellers();
}
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/repositories/best_seller_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerUseCase{
  final BestSellerRepo _repo;
  BestSellerUseCase(this._repo);

  Future<ApiResult<BestSellerResponseEntity>> invoke(){
    return _repo.getBestSellers();
  }
}
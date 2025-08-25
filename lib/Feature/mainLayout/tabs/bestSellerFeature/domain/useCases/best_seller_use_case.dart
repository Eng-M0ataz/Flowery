import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/domain/repositories/best_seller_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class BestSellerUseCase{
  final BestSellerRepo repo;
  BestSellerUseCase({required this.repo});

  Future<ApiResult<BestSellerResponseEntity>> invoke(){
    return repo.getBestSellers();
  }
}
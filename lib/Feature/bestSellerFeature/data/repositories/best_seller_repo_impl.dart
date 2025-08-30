import 'package:flower_e_commerce_app/Feature/bestSellerFeature/data/dataSource/best_seller_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/repositories/best_seller_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRepo)
class BestSellerRepoImpl implements BestSellerRepo {
  final BestSellerRemoteDataSource dataSource;
  BestSellerRepoImpl({required this.dataSource});

  @override
  Future<ApiResult<BestSellerResponseEntity>> getBestSellers() async {
    ApiResult<BestSellerResponseEntity> result = await dataSource.getAllBestSeller();
    return result;
  }
}
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/data/dataSource/best_seller_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/bestSellerFeature/domain/repositories/best_seller_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRepo)
class BestSellerRepoImpl implements BestSellerRepo {
  final BestSellerRemoteDataSource dataSource;
  BestSellerRepoImpl({required this.dataSource});

  @override
  Future<ApiResult<BestSellerResponseEntity>> getBestSellers() {
    return dataSource.getAllBestSeller();
  }
}
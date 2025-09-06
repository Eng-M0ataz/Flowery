import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/response/product_by_occasion_response_entity.dart';
import '../repositories/occasion_repo.dart';

@injectable
class GetProductsByOccasionUseCase {
  final OccasionRepo _occasionRepo;

  GetProductsByOccasionUseCase(this._occasionRepo);

  Future<ApiResult<ProductByOccasionResponseEntity>> invoke(String occasionId) {
    return _occasionRepo.getProductsByOccasion(occasionId);
  }
}

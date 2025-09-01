import 'package:flower_e_commerce_app/Feature/occasion/domain/repositories/occasion_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/response/occasion_response_entity.dart';

@injectable
class GetAllOccasionUseCase {
  final OccasionRepo _occasionRepo;

  GetAllOccasionUseCase(this._occasionRepo);

  Future<ApiResult<OccasionResponseEntity>> invoke() {
    return _occasionRepo.getAllOccasions();
  }
}

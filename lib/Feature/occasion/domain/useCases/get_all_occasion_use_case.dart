import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/response/occasion_response_entity.dart';
import '../repositories/occasion_repo.dart';

@injectable
class GetAllOccasionUseCase {
  final OccasionRepo _occasionRepo;

  GetAllOccasionUseCase(this._occasionRepo);

  Future<ApiResult<OccasionResponseEntity>> invoke() {
    return _occasionRepo.getAllOccasions();
  }
}

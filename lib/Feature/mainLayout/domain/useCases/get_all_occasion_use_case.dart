import 'package:flower_e_commerce_app/Feature/mainLayout/domain/repositories/home_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/response/occasion_response_entity.dart';

@injectable
class GetAllOccasionUseCase {
  final HomeRepo _homeRepo;

  GetAllOccasionUseCase(this._homeRepo);

  Future<ApiResult<OccasionResponseEntity>> invoke() {
    return _homeRepo.getAllOccasions();
  }
}

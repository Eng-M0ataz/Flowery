  import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import '../../domain/entities/response/product_by_occasion_response_entity.dart';
import '../../domain/useCases/get_all_occasion_use_case.dart';
import '../../domain/useCases/get_products_by_occasion_use_case.dart';
import 'occasion_event.dart';
import 'occasion_state.dart';

@injectable
class OccasionViewModel extends Cubit<OccasionState> {
  final GetAllOccasionUseCase _getAllOccasionUseCase;
  final GetProductsByOccasionUseCase _getProductsByOccasionUseCase;

  OccasionViewModel(
    this._getAllOccasionUseCase,
    this._getProductsByOccasionUseCase,
  ) : super(OccasionState());

  Future<void> doIntent(OccasionEvent event, {required String occasionId}) async {
    switch (event) {
      case LoadProductsByOccasionEvent():
        await _getProductsByOccasion(occasionId);
        break;
      case GetAllOccasionsEvent():
        _getAllOccasionData(occasionId);
        break;
    }
  }

  void _getAllOccasionData(String occasionId) {
    _getAllOccasions();
    _getProductsByOccasion(occasionId);
  }

  Future<void> _getAllOccasions() async {
    final result = await _getAllOccasionUseCase.invoke();

    switch (result) {
      case ApiSuccessResult<OccasionResponseEntity>():
        emit(state.copyWith(
          isOccasionLoading: false,
          occasionResponse: result.data,
        ));

        break;

      case ApiErrorResult<OccasionResponseEntity>():
        emit(state.copyWith(
          isOccasionLoading: false,
          occasionFailure: result.failure,
        ));
        break;
    }
  }

  Future<void> _getProductsByOccasion(String occasionId) async {
    final result = await _getProductsByOccasionUseCase.invoke(occasionId);

    switch (result) {
      case ApiSuccessResult<ProductByOccasionResponseEntity>():
        emit(state.copyWith(
          isProductLoading: false,
          productResponse: result.data,
        ));
        break;

      case ApiErrorResult<ProductByOccasionResponseEntity>():
        emit(state.copyWith(
          isProductLoading: false,
          productFailure: result.failure,
        ));
        break;
    }
  }
}

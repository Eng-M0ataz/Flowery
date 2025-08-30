import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/useCases/best_seller_use_case.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';
import 'best_seller_event.dart';

@injectable
class BestSellerViewModel extends Cubit<BestSellerState> {
  final BestSellerUseCase _useCase;
  BestSellerViewModel(this._useCase)
      : super(BestSellerState());

  Future<void> doIntent(BestSellerEvent event) async {
    switch (event) {
      case GetAllBestSellersEvent():
        await _getAllBestSellers();
        break;
    }
  }

  Future<void> _getAllBestSellers() async {
    emit(state.copyWith(isSuccess: false, isLoading: true, errorMessage: null));

    final result = await _useCase.invoke();
    switch (result) {
      case ApiSuccessResult<BestSellerResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          bestSellers: result.data,
          isSuccess: true,
        ));
        break;
      case ApiErrorResult<BestSellerResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          bestSellers: null,
          isSuccess: false,
        ));
        break;
    }
  }
}
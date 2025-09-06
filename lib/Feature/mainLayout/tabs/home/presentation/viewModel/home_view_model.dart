import 'package:flower_e_commerce_app/Feature/bestSeller/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSeller/domain/useCases/best_seller_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/viewModel/home_state.dart';
import 'package:flower_e_commerce_app/Feature/occasions/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasions/domain/useCases/get_all_occasion_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  final GetAllOccasionUseCase getAllOccasionUseCase;
  final BestSellerUseCase getBestSallerUseCase;
  final CategoriesUseCase categoriesUseCase;

  HomeViewModel(this.getAllOccasionUseCase, this.getBestSallerUseCase,
      this.categoriesUseCase)
      : super(const HomeState());

  void doIntent(HomeEvents events) {
    switch (events) {
      case GetAllHomeEvent():
        _getAllHome();
    }
  }

  _getAllHome() {
    _getAllBestSaller();
    _getAllOccasions();
    _getAllCategories();
  }

  Future<void> _getAllOccasions() async {
    final result = await getAllOccasionUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<OccasionResponseEntity>():
        emit(
          state.copyWith(
            isOccasionLoading: false,
            occasionsList: result.data.occasions,
          ),
        );

      case ApiErrorResult<OccasionResponseEntity>():
        emit(
          state.copyWith(
            isOccasionLoading: false,
            occasionFailure: result.failure,
          ),
        );
    }
  }

  Future<void> _getAllBestSaller() async {
    final result = await getBestSallerUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<BestSellerResponseEntity>():
        emit(
          state.copyWith(
            isBestSallerLoading: false,
            bestSallerList: result.data.bestSeller,
          ),
        );
      case ApiErrorResult<BestSellerResponseEntity>():
        emit(
          state.copyWith(
            isBestSallerLoading: false,
            bestSallerFailure: result.failure,
          ),
        );
    }
  }

  Future<void> _getAllCategories() async {
    final result = await categoriesUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<CategoryResponseEntity>():
        emit(
          state.copyWith(
            isCategoriesLoading: false,
            categoriesList: result.data.categories,
          ),
        );

      case ApiErrorResult<CategoryResponseEntity>():
        emit(
          state.copyWith(
            isCategoriesLoading: false,
            categoriesFailure: result.failure,
          ),
        );
    }
  }
}

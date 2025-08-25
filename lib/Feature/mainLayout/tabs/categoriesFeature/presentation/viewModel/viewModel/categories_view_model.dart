import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/category_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/useCases/categories_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/events/categories_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/viewModel/states/categories_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesViewModel extends Cubit<CategoriesState> {
  final CategoriesUseCase _categoriesUseCase;

  CategoriesViewModel(this._categoriesUseCase) : super(CategoriesState());

  Future<void> doIntent(CategoriesEvent event) async {
    switch (event) {
      case GetAllCategoriesEvent():
        await _getAllCategories();
    }
  }

  Future<void> _getAllCategories() async {
    emit(state.copyWith(isSuccess: false, isLoading: true, errorMessage: null));

    final result = await _categoriesUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<CategoryResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          response: result.data,
          isSuccess: true,
        ));
        break;
      case ApiErrorResult<CategoryResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          response: null,
          isSuccess: false,
        ));
        break;
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/add_product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/useCases/add_product_to_cart_use_case.dart';
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
  final AddProductToCartUseCase _addProductToCartUseCase;

  OccasionViewModel(
    this._getAllOccasionUseCase,
    this._getProductsByOccasionUseCase,
    this._addProductToCartUseCase,
  ) : super(OccasionState());

  Future<void> doIntent(OccasionEvent event) async {
    switch (event) {
      case LoadProductsByOccasionEvent():
        await _getProductsByOccasion(event.occasionId);
        break;
      case GetAllOccasionsEvent():
        _getAllOccasionData(event.occasionId);
        break;
      case AddProductToCartEvent():
        await _addProductToCart(event.productId);
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
    emit(state.copyWith(isProductLoading: true));
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

  Future<void> _addProductToCart(String productId) async {
    emit(state.copyWith(productId: productId, isAddingToCartLoading: true));
    final result = await _addProductToCartUseCase.invoke(productId);

    switch (result) {
      case ApiSuccessResult<AddProductResponseEntity>():
        emit(state.copyWith(
          productId: null,
          isAddingToCartLoading: false,
          addToCartResponse: result.data,
        ));
        break;
      case ApiErrorResult<AddProductResponseEntity>():
        emit(state.copyWith(
          productId: null,
          isAddingToCartLoading: false,
          addToCartFailure: result.failure,
        ));
        break;
    }
  }
}

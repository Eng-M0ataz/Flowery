import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/useCases/best_seller_use_case.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_event.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_state.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/add_product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/useCases/add_product_to_cart_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';

@injectable
class BestSellerViewModel extends Cubit<BestSellerState> {
  final BestSellerUseCase _useCase;
  final AddProductToCartUseCase _addProductToCartUseCase;

  BestSellerViewModel(this._useCase, this._addProductToCartUseCase)
      : super(BestSellerState());

  Future<void> doIntent(BestSellerEvent event) async {
    switch (event) {
      case GetAllBestSellersEvent():
        await _getAllBestSellers();
        break;
      case AddProductToCartEvent():
        await _addProductToCart(event.productId);
        break;
    }
  }

  Future<void> _getAllBestSellers() async {
    final result = await _useCase.invoke();
    switch (result) {
      case ApiSuccessResult<BestSellerResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          bestSellers: result.data,
        ));
        break;
      case ApiErrorResult<BestSellerResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          bestSellerFailure: result.failure,
        ));
        break;
    }
  }

  Future<void> _addProductToCart(String productId) async {
    emit(state.copyWith(selectedBestSellerId: productId));
    final result = await _addProductToCartUseCase.invoke(productId);

    switch (result) {
      case ApiSuccessResult<AddProductResponseEntity>():
        emit(state.copyWith(
          addToCartResponse: result.data,
          selectedBestSellerId: null,
        ));
        break;
      case ApiErrorResult<AddProductResponseEntity>():
        emit(state.copyWith(
          addToCartFailure: result.failure,
          selectedBestSellerId: null,
        ));
        break;
    }
  }
}

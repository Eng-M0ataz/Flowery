import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/responseEntities/order_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/useCases/orders_use_case.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/presentation/viewModels/orders_event.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'orders_state.dart';
@injectable
class OrdersViewModel extends Cubit<OrdersState> {
  final OrdersUseCase _useCase;
  OrdersViewModel(this._useCase)
      : super(const OrdersState());

  Future<void> doIntent(OrdersEvent event) async {
    switch (event) {
      case GetAllOrdersEvent():
        await _getAllOrders();
        break;
    }
  }


  Future<void> _getAllOrders() async {
    emit(state.copyWith(
      isLoading: true,
      isSuccess: false,
      orderFailure: null,
      orders: null,
    ));
    final result = await _useCase.invoke();
    switch(result) {
      case ApiSuccessResult<OrdersResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          isSuccess: true,
          orderFailure: null,
          orders: result.data,
        ));
        break;

      case ApiErrorResult<OrdersResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          isSuccess: false,
          orderFailure: result.failure,
          orders: null,
        ));
        break;
    }
  }
}

part of 'orders_view_model.dart';

@immutable
class OrdersState extends Equatable {
  final bool isLoading;
  final Failure? orderFailure;
  final OrdersResponseEntity? orders;
  final bool isSuccess;

  const OrdersState({
    this.isLoading = false,
    this.orderFailure,
    this.orders,
    this.isSuccess = false
  });

  OrdersState copyWith({
    bool? isLoading,
    Failure? orderFailure,
    bool? isSuccess,
    OrdersResponseEntity? orders,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      orderFailure: orderFailure ?? this.orderFailure,
      isSuccess: isSuccess ?? this.isSuccess,
      orders: orders ?? this.orders
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    orderFailure,
    isSuccess,
    orders
  ];
}



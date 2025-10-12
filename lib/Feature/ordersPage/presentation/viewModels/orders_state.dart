part of 'orders_view_model.dart';

@immutable
class OrdersState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final Failure? orderFailure;
  final OrdersResponseEntity? orders;

  const OrdersState({
    this.isLoading = false,
    this.isSuccess = false,
    this.orderFailure,
    this.orders,
  });

  OrdersState copyWith({
    bool? isLoading,
    bool? isSuccess,
    Failure? orderFailure,
    OrdersResponseEntity? orders,
  }) {
    return OrdersState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,

      orderFailure: orderFailure ?? this.orderFailure,
      orders: orders ?? this.orders,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    orderFailure,
    orders
  ];
}



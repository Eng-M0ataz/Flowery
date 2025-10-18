import 'dart:async';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_event.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/useCases/track_order_use_case.dart';
import 'package:flower_e_commerce_app/core/errors/failure.dart';

@injectable
class TrackOrderViewModel extends Cubit<TrackOrderState> {
  TrackOrderViewModel(this._trackOrderUseCase) : super(TrackOrderState());

  final TrackOrderUseCase _trackOrderUseCase;
  StreamSubscription<OrderDetailsEntity>? _orderSubscription;

  Future<void> doIntend(TrackOrderEvent event) async {
    switch (event) {
      case StartListeningOrderEvent():
        _startListening(event.path);
        break;
      case StopListeningOrderEvent():
        _stopListening();
        break;
    }
  }

  void _startListening(String path) {
    emit(state.copyWith(isListening: true));

    _orderSubscription = _trackOrderUseCase.listenData(path).listen(
      (entity) {
        emit(state.copyWith(entity: entity, isListening: true));
      },
      onError: (error) {
        emit(state.copyWith(
          isListening: false,
          failure: Failure(errorMessage: error.toString()),
        ));
      },
    );
  }

  void _stopListening() {
    _orderSubscription?.cancel();
    emit(state.copyWith(isListening: false));
  }

  @override
  Future<void> close() {
    _orderSubscription?.cancel();
    return super.close();
  }
}

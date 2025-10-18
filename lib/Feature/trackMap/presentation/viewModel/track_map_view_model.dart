import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/useCases/get_route_use_case.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_event.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TrackMapViewModel extends Cubit<TrackMapState> {
  final GetRouteUseCase _getRouteUseCase;

  TrackMapViewModel(this._getRouteUseCase) : super(const TrackMapState());

  Future<void> doIntent(TrackMapEvents event) async {
    switch (event) {
      case GetRouteEvent():
        await _handleGetRoute(event);
    }
  }

  Future<void> _handleGetRoute(GetRouteEvent event) async {
    emit(state.copyWith(isLoading: true));

    final result = await _getRouteUseCase(
      apiKey: event.apiKey,
      fieldMask: event.fieldMask,
      body: event.body,
    );

    switch (result) {
      case ApiSuccessResult<RouteResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            routeResponse: result.data,
          ),
        );
      case ApiErrorResult<RouteResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
          ),
        );
    }
  }
}

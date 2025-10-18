import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/useCases/track_order_use_case.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_event.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_state.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_view_model.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_view_model_test.mocks.dart';

@GenerateMocks([TrackOrderUseCase])
void main() {
  late TrackOrderViewModel viewModel;
  late MockTrackOrderUseCase mockTrackOrderUseCase;

  setUp(() {
    mockTrackOrderUseCase = MockTrackOrderUseCase();
    viewModel = TrackOrderViewModel(mockTrackOrderUseCase);
  });

  group('TrackOrderViewModel', () {
    const String testPath = 'orders/test-order-123';

    test('initial state should be TrackOrderState with default values', () {
      // Assert
      expect(viewModel.state.isListening, equals(false));
      expect(viewModel.state.failure, isNull);
      expect(viewModel.state.entity, isNull);
    });

    group('doIntend', () {
      test('should handle StartListeningOrderEvent correctly', () async {
        // Arrange
        when(mockTrackOrderUseCase.listenData(testPath))
            .thenAnswer((_) => Stream.empty());

        // Act
        await viewModel.doIntend(StartListeningOrderEvent(testPath));

        // Assert
        verify(mockTrackOrderUseCase.listenData(testPath)).called(1);
      });

      test('should handle StopListeningOrderEvent correctly', () async {
        // Act
        await viewModel.doIntend(StopListeningOrderEvent());

        // Assert
        expect(viewModel.state.isListening, equals(false));
      });
    });

    group('close', () {
      test('should close cubit successfully', () async {
        // Act
        await viewModel.close();

        // Assert
        expect(viewModel.isClosed, isTrue);
      });
    });
  });
}

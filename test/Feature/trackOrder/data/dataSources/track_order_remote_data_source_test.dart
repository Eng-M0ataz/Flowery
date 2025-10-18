import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/dataSources/track_order_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/core/Services/real_time_database_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_remote_data_source_test.mocks.dart';

@GenerateMocks([RealTimeDataBaseService])
void main() {
  late TrackOrderRemoteDataSourceImpl dataSource;
  late MockRealTimeDataBaseService mockRealTimeDataBaseService;

  setUp(() {
    mockRealTimeDataBaseService = MockRealTimeDataBaseService();
    dataSource = TrackOrderRemoteDataSourceImpl(mockRealTimeDataBaseService);
  });

  group('TrackOrderRemoteDataSourceImpl', () {
    const String testPath = 'orders/test-order-123';

    group('listenData', () {
      test('should call real time database service with correct path', () {
        // Arrange
        when(mockRealTimeDataBaseService.listenData(testPath))
            .thenAnswer((_) => Stream.empty());

        // Act
        dataSource.listenData(testPath);

        // Assert
        verify(mockRealTimeDataBaseService.listenData(testPath)).called(1);
      });

      test('should handle different path formats correctly', () {
        // Arrange
        final testPaths = [
          'orders/123',
          'orders/user-456/order-789',
          'orders/2024/01/01/order-abc',
          'orders/pending/urgent/order-xyz',
        ];

        for (final path in testPaths) {
          when(mockRealTimeDataBaseService.listenData(path))
              .thenAnswer((_) => Stream.empty());

          // Act
          dataSource.listenData(path);

          // Assert
          verify(mockRealTimeDataBaseService.listenData(path)).called(1);
        }
      });

      test('should return stream from real time database service', () {
        // Arrange
        when(mockRealTimeDataBaseService.listenData(testPath))
            .thenAnswer((_) => Stream.empty());

        // Act
        final result = dataSource.listenData(testPath);

        // Assert
        expect(result, isA<Stream<Map<String, dynamic>>>());
        verify(mockRealTimeDataBaseService.listenData(testPath)).called(1);
      });
    });
  });
}

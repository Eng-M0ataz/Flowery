import 'package:flutter_test/flutter_test.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/dataSources/track_order_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/repositories/track_order_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'track_order_repo_impl_test.mocks.dart';

@GenerateMocks([TrackOrderRemoteDataSource])
void main() {
  late TrackOrderRepoImpl repository;
  late MockTrackOrderRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockTrackOrderRemoteDataSource();
    repository = TrackOrderRepoImpl(mockRemoteDataSource);
  });

  group('TrackOrderRepoImpl', () {
    const String testPath = 'orders/test-order-123';

    group('listenData', () {
      test('should call remote data source with correct path', () {
        // Arrange
        when(mockRemoteDataSource.listenData(testPath))
            .thenAnswer((_) => Stream.empty());

        // Act
        repository.listenData(testPath);

        // Assert
        verify(mockRemoteDataSource.listenData(testPath)).called(1);
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
          when(mockRemoteDataSource.listenData(path))
              .thenAnswer((_) => Stream.empty());

          // Act
          repository.listenData(path);

          // Assert
          verify(mockRemoteDataSource.listenData(path)).called(1);
        }
      });

      test('should return stream from remote data source', () {
        // Arrange
        when(mockRemoteDataSource.listenData(testPath))
            .thenAnswer((_) => Stream.empty());

        // Act
        final result = repository.listenData(testPath);

        // Assert
        expect(result, isA<Stream<OrderDetailsEntity>>());
        verify(mockRemoteDataSource.listenData(testPath)).called(1);
      });
    });
  });
}

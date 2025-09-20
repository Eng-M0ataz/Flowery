import 'package:flower_e_commerce_app/Feature/AddressFeature/data/dataSources/address_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/data/dataSources/address_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/data/repository/address_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'address_repo_impl_test.mocks.dart';

@GenerateMocks([AddressRemoteDataSource, AddressLocalDataSource])
void main() {
  late MockAddressRemoteDataSource mockRemoteDataSource;
  late MockAddressLocalDataSource mockLocalDataSource;
  late AddressRepoImpl repository;

  setUp(() {
    mockRemoteDataSource = MockAddressRemoteDataSource();
    mockLocalDataSource = MockAddressLocalDataSource();
    repository = AddressRepoImpl(
      addressRemoteDataSource: mockRemoteDataSource,
      addressLocalDataSource: mockLocalDataSource,
    );
  });

  group('AddressRepoImpl', () {
    group('getCities', () {
      final mockCities = [
        const CityEntity(
          id: 1,
          governorateId: 1,
          cityNameAr: 'القاهرة',
          cityNameEn: 'Cairo',
        ),
        const CityEntity(
          id: 2,
          governorateId: 1,
          cityNameAr: 'الجيزة',
          cityNameEn: 'Giza',
        ),
        const CityEntity(
          id: 3,
          governorateId: 2,
          cityNameAr: 'الإسكندرية',
          cityNameEn: 'Alexandria',
        ),
      ];

      test('should return list of cities from local data source', () async {
        // Arrange
        when(mockLocalDataSource.getCities())
            .thenAnswer((_) async => mockCities);

        // Act
        final result = await repository.getCities();

        // Assert
        expect(result, equals(mockCities));
        expect(result.length, equals(3));
        expect(result[0].cityNameEn, equals('Cairo'));
        verify(mockLocalDataSource.getCities()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyZeroInteractions(mockRemoteDataSource);
      });

      test('should handle empty cities list', () async {
        // Arrange
        when(mockLocalDataSource.getCities())
            .thenAnswer((_) async => <CityEntity>[]);

        // Act
        final result = await repository.getCities();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalDataSource.getCities()).called(1);
      });

      test('should throw exception when local data source fails', () async {
        // Arrange
        when(mockLocalDataSource.getCities())
            .thenThrow(Exception('Database error'));

        // Act & Assert
        expect(
          () => repository.getCities(),
          throwsA(isA<Exception>()),
        );
        verify(mockLocalDataSource.getCities()).called(1);
      });
    });

    group('getCitiesByGovernorateId', () {
      const governorateId = 1;
      final mockCitiesForGovernorate = [
        const CityEntity(
          id: 1,
          governorateId: governorateId,
          cityNameAr: 'القاهرة',
          cityNameEn: 'Cairo',
        ),
        const CityEntity(
          id: 2,
          governorateId: governorateId,
          cityNameAr: 'الجيزة',
          cityNameEn: 'Giza',
        ),
      ];

      test('should return cities for specific governorate ID', () async {
        // Arrange
        when(mockLocalDataSource.getCitiesByGovernorateId(governorateId))
            .thenAnswer((_) async => mockCitiesForGovernorate);

        // Act
        final result = await repository.getCitiesByGovernorateId(governorateId);

        // Assert
        expect(result, equals(mockCitiesForGovernorate));
        expect(result.length, equals(2));
        expect(result.every((city) => city.governorateId == governorateId),
            isTrue);
        verify(mockLocalDataSource.getCitiesByGovernorateId(governorateId))
            .called(1);
      });

      test('should return empty list when no cities found for governorate',
          () async {
        // Arrange
        when(mockLocalDataSource.getCitiesByGovernorateId(governorateId))
            .thenAnswer((_) async => <CityEntity>[]);

        // Act
        final result = await repository.getCitiesByGovernorateId(governorateId);

        // Assert
        expect(result, isEmpty);
        verify(mockLocalDataSource.getCitiesByGovernorateId(governorateId))
            .called(1);
      });
    });

    group('getGovernorates', () {
      final mockGovernorates = [
        const GovernorateEntity(
          id: 1,
          governorateNameAr: 'محافظة القاهرة',
          governorateNameEn: 'Cairo Governorate',
        ),
        const GovernorateEntity(
          id: 2,
          governorateNameAr: 'محافظة الإسكندرية',
          governorateNameEn: 'Alexandria Governorate',
        ),
        const GovernorateEntity(
          id: 3,
          governorateNameAr: 'محافظة الجيزة',
          governorateNameEn: 'Giza Governorate',
        ),
      ];

      test('should return list of governorates from local data source',
          () async {
        // Arrange
        when(mockLocalDataSource.getGovernorates())
            .thenAnswer((_) async => mockGovernorates);

        // Act
        final result = await repository.getGovernorates();

        // Assert
        expect(result, equals(mockGovernorates));
        expect(result.length, equals(3));
        expect(result[0].governorateNameEn, equals('Cairo Governorate'));
        verify(mockLocalDataSource.getGovernorates()).called(1);
        verifyNoMoreInteractions(mockLocalDataSource);
        verifyZeroInteractions(mockRemoteDataSource);
      });

      test('should handle empty governorates list', () async {
        // Arrange
        when(mockLocalDataSource.getGovernorates())
            .thenAnswer((_) async => <GovernorateEntity>[]);

        // Act
        final result = await repository.getGovernorates();

        // Assert
        expect(result, isEmpty);
        verify(mockLocalDataSource.getGovernorates()).called(1);
      });
    });

    group('Integration Tests', () {
      test('should handle multiple operations in sequence', () async {
        // Arrange
        final mockGovernorates = [
          const GovernorateEntity(
              id: 1, governorateNameAr: 'القاهرة', governorateNameEn: 'Cairo')
        ];
        final mockCities = [
          const CityEntity(
              id: 1,
              cityNameAr: 'مدينة نصر',
              cityNameEn: 'Nasr City',
              governorateId: 1)
        ];

        when(mockLocalDataSource.getGovernorates())
            .thenAnswer((_) async => mockGovernorates);
        when(mockLocalDataSource.getCitiesByGovernorateId(1))
            .thenAnswer((_) async => mockCities);

        // Act
        final governorates = await repository.getGovernorates();
        final cities = await repository.getCitiesByGovernorateId(1);

        // Assert
        expect(governorates, equals(mockGovernorates));
        expect(cities, equals(mockCities));
        verify(mockLocalDataSource.getGovernorates()).called(1);
        verify(mockLocalDataSource.getCitiesByGovernorateId(1)).called(1);
      });
    });

    group('Error Handling', () {
      test('should properly propagate exceptions from local data source',
          () async {
        // Arrange
        when(mockLocalDataSource.getCities())
            .thenThrow(Exception('Local database connection failed'));

        // Act & Assert
        expect(
          () => repository.getCities(),
          throwsA(predicate((e) =>
              e is Exception &&
              e.toString().contains('Local database connection failed'))),
        );
      });

      test('should handle null responses gracefully', () async {
        // Arrange
        when(mockLocalDataSource.getCities())
            .thenAnswer((_) async => <CityEntity>[]);

        // Act
        final result = await repository.getCities();

        // Assert
        expect(result, isNotNull);
        expect(result, isEmpty);
      });
    });
  });
}

import 'package:flower_e_commerce_app/Feature/occasion/data/dataSources/occasion_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/occasion/data/repositories/occasion_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/meta_data_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'occasion_repo_impl_test.mocks.dart';

@GenerateMocks([OccasionRemoteDataSource])
void main() {
  late OccasionRepoImpl repo;
  late MockOccasionRemoteDataSource mockRemoteDataSource;

  late OccasionResponseEntity mockOccasionEntity;
  late ProductByOccasionResponseEntity mockProductByOccasionEntity;

  setUp(() {
    mockRemoteDataSource = MockOccasionRemoteDataSource();
    repo = OccasionRepoImpl(mockRemoteDataSource);

    mockOccasionEntity = OccasionResponseEntity(
      message: "Success",
      occasions: [
        OccasionEntity(
            id: '2',
            name: 'birthday',
            slug: 'birthday',
            image: 'https://example.com/birthday.jpg'),
        OccasionEntity(
            id: '3',
            name: 'wedding',
            slug: 'wedding',
            image: 'https://example.com/wedding.jpg'),
      ],
      metadata: MetadataEntity(
        currentPage: 1,
        limit: 10,
        totalItems: 0,
        totalPages: 0,
      ),
    );

    mockProductByOccasionEntity = ProductByOccasionResponseEntity(
      message: "Success",
      products: [
        ProductEntity(
          title: 'test1',
          occasion: 'birthday',
          category: 'flower',
          description: 'A beautiful flower',
          rateAvg: 1,
          quantity: 1,
          imgCover: 'DDDH',
          images: ['DDDH', 'DDDH'],
          id: '12',
          price: 20,
          priceAfterDiscount: 30,
          rateCount: 5,
          slug: 'DD',
          sold: 5,
        ),
      ],
      metadata: MetadataEntity(
        currentPage: 2,
        limit: 12,
        totalItems: 1,
        totalPages: 1,
      ),
    );
    provideDummy<ApiResult<OccasionResponseEntity>>(
      ApiSuccessResult(
        data: OccasionResponseEntity(
          message: "success",
          metadata: MetadataEntity(
            currentPage: 1,
            limit: 10,
            totalItems: 0,
            totalPages: 0,
          ),
          occasions: [],
        ),
      ),
    );
    provideDummy<ApiResult<ProductByOccasionResponseEntity>>(
      ApiSuccessResult(
        data: ProductByOccasionResponseEntity(
          message: "success",
          metadata: MetadataEntity(
            currentPage: 1,
            limit: 10,
            totalItems: 0,
            totalPages: 0,
          ),
          products: [],
        ),
      ),
    );
  });

  group('OccasionRepoImpl tests', () {
    test('success case for getAllOccasions', () async {
      // arrange
      when(mockRemoteDataSource.getAllOccasions())
          .thenAnswer((_) async => ApiSuccessResult(data: mockOccasionEntity));

      // act
      final result = await repo.getAllOccasions();

      // assert
      expect(result, isA<ApiSuccessResult<OccasionResponseEntity>>());
    });

    test('failure case for getAllOccasions', () async {
      // arrange
      when(mockRemoteDataSource.getAllOccasions())
          .thenAnswer((_) async => ApiErrorResult(
                failure: Failure(errorMessage: "Server error"),
              ));

      // act
      final result = await repo.getAllOccasions();

      // assert
      expect(result, isA<ApiErrorResult<OccasionResponseEntity>>());
    });

    test('success case for getProductsByOccasion', () async {
      // arrange
      when(mockRemoteDataSource.getProductsByOccasion('1')).thenAnswer(
        (_) async => ApiSuccessResult(data: mockProductByOccasionEntity),
      );

      // act
      final result = await repo.getProductsByOccasion('1');

      // assert
      expect(result, isA<ApiSuccessResult<ProductByOccasionResponseEntity>>());
    });

    test('failure case for getProductsByOccasion', () async {
      // arrange
      when(mockRemoteDataSource.getProductsByOccasion('1')).thenAnswer(
        (_) async => ApiErrorResult(
          failure: Failure(errorMessage: "Server error"),
        ),
      );

      // act
      final result = await repo.getProductsByOccasion('1');

      // assert
      expect(result, isA<ApiErrorResult<ProductByOccasionResponseEntity>>());
    });
  });
}

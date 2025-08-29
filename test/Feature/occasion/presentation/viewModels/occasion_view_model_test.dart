import 'package:bloc_test/bloc_test.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/meta_data_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/occasion_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/useCases/get_all_occasion_use_case.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/useCases/get_products_by_occasion_use_case.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/viewModels/occasion_event.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/viewModels/occasion_state.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/viewModels/occasion_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

import 'occasion_view_model_test.mocks.dart';

@GenerateMocks([GetAllOccasionUseCase, GetProductsByOccasionUseCase])
void main() {
  late MockGetAllOccasionUseCase mockGetAllOccasionUseCase;
  late MockGetProductsByOccasionUseCase mockGetProductsByOccasionUseCase;

  const testOccasionId = 'birthday_123';
  final testOccasionEntity = OccasionResponseEntity(
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
  final testProductEntity = ProductByOccasionResponseEntity(
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
  final testFailure = ServerFailure(errorMessage: 'Server Error');

  setUpAll(() {
    mockGetAllOccasionUseCase = MockGetAllOccasionUseCase();
    mockGetProductsByOccasionUseCase = MockGetProductsByOccasionUseCase();
    provideDummy<ApiResult<OccasionResponseEntity>>(
        ApiSuccessResult(data: testOccasionEntity));

    provideDummy<ApiResult<ProductByOccasionResponseEntity>>(
        ApiSuccessResult(data: testProductEntity));
  });

  group('OccasionViewModel Tests', () {
    test('Initial state should be an empty OccasionState', () {
      expect(
          OccasionViewModel(
            mockGetAllOccasionUseCase,
            mockGetProductsByOccasionUseCase,
          ).state,
          OccasionState());
    });

    group('GetAllOccasionsEvent', () {
      blocTest<OccasionViewModel, OccasionState>(
        'Should emit two success states (occasions then products) when both use cases succeed',
        build: () {
          when(mockGetAllOccasionUseCase.invoke()).thenAnswer(
              (_) async => ApiSuccessResult(data: testOccasionEntity));
          when(mockGetProductsByOccasionUseCase.invoke(any)).thenAnswer(
              (_) async => ApiSuccessResult(data: testProductEntity));

          return OccasionViewModel(
            mockGetAllOccasionUseCase,
            mockGetProductsByOccasionUseCase,
          );
        },
        act: (cubit) =>
            cubit.doIntent(GetAllOccasionsEvent(occasionId: testOccasionId)),
        expect: () => <dynamic>[
          isA<OccasionState>().having((s) => s.occasionResponse,
              'occasionResponse', testOccasionEntity),
          isA<OccasionState>().having(
              (s) => s.productResponse, 'productResponse', testProductEntity),
        ],
        verify: (_) {
          verify(mockGetAllOccasionUseCase.invoke()).called(1);
          verify(mockGetProductsByOccasionUseCase.invoke(any)).called(1);
        },
      );

      blocTest<OccasionViewModel, OccasionState>(
        'Should emit an occasionFailure state when the get occasions use case fails',
        build: () {
          when(mockGetAllOccasionUseCase.invoke())
              .thenAnswer((_) async => ApiErrorResult(failure: testFailure));
          when(mockGetProductsByOccasionUseCase.invoke(any)).thenAnswer(
              (_) async => ApiSuccessResult(data: testProductEntity));

          return OccasionViewModel(
            mockGetAllOccasionUseCase,
            mockGetProductsByOccasionUseCase,
          );
        },
        act: (cubit) =>
            cubit.doIntent(GetAllOccasionsEvent(occasionId: testOccasionId)),
        expect: () => <dynamic>[
          isA<OccasionState>()
              .having((s) => s.occasionFailure, 'occasionFailure', testFailure),
          isA<OccasionState>().having(
              (s) => s.productResponse, 'productResponse', testProductEntity),
        ],
      );
    });

    group('LoadProductsByOccasionEvent', () {
      blocTest<OccasionViewModel, OccasionState>(
        'Should emit a productResponse success state when the get products use case succeeds',
        build: () {
          when(mockGetProductsByOccasionUseCase.invoke(any)).thenAnswer(
              (_) async => ApiSuccessResult(data: testProductEntity));
          return OccasionViewModel(
            mockGetAllOccasionUseCase,
            mockGetProductsByOccasionUseCase,
          );
        },
        act: (cubit) => cubit
            .doIntent(LoadProductsByOccasionEvent(occasionId: testOccasionId)),
        expect: () => <dynamic>[
          isA<OccasionState>().having(
              (s) => s.productResponse, 'productResponse', testProductEntity),
        ],
        verify: (_) {
          verify(mockGetProductsByOccasionUseCase.invoke(any))
              .called(greaterThanOrEqualTo(1));
          verify(mockGetAllOccasionUseCase.invoke()).called(1);
        },
      );

      blocTest<OccasionViewModel, OccasionState>(
        'Should emit a productFailure state when the get products use case fails',
        build: () {
          when(mockGetProductsByOccasionUseCase.invoke(any))
              .thenAnswer((_) async => ApiErrorResult(failure: testFailure));
          return OccasionViewModel(
            mockGetAllOccasionUseCase,
            mockGetProductsByOccasionUseCase,
          );
        },
        act: (cubit) => cubit
            .doIntent(LoadProductsByOccasionEvent(occasionId: testOccasionId)),
        expect: () => <dynamic>[
          isA<OccasionState>()
              .having((s) => s.productFailure, 'productFailure', testFailure),
        ],
      );
    });
  });
}

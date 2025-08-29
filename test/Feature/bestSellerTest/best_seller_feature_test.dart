import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/models/best_seller_dto.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/models/response/best_seller_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/data/dataSource/best_seller_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/dataSources/best_seller_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/data/repositories/best_seller_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/best_seller_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/entities/responseEntities/best_seller_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/repositories/best_seller_repo.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/domain/useCases/best_seller_use_case.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_model_view.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_event.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/viewModel/best_seller_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:bloc_test/bloc_test.dart';

// Generate mocks
@GenerateMocks([
  ApiServices,
  BestSellerRemoteDataSource,
  BestSellerRepo,
  BestSellerUseCase,
])
import 'best_seller_feature_test.mocks.dart';

void main() {
  group('BestSeller Feature Tests', () {

    // Test Data
    final testBestSellerDto = BestSellerDto(
      Id: '1',
      id: '1',
      title: 'Test Flower',
      description: 'Test Description',
      imgCover: 'https://test.com/image.jpg',
      price: 100,
      priceAfterDiscount: 80,
      rateAvg: 5,
      rateCount: 10,
      quantity: 50,
      category: 'flowers',
      sold: 5,
    );

    final testBestSellerResponseDto = BestSellerResponseDto(
      message: 'Success',
      bestSeller: [testBestSellerDto],
    );

    final testBestSellerEntity = BestSellerEntity(
      Id: '1',
      title: 'Test Flower',
      description: 'Test Description',
      imgCover: 'https://test.com/image.jpg',
      price: 100,
      priceAfterDiscount: 80,
    );

    final testBestSellerResponseEntity = BestSellerResponseEntity(
      message: 'Success',
      bestSeller: [testBestSellerEntity],
    );

    final testApiSuccessResult = ApiSuccessResult<BestSellerResponseEntity>(
      data: testBestSellerResponseEntity,
    );

    final testFailure = ServerFailure(errorMessage: 'Network error');
    final testApiErrorResult = ApiErrorResult<BestSellerResponseEntity>(
      failure: testFailure,
    );

    group('BestSellerEntity Tests', () {
      test('should calculate discount percentage correctly', () {
        // Arrange
        final entity = BestSellerEntity(
          Id: '1',
          title: 'Test Product',
          price: 100,
          priceAfterDiscount: 80,
        );

        // Act
        final discountPercent = entity.discountPercent;

        // Assert
        expect(discountPercent, equals(20));
      });

      test('should return 0 when price is null', () {
        // Arrange
        final entity = BestSellerEntity(
          Id: '1',
          title: 'Test Product',
          price: null,
          priceAfterDiscount: 80,
        );

        // Act
        final discountPercent = entity.discountPercent;

        // Assert
        expect(discountPercent, equals(0));
      });

      test('should return 0 when priceAfterDiscount is null', () {
        // Arrange
        final entity = BestSellerEntity(
          Id: '1',
          title: 'Test Product',
          price: 100,
          priceAfterDiscount: null,
        );

        // Act
        final discountPercent = entity.discountPercent;

        // Assert
        expect(discountPercent, equals(0));
      });

      test('should return 0 when price is 0', () {
        // Arrange
        final entity = BestSellerEntity(
          Id: '1',
          title: 'Test Product',
          price: 0,
          priceAfterDiscount: 80,
        );

        // Act
        final discountPercent = entity.discountPercent;

        // Assert
        expect(discountPercent, equals(0));
      });
    });

    group('BestSellerRemoteDataSourceImpl Tests', () {
      late MockApiServices mockApiServices;
      late BestSellerRemoteDataSourceImpl dataSource;

      setUp(() {
        mockApiServices = MockApiServices();
        dataSource = BestSellerRemoteDataSourceImpl(apiServices: mockApiServices);
      });

      test('should return ApiSuccessResult when API call is successful', () async {
        // Arrange
        when(mockApiServices.getBestSeller())
            .thenAnswer((_) async => testBestSellerResponseDto);

        // Act
        final result = await dataSource.getAllBestSeller();

        // Assert
        expect(result, isA<ApiSuccessResult<BestSellerResponseEntity>>());
        final successResult = result as ApiSuccessResult<BestSellerResponseEntity>;
        expect(successResult.data.message, equals('Success'));
        expect(successResult.data.bestSeller?.length, equals(1));
        expect(successResult.data.bestSeller?.first.title, equals('Test Flower'));

        verify(mockApiServices.getBestSeller()).called(1);
      });

      test('should return ApiErrorResult when DioException occurs', () async {
        // Arrange
        final dioError = DioException(
          requestOptions: RequestOptions(path: '/best-seller'),
          message: 'Network error',
          type: DioExceptionType.connectionTimeout,
        );

        when(mockApiServices.getBestSeller()).thenThrow(dioError);

        // Act
        final result = await dataSource.getAllBestSeller();

        // Assert
        expect(result, isA<ApiErrorResult<BestSellerResponseEntity>>());
        final errorResult = result as ApiErrorResult<BestSellerResponseEntity>;
        expect(errorResult.failure.errorMessage, contains('Network error'));

        verify(mockApiServices.getBestSeller()).called(1);
      });

      test('should return ApiErrorResult when generic exception occurs', () async {
        // Arrange
        when(mockApiServices.getBestSeller())
            .thenThrow(Exception('Something went wrong'));

        // Act
        final result = await dataSource.getAllBestSeller();

        // Assert
        expect(result, isA<ApiErrorResult<BestSellerResponseEntity>>());
        final errorResult = result as ApiErrorResult<BestSellerResponseEntity>;
        expect(errorResult.failure.errorMessage, contains('Something went wrong'));

        verify(mockApiServices.getBestSeller()).called(1);
      });
    });

    group('BestSellerRepoImpl Tests', () {
      late MockBestSellerRemoteDataSource mockDataSource;
      late BestSellerRepoImpl repository;

      setUp(() {
        mockDataSource = MockBestSellerRemoteDataSource();
        repository = BestSellerRepoImpl(dataSource: mockDataSource);
      });

      test('should return ApiSuccessResult when data source call is successful', () async {
        // Arrange
        when(mockDataSource.getAllBestSeller())
            .thenAnswer((_) async => testApiSuccessResult);

        // Act
        final result = await repository.getBestSellers();

        // Assert
        expect(result, isA<ApiSuccessResult<BestSellerResponseEntity>>());
        final successResult = result as ApiSuccessResult<BestSellerResponseEntity>;
        expect(successResult.data.message, equals('Success'));

        verify(mockDataSource.getAllBestSeller()).called(1);
      });

      test('should return ApiErrorResult when data source call fails', () async {
        // Arrange
        when(mockDataSource.getAllBestSeller())
            .thenAnswer((_) async => testApiErrorResult);

        // Act
        final result = await repository.getBestSellers();

        // Assert
        expect(result, isA<ApiErrorResult<BestSellerResponseEntity>>());
        final errorResult = result as ApiErrorResult<BestSellerResponseEntity>;
        expect(errorResult.failure.errorMessage, equals('Network error'));

        verify(mockDataSource.getAllBestSeller()).called(1);
      });
    });

    group('BestSellerUseCase Tests', () {
      late MockBestSellerRepo mockRepo;
      late BestSellerUseCase useCase;

      setUp(() {
        mockRepo = MockBestSellerRepo();
        useCase = BestSellerUseCase(repo: mockRepo);
      });

      test('should return ApiSuccessResult when repository call is successful', () async {
        // Arrange
        when(mockRepo.getBestSellers())
            .thenAnswer((_) async => testApiSuccessResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiSuccessResult<BestSellerResponseEntity>>());
        final successResult = result as ApiSuccessResult<BestSellerResponseEntity>;
        expect(successResult.data.message, equals('Success'));

        verify(mockRepo.getBestSellers()).called(1);
      });

      test('should return ApiErrorResult when repository call fails', () async {
        // Arrange
        when(mockRepo.getBestSellers())
            .thenAnswer((_) async => testApiErrorResult);

        // Act
        final result = await useCase.invoke();

        // Assert
        expect(result, isA<ApiErrorResult<BestSellerResponseEntity>>());
        final errorResult = result as ApiErrorResult<BestSellerResponseEntity>;
        expect(errorResult.failure.errorMessage, equals('Network error'));

        verify(mockRepo.getBestSellers()).called(1);
      });
    });

    group('BestSellerViewModel Tests', () {
      late MockBestSellerUseCase mockUseCase;
      late BestSellerViewModel viewModel;

      setUp(() {
        mockUseCase = MockBestSellerUseCase();
        viewModel = BestSellerViewModel(mockUseCase);
      });

      test('initial state should be correct', () {
        // Assert
        expect(viewModel.state.isLoading, equals(false));
        expect(viewModel.state.isSuccess, equals(false));
        expect(viewModel.state.errorMessage, isNull);
        expect(viewModel.state.bestSellers, isNull);
      });

      blocTest<BestSellerViewModel, BestSellerState>(
        'should emit loading then success state when GetAllBestSellersEvent is successful',
        build: () {
          when(mockUseCase.invoke())
              .thenAnswer((_) async => testApiSuccessResult);
          return viewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllBestSellersEvent()),
        expect: () => [
          BestSellerState(isLoading: true, isSuccess: false, errorMessage: null),
          BestSellerState(
            isLoading: false,
            isSuccess: true,
            errorMessage: null,
            bestSellers: testBestSellerResponseEntity,
          ),
        ],
        verify: (cubit) {
          verify(mockUseCase.invoke()).called(1);
        },
      );

      blocTest<BestSellerViewModel, BestSellerState>(
        'should emit loading then error state when GetAllBestSellersEvent fails',
        build: () {
          when(mockUseCase.invoke())
              .thenAnswer((_) async => testApiErrorResult);
          return viewModel;
        },
        act: (cubit) => cubit.doIntent(GetAllBestSellersEvent()),
        expect: () => [
          BestSellerState(isLoading: true, isSuccess: false, errorMessage: null),
          BestSellerState(
            isLoading: false,
            isSuccess: false,
            errorMessage: 'Network error',
            bestSellers: null,
          ),
        ],
        verify: (cubit) {
          verify(mockUseCase.invoke()).called(1);
        },
      );
    });

    group('BestSellerDto Mapper Tests', () {
      test('should map BestSellerDto to BestSellerEntity correctly', () {
        // Arrange
        final dto = BestSellerDto(
          Id: '123',
          title: 'Rose Bouquet',
          description: 'Beautiful roses',
          imgCover: 'https://example.com/rose.jpg',
          price: 150,
          priceAfterDiscount: 120,
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.Id, equals('123'));
        expect(entity.title, equals('Rose Bouquet'));
        expect(entity.description, equals('Beautiful roses'));
        expect(entity.imgCover, equals('https://example.com/rose.jpg'));
        expect(entity.price, equals(150));
        expect(entity.priceAfterDiscount, equals(120));
      });

      test('should handle null values in DTO mapping', () {
        // Arrange
        final dto = BestSellerDto();

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.Id, isNull);
        expect(entity.title, isNull);
        expect(entity.description, isNull);
        expect(entity.imgCover, isNull);
        expect(entity.price, isNull);
        expect(entity.priceAfterDiscount, isNull);
      });
    });

    group('BestSellerState Tests', () {
      test('copyWith should update specific fields', () {
        // Arrange
        final initialState = BestSellerState(
          isLoading: false,
          isSuccess: false,
          errorMessage: null,
          bestSellers: null,
        );

        // Act
        final newState = initialState.copyWith(
          isLoading: true,
          errorMessage: 'Error occurred',
        );

        // Assert
        expect(newState.isLoading, equals(true));
        expect(newState.isSuccess, equals(false)); // Should remain unchanged
        expect(newState.errorMessage, equals('Error occurred'));
        expect(newState.bestSellers, isNull); // Should remain unchanged
      });

      test('copyWith should not change fields when null is passed', () {
        // Arrange
        final initialState = BestSellerState(
          isLoading: true,
          isSuccess: true,
          errorMessage: 'Previous error',
          bestSellers: testBestSellerResponseEntity,
        );

        // Act
        final newState = initialState.copyWith();

        // Assert
        expect(newState.isLoading, equals(true));
        expect(newState.isSuccess, equals(true));
        expect(newState.errorMessage, equals('Previous error'));
        expect(newState.bestSellers, equals(testBestSellerResponseEntity));
      });
    });
  });
}
import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/mapper/best_seller_response_dto_mapper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/mapper/best_seller_dto_mapper.dart';
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
  // Provide dummy values for Mockito
  setUpAll(() {
    // Dummy BestSellerResponseEntity
    final dummyBestSellerResponseEntity = BestSellerResponseEntity(
      message: 'dummy',
      bestSeller: [],
    );

    // Provide dummy values for ApiResult types
    provideDummy<ApiResult<BestSellerResponseEntity>>(
        ApiSuccessResult<BestSellerResponseEntity>(data: dummyBestSellerResponseEntity)
    );
  });
  group('BestSeller Feature Tests', () {

    // Test Data
    final testBestSellerDto = BestSellerDto(
      Id: '1',
      id: '1',
      title: 'Test Flower',
      slug: 'test-flower',
      description: 'Test Description',
      imgCover: 'https://test.com/image.jpg',
      images: ['https://test.com/image1.jpg'],
      price: 100,
      priceAfterDiscount: 80,
      discount: 20,
      rateAvg: 5,
      rateCount: 10,
      quantity: 50,
      category: 'flowers',
      occasion: 'birthday',
      isSuperAdmin: false,
      createdAt: '2023-01-01',
      updatedAt: '2023-01-01',
      V: 0,
      sold: 5,
    );

    final testBestSellerResponseDto = BestSellerResponseDto(
      message: 'Success',
      bestSeller: [testBestSellerDto],
    );

    final testBestSellerEntity = BestSellerEntity(
      id: '1',
      title: 'Test Flower',
      slug: 'test-flower',
      description: 'Test Description',
      imgCover: 'https://test.com/image.jpg',
      images: ['https://test.com/image1.jpg'],
      price: 100,
      priceAfterDiscount: 80,
      discount: 20,
      rateAvg: 5,
      rateCount: 10,
      quantity: 50,
      category: 'flowers',
      occasion: 'birthday',
      isSuperAdmin: false,
      createdAt: '2023-01-01',
      updatedAt: '2023-01-01',
      V: 0,
      sold: 5,
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
      test('should handle entity creation with all fields', () {
        // Arrange & Act
        final entity = BestSellerEntity(
          id: '1',
          title: 'Test Product',
          slug: 'test-product',
          description: 'A test product',
          imgCover: 'https://example.com/image.jpg',
          images: ['https://example.com/image1.jpg'],
          price: 100,
          priceAfterDiscount: 80,
          discount: 20,
          rateAvg: 5,
          rateCount: 10,
          quantity: 50,
          category: 'flowers',
          occasion: 'birthday',
          isSuperAdmin: false,
          createdAt: '2023-01-01',
          updatedAt: '2023-01-01',
          V: 0,
          sold: 5,
        );

        // Assert
        expect(entity.id, equals('1'));
        expect(entity.title, equals('Test Product'));
        expect(entity.price, equals(100));
        expect(entity.priceAfterDiscount, equals(80));
        expect(entity.discount, equals(20));
      });

      test('should handle entity creation with null values', () {
        // Arrange & Act
        final entity = BestSellerEntity();

        // Assert
        expect(entity.id, isNull);
        expect(entity.title, isNull);
        expect(entity.price, isNull);
        expect(entity.priceAfterDiscount, isNull);
        expect(entity.discount, isNull);
      });

      test('should allow modification of priceAfterDiscount', () {
        // Arrange
        final entity = BestSellerEntity(
          id: '1',
          title: 'Test Product',
          price: 100,
          priceAfterDiscount: 80,
        );

        // Act
        entity.priceAfterDiscount = 70;

        // Assert
        expect(entity.priceAfterDiscount, equals(70));
      });
    });

    group('BestSellerRemoteDataSourceImpl Tests', () {
      late MockApiServices mockApiServices;
      late BestSellerRemoteDataSourceImpl dataSource;

      setUp(() {
        mockApiServices = MockApiServices();
        dataSource = BestSellerRemoteDataSourceImpl(mockApiServices);
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
        expect(errorResult.failure, isA<ServerFailure>());

        verify(mockApiServices.getBestSeller()).called(1);
      });

      test('should return ApiErrorResult with ServerFailure when generic exception occurs', () async {
        // Arrange
        when(mockApiServices.getBestSeller())
            .thenThrow(Exception('Something went wrong'));

        // Act
        final result = await dataSource.getAllBestSeller();

        // Assert
        expect(result, isA<ApiErrorResult<BestSellerResponseEntity>>());
        final errorResult = result as ApiErrorResult<BestSellerResponseEntity>;
        expect(errorResult.failure, isA<ServerFailure>());
        expect(errorResult.failure.errorMessage, contains('Something went wrong'));

        verify(mockApiServices.getBestSeller()).called(1);
      });

      test('should handle empty best seller list response', () async {
        // Arrange
        final emptyResponseDto = BestSellerResponseDto(
          message: 'No items found',
          bestSeller: [],
        );

        when(mockApiServices.getBestSeller())
            .thenAnswer((_) async => emptyResponseDto);

        // Act
        final result = await dataSource.getAllBestSeller();

        // Assert
        expect(result, isA<ApiSuccessResult<BestSellerResponseEntity>>());
        final successResult = result as ApiSuccessResult<BestSellerResponseEntity>;
        expect(successResult.data.message, equals('No items found'));
        expect(successResult.data.bestSeller?.length, equals(0));

        verify(mockApiServices.getBestSeller()).called(1);
      });
    });

    group('BestSellerRepoImpl Tests', () {
      late MockBestSellerRemoteDataSource mockDataSource;
      late BestSellerRepoImpl repository;

      setUp(() {
        mockDataSource = MockBestSellerRemoteDataSource();
        repository = BestSellerRepoImpl(mockDataSource);
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
        useCase = BestSellerUseCase(mockRepo);
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
          predicate<BestSellerState>((state) =>
          state.isLoading == true &&
              state.isSuccess == false &&
              state.errorMessage == null &&
              state.bestSellers == null),
          predicate<BestSellerState>((state) =>
          state.isLoading == false &&
              state.isSuccess == true &&
              state.errorMessage == null &&
              state.bestSellers == testBestSellerResponseEntity
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
          predicate<BestSellerState>((state) =>
          state.isLoading == true &&
              state.isSuccess == false &&
              state.errorMessage == null &&
              state.bestSellers == null),
          predicate<BestSellerState>((state) =>
          state.isLoading == false &&
              state.isSuccess == false &&
              state.errorMessage == 'Network error' &&
              state.bestSellers == null),
        ],
        verify: (cubit) {
          verify(mockUseCase.invoke()).called(1);
        },
      );
    });

    group('BestSellerDto Mapper Tests', () {
      test('should map BestSellerDto to BestSellerEntity correctly with all fields', () {
        // Arrange
        final dto = BestSellerDto(
          Id: '123',
          id: '123',
          title: 'Rose Bouquet',
          slug: 'rose-bouquet',
          description: 'Beautiful roses',
          imgCover: 'https://example.com/rose.jpg',
          images: ['https://example.com/rose1.jpg', 'https://example.com/rose2.jpg'],
          price: 150,
          priceAfterDiscount: 120,
          discount: 30,
          rateAvg: 4,
          rateCount: 25,
          quantity: 100,
          category: 'flowers',
          occasion: 'wedding',
          isSuperAdmin: true,
          createdAt: '2023-01-01',
          updatedAt: '2023-01-02',
          V: 1,
          sold: 10,
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.id, equals('123'));
        expect(entity.title, equals('Rose Bouquet'));
        expect(entity.slug, equals('rose-bouquet'));
        expect(entity.description, equals('Beautiful roses'));
        expect(entity.imgCover, equals('https://example.com/rose.jpg'));
        expect(entity.images, equals(['https://example.com/rose1.jpg', 'https://example.com/rose2.jpg']));
        expect(entity.price, equals(150));
        expect(entity.priceAfterDiscount, equals(120));
        expect(entity.discount, equals(30));
        expect(entity.rateAvg, equals(4));
        expect(entity.rateCount, equals(25));
        expect(entity.quantity, equals(100));
        expect(entity.category, equals('flowers'));
        expect(entity.occasion, equals('wedding'));
        expect(entity.isSuperAdmin, equals(true));
        expect(entity.createdAt, equals('2023-01-01'));
        expect(entity.updatedAt, equals('2023-01-02'));
        expect(entity.V, equals(1));
        expect(entity.sold, equals(10));
      });

      test('should handle null values in DTO mapping with proper defaults', () {
        // Arrange
        final dto = BestSellerDto();

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.id, equals(""));
        expect(entity.title, equals(""));
        expect(entity.slug, equals(""));
        expect(entity.description, equals(""));
        expect(entity.imgCover, equals(""));
        expect(entity.images, equals([]));
        expect(entity.price, equals(0));
        expect(entity.priceAfterDiscount, equals(0));
        expect(entity.discount, equals(0));
        expect(entity.rateAvg, equals(0));
        expect(entity.rateCount, equals(0));
        expect(entity.quantity, equals(0));
        expect(entity.category, equals("general"));
        expect(entity.occasion, equals(""));
        expect(entity.isSuperAdmin, equals(false));
        expect(entity.createdAt, equals(""));
        expect(entity.updatedAt, equals(""));
        expect(entity.V, equals(0));
        expect(entity.sold, equals(0));
      });

      test('should handle partial null values in DTO mapping', () {
        // Arrange
        final dto = BestSellerDto(
          Id: '456',
          title: 'Tulip Bundle',
          price: 200,
          // Other fields are null
        );

        // Act
        final entity = dto.toEntity();

        // Assert
        expect(entity.id, equals('456'));
        expect(entity.title, equals('Tulip Bundle'));
        expect(entity.price, equals(200));
        expect(entity.description, equals(""));
        expect(entity.category, equals("general"));
        expect(entity.priceAfterDiscount, equals(0));
      });
    });

    group('BestSellerResponseEntity Tests', () {
      test('should create BestSellerResponseEntity with provided values', () {
        // Arrange & Act
        final entity = BestSellerResponseEntity(
          message: 'Test message',
          bestSeller: [testBestSellerEntity],
        );

        // Assert
        expect(entity.message, equals('Test message'));
        expect(entity.bestSeller?.length, equals(1));
        expect(entity.bestSeller?.first, equals(testBestSellerEntity));
      });

      test('should create BestSellerResponseEntity with null values', () {
        // Arrange & Act
        final entity = BestSellerResponseEntity();

        // Assert
        expect(entity.message, isNull);
        expect(entity.bestSeller, isNull);
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

      test('should create initial state with correct defaults', () {
        // Arrange & Act
        final state = BestSellerState();

        // Assert
        expect(state.isLoading, isFalse);
        expect(state.isSuccess, isFalse);
        expect(state.errorMessage, isNull);
        expect(state.bestSellers, isNull);
      });
    });

    group('Integration Tests', () {
      test('should complete full data flow from DTO to Entity', () {
        // Arrange
        final dto = BestSellerDto(
          Id: 'integration-test-1',
          title: 'Integration Test Flower',
          price: 500,
          priceAfterDiscount: 400,
        );

        final responseDto = BestSellerResponseDto(
          message: 'Integration test success',
          bestSeller: [dto],
        );

        // Act
        final responseEntity = responseDto.toEntity();
        final firstProduct = responseEntity.bestSeller?.first;

        // Assert
        expect(responseEntity.message, equals('Integration test success'));
        expect(responseEntity.bestSeller?.length, equals(1));
        expect(firstProduct?.id, equals('integration-test-1'));
        expect(firstProduct?.title, equals('Integration Test Flower'));
        expect(firstProduct?.price, equals(500));
        expect(firstProduct?.priceAfterDiscount, equals(400));
      });
    });
  });
}
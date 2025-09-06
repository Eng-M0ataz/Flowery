import 'package:flower_e_commerce_app/Feature/occasion/api/client/occasion_api_service.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/dataSources/occasion_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/occasion_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/product_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/response/occasion_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/response/product_by_occasion_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/occasion_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/response/product_by_occasion_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'occasion_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([OccasionApiService])
void main() {
  late OccasionRemoteDataSourceImpl dataSource;
  late MockOccasionApiService mockApiService;
  late OccasionResponseDto mockOccasionResponse;
  late ProductByOccasionResponseDto mockProductByOccasionResponse;

  setUp(() {
    mockApiService = MockOccasionApiService();
    dataSource = OccasionRemoteDataSourceImpl(mockApiService);
    mockOccasionResponse = OccasionResponseDto(
      message: 'Success',
      occasions: [
        OccasionDto(
          id: '1',
          name: 'Birthday',
          slug: 'birthday',
          image: 'https://example.com/birthday.jpg',
          createdAt: '2023-01-01T00:00:00Z',
          updatedAt: '2023-01-01T00:00:00Z',
          isSuperAdmin: false,
          productsCount: 10,
        ),
        OccasionDto(
          id: '2',
          name: 'Wedding',
          slug: 'wedding',
          image: 'https://example.com/wedding.jpg',
          createdAt: '2023-02-01T00:00:00Z',
          updatedAt: '2023-02-01T00:00:00Z',
          isSuperAdmin: false,
          productsCount: 15,
        ),
      ],
      metadata: MetadataDto(
        currentPage: 1,
        limit: 2,
        totalItems: 3,
        totalPages: 4,
      ),
    );
    mockProductByOccasionResponse = ProductByOccasionResponseDto(
      message: 'Success',
      products: [
        ProductDto(
          title: 'test1',
          occasion: 'birthday',
          category: 'flower',
          description: 'A beautiful flower',
        ),
        ProductDto(
          title: 'test2',
          occasion: 'birthday',
          category: 'gift',
          description: 'A lovely gift',
        )
      ],
      metadata: MetadataDto(
        currentPage: 1,
        limit: 10,
        totalItems: 0,
        totalPages: 0,
      ),
    );
  });
  group('test OccasionRemoteDataSourceImpl', () {
    test('success case for get occasions with list of occasionDto', () async {
      //arrange

      when(mockApiService.getAllOccasions())
          .thenAnswer((_) async => mockOccasionResponse);
      //act
      final result = await dataSource.getAllOccasions();

      //assert
      expect(result, isA<ApiSuccessResult<OccasionResponseEntity>>());
    });

    test('failure case for get occasions throws exception', () async {
      // arrange
      when(mockApiService.getAllOccasions())
          .thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.getAllOccasions();

      // assert
      expect(result, isA<ApiErrorResult>());
    });

    test('success case returns list of products', () {
      //arrange
      when(mockApiService.getProductsByOccasion('1'))
          .thenAnswer((_) async => mockProductByOccasionResponse);
      //act
      final result = dataSource.getProductsByOccasion('1');
      //assert
      expect(result, isA<Future<ApiResult<ProductByOccasionResponseEntity>>>());
    });

    test('failure case for get products by occasion throws exception',
        () async {
      // arrange
      when(mockApiService.getProductsByOccasion('1'))
          .thenThrow(Exception('Server error'));

      // act
      final result = await dataSource.getProductsByOccasion('1');

      // assert
      expect(result, isA<ApiErrorResult>());
    });
  });
}

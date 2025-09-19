import 'package:flower_e_commerce_app/Feature/searchFeature/api/client/search_api_service.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/dataSources/search_remote_data_source_impl.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_dto.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/data/dataSource/search_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'search_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([SearchApiService])
void main() {
  late SearchRemoteDataSource dataSource;
  late MockSearchApiService api;

  setUp(() {
    api = MockSearchApiService();
    dataSource = SearchRemoteDataSourceImpl(api);
  });

  test('searchProducts returns success mapped entity with products', () async {
    final dummyProduct = SearchDto(
      id: 'p1',
      title: 'Rose',
      price: 100,
      priceAfterDiscount: 90,
      images: const ['https://example.com/img.png'],
      imgCover: 'https://example.com/cover.png',
      quantity: 5,
      sold: 1,
      category: 'c1',
      occasion: 'o1',
    );

    when(api.searchProducts(any)).thenAnswer((invocation) async {
      final arg = invocation.positionalArguments.first as String;
      expect(arg, 'rose');
      return SearchResponseDto(
        message: 'success',
        products: [dummyProduct],
      );
    });

    final result = await dataSource.searchProducts('rose');

    expect(result, isA<ApiSuccessResult<SearchResponseEntity>>());

    final data = (result as ApiSuccessResult<SearchResponseEntity>).data;
    final products = data.products;

    expect(products, isNotEmpty);
    expect(products.first.id, 'p1');
  });
}

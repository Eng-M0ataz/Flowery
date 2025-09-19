import 'package:flower_e_commerce_app/Feature/searchFeature/data/dataSource/search_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/data/repositories/search_repo_impl.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeRemote implements SearchRemoteDataSource {
  ApiResult<SearchResponseEntity>? next;

  @override
  Future<ApiResult<SearchResponseEntity>> searchProducts(String keyword) async {
    return next ??
        ApiSuccessResult<SearchResponseEntity>(
          data: SearchResponseEntity(products: const []),
        );
  }
}

void main() {
  late _FakeRemote remote;
  late SearchRepoImpl repo;

  setUp(() {
    remote = _FakeRemote();
    repo = SearchRepoImpl(remote);
  });

  test('repo returns response entity when remote success', () async {
    remote.next = ApiSuccessResult<SearchResponseEntity>(
      data: SearchResponseEntity(products: const []),
    );

    final result = await repo.searchProducts('rose');
    expect(result, isA<ApiSuccessResult<SearchResponseEntity>>());
    final data = (result as ApiSuccessResult<SearchResponseEntity>).data;
    expect(data.products, isNotNull);
    expect(data.products, isA<List>());
  });
}

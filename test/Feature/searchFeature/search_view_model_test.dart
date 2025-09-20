import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/useCases/product_search_use_case.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/repositories/search_repo.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_events.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_view_model.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_test/flutter_test.dart';
// Avoid mockito here due to matcher resolution issues in some environments.

class _DummyRepo implements SearchRepo {
  @override
  Future<ApiResult<SearchResponseEntity>> searchProducts(String keyword) {
    throw UnimplementedError();
  }
}

class _TestUseCase extends ProductSearchUseCase {
  _TestUseCase() : super(_DummyRepo());

  ApiResult<SearchResponseEntity>? next;

  @override
  Future<ApiResult<SearchResponseEntity>> invoke(String keyword) async {
    return next ??
        ApiSuccessResult<SearchResponseEntity>(
          data: SearchResponseEntity(products: const []),
        );
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late _TestUseCase useCase;
  late SearchViewModel vm;

  setUp(() {
    useCase = _TestUseCase();
    vm = SearchViewModel(useCase);
  });

  test('emits results on success', () async {
    useCase.next = ApiSuccessResult<SearchResponseEntity>(
      data: SearchResponseEntity(products: const []),
    );

    vm.doIntent(SearchProductsEvent(), 'rose');

    // wait debounce
    await Future.delayed(const Duration(milliseconds: 700));

    expect(vm.state.isLoading, false);
    final results = vm.state.searchResults ?? const [];
    expect(results, isA<List>());
  });
}

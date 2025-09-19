import 'dart:async';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/useCases/product_search_use_case.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_events.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/viewModel/search_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SearchViewModel extends Cubit<SearchState> {
  final ProductSearchUseCase _searchUseCase;

  SearchViewModel(this._searchUseCase) : super(const SearchState());
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  void doIntent(SearchEvents events, String keyWord) {
    switch (events) {
      case SearchProductsEvent():
        _onSearchChanged(keyWord);
    }
  }

  Future<void> _searchProducts(String keyword) async {
    final result = await _searchUseCase.invoke(keyword);
    switch (result) {
      case ApiSuccessResult<SearchResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            searchResults: result.data.products,
          ),
        );
      case ApiErrorResult<SearchResponseEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
          ),
        );
    }
  }

  void _onSearchChanged(String keyword) {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(
      const Duration(milliseconds: 600),
      () {
        _searchProducts(keyword);
      },
    );
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}

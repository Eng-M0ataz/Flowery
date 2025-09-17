import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_peoduct_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class SearchState {
  final bool isLoading;
  final List<SearchProductEntity>? searchResults;
  final Failure? failure;

  const SearchState({
    this.isLoading = false,
    this.searchResults,
    this.failure,
  });

  SearchState copyWith({
    bool? isLoading,
    List<SearchProductEntity>? searchResults,
    Failure? failure,
  }) {
    return SearchState(
      isLoading: isLoading ?? this.isLoading,
      searchResults: searchResults ?? this.searchResults,
      failure: failure ?? this.failure,
    );
  }
}

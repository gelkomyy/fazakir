part of 'search_cubit.dart';

class SearchResult {
  final dynamic exactMatches;
  final dynamic relatedMatches;

  SearchResult({required this.exactMatches, required this.relatedMatches});
}

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final SearchResult searchResult;
  SearchLoaded(this.searchResult);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}

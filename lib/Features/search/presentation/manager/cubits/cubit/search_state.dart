part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final dynamic searchResults;
  SearchLoaded(this.searchResults);
}

class SearchError extends SearchState {
  final String error;
  SearchError(this.error);
}

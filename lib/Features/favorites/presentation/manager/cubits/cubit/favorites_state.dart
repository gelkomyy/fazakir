part of 'favorites_cubit.dart';

@immutable
sealed class FavoritesState {}

final class FavoritesInitial extends FavoritesState {}

final class FavoritesLoading extends FavoritesState {}

final class FavoritesFailure extends FavoritesState {
  final String message;
  FavoritesFailure({required this.message});
}

final class FavoritesSuccess extends FavoritesState {
  final List<FavoriteEntity> favorites;
  FavoritesSuccess({required this.favorites});
}

final class ToggleFavorite extends FavoritesState {}

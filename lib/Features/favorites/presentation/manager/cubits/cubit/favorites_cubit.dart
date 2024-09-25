import 'package:fazakir/Features/favorites/data/repos/favorite_repository.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';
import 'package:flutter/material.dart';
part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesInitial());

  final FavoriteRepository _favoriteRepository = getIt<FavoriteRepository>();
  List<FavoriteEntity> favorites = [];

  Future<void> toggleFavorite(FavoriteEntity entity) async {
    emit(FavoritesLoading());
    await _favoriteRepository
        .toggleFavorite(entity)
        .onError((error, stackTrace) {
      emit(FavoritesFailure(message: 'Failed to toggle favorite'));
      return;
    });

    emit(ToggleFavorite());
    getFavorites();
  }

  void getFavorites() {
    emit(FavoritesLoading());
    final List<FavoriteEntity> result = _favoriteRepository.getFavorites();
    favorites = result;
    emit(FavoritesSuccess(favorites: result));
  }
}

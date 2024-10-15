import 'dart:convert';

import 'package:fazakir/Features/about_religion/data/models/video_youtube_model.dart';
import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/azkar/data/models/azkar_item_model.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoriteRepository {
  static const String _favoritesKey = 'favorites';

  // Toggle favorite by storing JSON string of entity
  Future<void> toggleFavorite(FavoriteEntity entity) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    List<String> favoriteItems = prefs.getStringList(_favoritesKey) ?? [];

    String entityJson = jsonEncode(entity.toJson());

    if (favoriteItems.contains(entityJson)) {
      favoriteItems.remove(entityJson);
    } else {
      favoriteItems.add(entityJson);
    }

    await prefs.setStringList(_favoritesKey, favoriteItems);
  }

  // Retrieve all favorite entities
  List<FavoriteEntity> getFavorites() {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    List<String> favoriteItems = prefs.getStringList(_favoritesKey) ?? [];

    List<FavoriteEntity> favorites = [];

    for (String jsonString in favoriteItems) {
      Map<String, dynamic> json = jsonDecode(jsonString);

      // Use the identifier or some key to determine the type of entity
      if (json.containsKey('count')) {
        favorites.add(AzkarItemModel.fromJson(json));
      } else if (json.containsKey('url')) {
        favorites.add(VideoYoutubeModel.fromJson(json));
      } else if (json.containsKey('hadith')) {
        favorites.add(HadithEntity.fromJson(json));
      }
    }

    return favorites;
  }

  // Retrieve specific type of favorite entities
  List<T> getSpecificFavorites<T extends FavoriteEntity>() {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    List<String> favoriteItems = prefs.getStringList(_favoritesKey) ?? [];

    List<T> specificFavorites = [];

    for (String jsonString in favoriteItems) {
      Map<String, dynamic> json = jsonDecode(jsonString);

      if (T == AzkarItemEntity && json.containsKey('zikr')) {
        specificFavorites.add(AzkarItemModel.fromJson(json) as T);
      } else if (T == VideoYoutubeEntity && json.containsKey('video')) {
        specificFavorites.add(VideoYoutubeModel.fromJson(json) as T);
      } else if (T == HadithEntity && json.containsKey('hadith')) {
        specificFavorites.add(HadithEntity.fromJson(json) as T);
      }
    }

    return specificFavorites;
  }
}

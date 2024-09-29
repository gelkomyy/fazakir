import 'dart:convert';
import 'dart:math';

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/azkar/data/models/azkar_category_model.dart';
import 'package:fazakir/Features/azkar/data/models/azkar_item_model.dart';
import 'package:fazakir/Features/azkar/data/models/ruqyah_model.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/azkar/domain/entities/ruqyah_entity.dart';
import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class AzkarRepoImpl {
  final String jsonFilePath = 'assets/json/azkar.json';
  final String ruqyahJsonFilePath = 'assets/json/ruqyah.json';
  Future<List<AzkarCategoryEntity>> getAzkarCategories() async {
    final jsonString = await rootBundle.loadString(jsonFilePath);
    final List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse
        .map((json) => AzkarCategoryModel.fromJson(json))
        .toList();
  }

  // Method to get all AzkarItemEntity items across all categories
  Future<List<AzkarItemEntity>> getAllAzkarItems() async {
    final azkarCategories = await getAzkarCategories();

    // Combine all azkar from all categories into a single list
    final allAzkarItems =
        azkarCategories.expand((category) => category.azkar).toList();
    return allAzkarItems;
  }

  // Method to filter AzkarItems based on a search term
  Future<SearchResult> filterAzkarItems(String searchAzkar) async {
    final allAzkarItems = await getAllAzkarItems();

    if (searchAzkar.isEmpty || allAzkarItems.isEmpty) {
      return SearchResult(exactMatches: [], relatedMatches: []);
    }

    return await compute<Map<String, dynamic>, SearchResult>(
      _filterAzkarItemsIsolate,
      {
        'searchAzkar': searchAzkar,
        'allAzkarItems': allAzkarItems.map((z) => z.toJson()).toList(),
      },
    );
  }

  // Isolate function to perform the filtering
  static SearchResult _filterAzkarItemsIsolate(Map<String, dynamic> params) {
    final String searchAzkar = params['searchAzkar'];
    final List<Map<String, dynamic>> allAzkarItemsMaps =
        params['allAzkarItems'];

    // Normalize the query by removing diacritics
    final normalizedQuery = removeDiacritics(searchAzkar).toLowerCase();
    final searchTerms = normalizedQuery.split(' ');

    final List<AzkarItemEntity> allAzkarItems =
        allAzkarItemsMaps.map((m) => AzkarItemModel.fromJson(m)).toList();

    List<AzkarItemEntity> exactMatches = [];
    List<AzkarItemEntity> relatedMatches = [];

    for (AzkarItemEntity azkarItem in allAzkarItems) {
      String normalizedAzkar = removeDiacritics(azkarItem.text).toLowerCase();

      // Exact match: search term is found as a whole in the azkar content
      if (normalizedAzkar.contains(normalizedQuery)) {
        exactMatches.add(azkarItem);
      } else if (searchTerms.every((term) => normalizedAzkar.contains(term))) {
        // Related match: all search terms are found in the azkar content
        relatedMatches.add(azkarItem);
      }
    }

    return SearchResult(
      exactMatches: exactMatches,
      relatedMatches: relatedMatches,
    );
  }

  Future<List<RuqyahEntity>> fetchRuqyah() async {
    final jsonString = await rootBundle.loadString(ruqyahJsonFilePath);
    final List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse.map((json) => RuqyahModel.fromJson(json)).toList();
  }

  Future<AzkarCategoryEntity> getRandomAzkarCategory() async {
    try {
      // Load the JSON file from assets
      final String response = await rootBundle.loadString(jsonFilePath);
      final List<dynamic> data = json.decode(response);

      int retries = 0;
      int maxRetries = 3;
      AzkarCategoryEntity? randomCategory;

      while (retries < maxRetries) {
        // Pick a random category
        final randomCategoryIndex = Random().nextInt(data.length);
        final randomCategoryData = data[randomCategoryIndex];

        // Parse the random category
        randomCategory = AzkarCategoryModel.fromJson(randomCategoryData);

        // Check if the category has any items
        if (randomCategory.azkar.isNotEmpty) {
          // Select a random item from the category's items
          final randomItemIndex = Random().nextInt(randomCategory.azkar.length);
          final randomItem = randomCategory.azkar[randomItemIndex];

          // Clear all items and keep only the selected random item

          return randomCategory.copyWith(
            azkar: [randomItem],
          ); // Success
        }

        // Increment retry count if the category is empty
        retries++;
      }

      // If retries are exhausted, throw an error
      throw Exception(
          "No valid Azkar category with items found after $maxRetries retries.");
    } catch (e) {
      throw Exception("Error fetching random Azkar category: $e");
    }
  }
}

import 'dart:convert';
import 'dart:math';

import 'package:fazakir/Features/azkar/data/models/azkar_category_model.dart';
import 'package:fazakir/Features/azkar/data/models/ruqyah_model.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/Features/azkar/domain/entities/ruqyah_entity.dart';
import 'package:flutter/services.dart';

class AzkarRepoImpl {
  final String jsonFilePath = 'assets/json/azkar.json';
  final String ruqyahJsonFilePath = 'assets/json/ruqyah.json';
  Future<List<AzkarCategoryEntity>> getAzkar() async {
    final jsonString = await rootBundle.loadString(jsonFilePath);
    final List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse
        .map((json) => AzkarCategoryModel.fromJson(json))
        .toList();
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

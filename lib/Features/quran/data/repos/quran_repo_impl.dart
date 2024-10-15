import 'dart:convert';
import 'package:fazakir/Features/quran/data/models/surah_model.dart';
import 'package:fazakir/Features/quran/domain/entities/surah_entity.dart';
import 'package:flutter/services.dart';

class QuranRepoImpl {
  // Method to load and parse the JSON file
  Future<List<SurahEntity>> fetchSurahs() async {
    // Load the JSON file from assets
    final jsonString = await rootBundle.loadString('assets/json/surahs.json');

    // Decode the JSON string
    final List<dynamic> jsonData = json.decode(jsonString);

    return jsonData.map((json) => SurahModel.fromMap(json).toEntity()).toList();
  }
}

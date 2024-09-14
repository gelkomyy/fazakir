import 'dart:convert';

import 'package:fazakir/Features/azkar/data/models/azkar_category_model.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:flutter/services.dart';

class AzkarRepoImpl {
  Future<List<AzkarCategoryEntity>> getAzkar() async {
    final jsonString = await rootBundle.loadString('assets/json/azkar.json');
    final List<dynamic> jsonResponse = jsonDecode(jsonString);
    return jsonResponse
        .map((json) => AzkarCategoryModel.fromJson(json))
        .toList();
  }
}

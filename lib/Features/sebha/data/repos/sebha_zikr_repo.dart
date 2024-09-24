import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SebhaZikrRepo {
  static const String _zikrKey = 'sebha_zikr';

  static Future<void> addZikr(SebhaZikrModel zikrModel) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    final List<String> storedZikrs = prefs.getStringList(_zikrKey) ?? [];

    // Check for duplicates before adding
    bool exists = storedZikrs.any((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return json['zikr'] == zikrModel.zikr && json['count'] == zikrModel.count;
    });

    if (!exists) {
      // Convert the model to JSON and add to the list
      storedZikrs.add(jsonEncode(zikrModel.toJson()));

      // Save the updated list back to shared preferences
      await prefs.setStringList(_zikrKey, storedZikrs);
    }
  }

  static List<SebhaZikrModel> getZikrs() {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    final List<String> storedZikrs = prefs.getStringList(_zikrKey) ?? [];

    // Convert the JSON strings back to SebhaZikrModel instances
    List<SebhaZikrModel> zikrModels = storedZikrs.map((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return SebhaZikrModel.fromJson(json);
    }).toList();

    // Create a Set to hold unique combinations of zikr and count
    final uniqueZikrs = <String, SebhaZikrModel>{};

    for (var zikrModel in zikrModels) {
      // Use a combination of zikr and count as the key
      final key = '${zikrModel.zikr}-${zikrModel.count}';
      // Add to the map if not already present
      if (!uniqueZikrs.containsKey(key)) {
        uniqueZikrs[key] = zikrModel;
      }
    }

    // Return the unique values as a list
    return uniqueZikrs.values.toList();
  }

  static Future<void> updateZikr(int id, SebhaZikrModel zikrModel) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    final List<String> storedZikrs = prefs.getStringList(_zikrKey) ?? [];

    // Update the specific item in the list by ID
    for (int i = 0; i < storedZikrs.length; i++) {
      final Map<String, dynamic> json = jsonDecode(storedZikrs[i]);
      if (json['id'] == id) {
        storedZikrs[i] = jsonEncode(zikrModel.toJson());
        break;
      }
    }

    // Save the updated list back to shared preferences
    await prefs.setStringList(_zikrKey, storedZikrs);
  }

  static Future<void> deleteZikr(int id) async {
    final SharedPreferences prefs = getIt<SharedPreferences>();
    final List<String> storedZikrs = prefs.getStringList(_zikrKey) ?? [];

    // Remove the item with the specified ID from the list
    final updatedZikrs = storedZikrs.where((jsonString) {
      final Map<String, dynamic> json = jsonDecode(jsonString);
      return json['id'] != id; // Keep only those that do not match the ID
    }).toList();

    // Save the updated list back to shared preferences
    await prefs.setStringList(_zikrKey, updatedZikrs);
  }
}

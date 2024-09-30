import 'dart:developer';

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  static Isar? _isar;

  // Initialize Isar
  static Future<void> init() async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        [HadithEntitySchema],
        directory: dir.path,
      ); // Open the Isar database
    }
  }

  // Save a list of HadithEntity to Isar
  static Future<void> saveHadithEntities(List<HadithEntity> hadiths) async {
    await init(); // Ensure Isar is initialized
    try {
      await _isar!.writeTxn(() async {
        await _isar!.hadithEntitys
            .putAll(hadiths); // Save all HadithEntity records
      });
    } catch (e) {
      log('Error saving hadiths to Isar: $e');
    }
  }

  // Load all HadithEntity from Isar
  static Future<List<HadithEntity>> loadHadithEntities() async {
    await init(); // Ensure Isar is initialized
    try {
      return await _isar!.hadithEntitys
          .where()
          .findAll(); // Load all HadithEntity records
    } catch (e) {
      log('Error loading hadiths from Isar: $e');
      return []; // Return empty list on error
    }
  }

  // Close Isar
  static Future<void> close() async {
    await _isar?.close();
    _isar = null; // Reset the instance
  }
}

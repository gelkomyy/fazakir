import 'package:hadith/hadith.dart';

extension ManageHadithsExtensions on Collections {
  String get displayName {
    switch (this) {
      case Collections.bukhari:
        return 'صحيح البخاري';
      case Collections.muslim:
        return 'صحيح مسلم';
      case Collections.nasai:
        return 'سنن النسائي';
      case Collections.abudawud:
        return 'سنن أبي داود';
      case Collections.tirmidhi:
        return 'سنن الترمذي';
      case Collections.ibnmajah:
        return 'سنن ابن ماجه';
      default:
        throw Exception('Unknown Collection');
    }
  }

  static List<String> getDisplayNames() {
    return Collections.values
        .map((collection) => collection.displayName)
        .toList()
      ..sort((a, b) => a == 'سنن ابن ماجه' ? 1 : -1);
  }

  static Collections getCollectionByName(String name) {
    return Collections.values.firstWhere(
      (collection) => collection.displayName == name,
      orElse: () => throw Exception('Collection not found for name: $name'),
    );
  }
}

import 'package:fazakir/Features/azkar/domain/entities/ruqyah_entity.dart';

class RuqyahModel extends RuqyahEntity {
  RuqyahModel(
      {required super.id,
      required super.order,
      required super.zikr,
      required super.count,
      required super.source,
      required super.almujaza,
      required super.almutawasita,
      required super.almutawala});
  // Factory method to create an instance from JSON
  factory RuqyahModel.fromJson(Map<String, dynamic> json) {
    return RuqyahModel(
      id: json['id'] ?? 0,
      order: json['order'] ?? 0,
      zikr: json['zikr'] ?? '',
      count: json['count'] ?? 1,
      source: json['source'] ?? '',
      almujaza: _convertToBool(json['almujaza']),
      almutawasita: _convertToBool(json['almutawasita']),
      almutawala: _convertToBool(json['almutawala']),
    );
  }

  // Method to convert this instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'order': order,
      'zikr': zikr,
      'count': count,
      'source': source,
      'almujaza': almujaza ? 1 : 0,
      'almutawasita': almutawasita ? 1 : 0,
      'almutawala': almutawala ? 1 : 0,
    };
  }

  // Helper method to convert int or null to bool
  static bool _convertToBool(dynamic value) {
    if (value == null || value == 0) {
      return false;
    }
    return true;
  }
}

import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';
import 'package:fazakir/Features/azkar/domain/entities/ruqyah_entity.dart';

class AzkarItemModel extends AzkarItemEntity {
  AzkarItemModel(
      {required super.id,
      required super.text,
      required super.count,
      super.source});

  factory AzkarItemModel.fromJson(Map<String, dynamic> json) {
    return AzkarItemModel(
      id: json['id'],
      text: json['text'],
      count: json['count'],
      source: json['source'] == '' ? null : json['source'],
    );
  }

  factory AzkarItemModel.fromRuqyah(RuqyahEntity ruqyah) {
    return AzkarItemModel(
      id: ruqyah.id,
      text: ruqyah.zikr,
      count: ruqyah.count,
      source: ruqyah.source == '' ? null : ruqyah.source,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'count': count,
      'source': source,
    };
  }
}

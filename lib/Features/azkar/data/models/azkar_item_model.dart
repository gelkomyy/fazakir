import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';

class AzkarItemModel extends AzkarItemEntity {
  AzkarItemModel(
      {required super.id, required super.text, required super.count});

  factory AzkarItemModel.fromJson(Map<String, dynamic> json) {
    return AzkarItemModel(
      id: json['id'],
      text: json['text'],
      count: json['count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'count': count,
    };
  }
}

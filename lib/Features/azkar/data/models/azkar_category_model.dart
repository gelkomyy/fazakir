import 'package:fazakir/Features/azkar/data/models/azkar_item_model.dart';
import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';

class AzkarCategoryModel extends AzkarCategoryEntity {
  AzkarCategoryModel(
      {required super.id, required super.category, required super.azkar});

  factory AzkarCategoryModel.fromJson(Map<String, dynamic> json) {
    return AzkarCategoryModel(
      id: json['id'],
      category: json['category'],
      azkar: (json['array'] as List<dynamic>)
          .map((item) => AzkarItemModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category,
      'array': azkar.map((item) => (item as AzkarItemModel).toJson()).toList(),
    };
  }
}

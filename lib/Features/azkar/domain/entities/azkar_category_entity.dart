import 'package:fazakir/Features/azkar/domain/entities/azkar_item_entity.dart';

class AzkarCategoryEntity {
  final int id;
  final String category;
  final List<AzkarItemEntity> azkar;

  AzkarCategoryEntity({
    required this.id,
    required this.category,
    required this.azkar,
  });

  AzkarCategoryEntity copyWith({
    String? category,
    List<AzkarItemEntity>? azkar,
  }) {
    return AzkarCategoryEntity(
      id: id,
      category: category ?? this.category,
      azkar: azkar ?? this.azkar,
    );
  }
}

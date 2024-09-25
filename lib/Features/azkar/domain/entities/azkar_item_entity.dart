import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';

class AzkarItemEntity extends FavoriteEntity {
  final int id;
  final String text;
  final int count;
  final String? source;

  AzkarItemEntity({
    required this.id,
    required this.text,
    required this.count,
    this.source,
  });

  @override
  String getIdentifier() => "zikr-$id-$count-$source-$text";

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

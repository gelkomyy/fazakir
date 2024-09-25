import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';

class VideoYoutubeEntity extends FavoriteEntity {
  final String title;
  final String url;
  final String thumbnailurl;

  VideoYoutubeEntity({
    required this.title,
    required this.url,
    required this.thumbnailurl,
  });

  @override
  String getIdentifier() => "video-$url";

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'url': url,
      'thumbnailurl': thumbnailurl,
    };
  }
}

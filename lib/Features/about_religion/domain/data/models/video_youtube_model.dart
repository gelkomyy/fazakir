import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';

class VideoYoutubeModel extends VideoYoutubeEntity {
  VideoYoutubeModel({
    required super.title,
    required super.url,
    required super.thumbnailurl,
  });

  factory VideoYoutubeModel.fromJson(Map<String, dynamic> json) {
    return VideoYoutubeModel(
      title: json['Title'],
      url: json['Videourl'],
      thumbnailurl: json['Thumbnailurl'],
    );
  }
}

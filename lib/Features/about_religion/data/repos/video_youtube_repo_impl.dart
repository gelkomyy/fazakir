import 'dart:convert';
import 'package:fazakir/Features/about_religion/data/models/video_youtube_model.dart';
import 'package:flutter/services.dart';
import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';

class VideoYoutubeRepoImpl {
  // Method to load and parse the JSON file
  Future<List<VideoYoutubeEntity>> fetchVideoList() async {
    // Load the JSON file from assets
    final jsonString =
        await rootBundle.loadString('assets/json/about_religion_videos.json');

    // Decode the JSON string
    final List<dynamic> jsonData = json.decode(jsonString);

    // Convert the JSON data to a list of VideoYoutubeEntity objects
    return jsonData.map((json) => VideoYoutubeModel.fromJson(json)).toList();
  }
}

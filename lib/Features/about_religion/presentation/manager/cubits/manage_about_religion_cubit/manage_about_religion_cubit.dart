import 'dart:async';

import 'package:fazakir/Features/about_religion/domain/data/repos/video_youtube_repo_impl.dart';
import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/azkar/data/repos/azkar_repo_impl.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'manage_about_religion_state.dart';

class ManageAboutReligionCubit extends Cubit<ManageAboutReligionState> {
  ManageAboutReligionCubit(this.videoRepository)
      : super(ManageAboutReligionInitial());
  final VideoYoutubeRepoImpl videoRepository;
  List<VideoYoutubeEntity> videos = [];
  List<VideoYoutubeEntity> filteredVideos = [];
  Timer? _debounce;
  Future<void> fetchVideos() async {
    try {
      safeEmit(VideosYoutubeLoading());
      videos = await videoRepository.fetchVideoList();
      filteredVideos = videos;
      safeEmit(VideosYoutubeSuccess(videoYoutubeEntities: filteredVideos));
    } catch (e) {
      safeEmit(
        VideosYoutubeFailure(message: 'Failed to load videos'),
      );
    }
  }

  // Filter videos with debouncing
  void filterVideosWithDebounce(String query) {
    // Cancel any active debounced call
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Set a delay of 300ms before triggering the filtering function
    _debounce = Timer(const Duration(milliseconds: 300), () {
      _filterVideos(query);
    });
  }

  // Filter videos by title
  void _filterVideos(String query) {
    if (query.isEmpty) {
      filteredVideos = videos; // If query is empty, reset to all videos
    } else {
      filteredVideos = videos.where((video) {
        final normalizedQuery =
            normalizeArabicText(removeDiacritics(query.toLowerCase()));
        final normalizedTitle =
            normalizeArabicText(removeDiacritics(video.title.toLowerCase()));
        return normalizedTitle.contains(normalizedQuery);
      }).toList();
    }

    // Emit success state with filtered videos
    safeEmit(VideosYoutubeSuccess(videoYoutubeEntities: filteredVideos));
  }

  @override
  Future<void> close() {
    // Cancel the debounce timer when the cubit is closed
    _debounce?.cancel();
    return super.close();
  }
}

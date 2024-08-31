import 'package:fazakir/Features/about_religion/domain/data/repos/video_youtube_repo_impl.dart';
import 'package:fazakir/Features/about_religion/domain/entities/video_youtube_entity.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

part 'manage_about_religion_state.dart';

class ManageAboutReligionCubit extends Cubit<ManageAboutReligionState> {
  ManageAboutReligionCubit(this.videoRepository)
      : super(ManageAboutReligionInitial());
  final VideoYoutubeRepoImpl videoRepository;

  Future<void> fetchVideos() async {
    try {
      safeEmit(VideosYoutubeLoading());
      final videos = await videoRepository.fetchVideoList();
      safeEmit(VideosYoutubeSuccess(videoYoutubeEntities: videos));
    } catch (e) {
      safeEmit(
        VideosYoutubeFailure(message: 'Failed to load videos'),
      );
    }
  }
}

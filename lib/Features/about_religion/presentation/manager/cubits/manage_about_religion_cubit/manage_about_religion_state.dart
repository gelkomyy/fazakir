part of 'manage_about_religion_cubit.dart';

@immutable
sealed class ManageAboutReligionState {}

final class ManageAboutReligionInitial extends ManageAboutReligionState {}

final class VideosYoutubeLoading extends ManageAboutReligionState {}

final class VideosYoutubeSuccess extends ManageAboutReligionState {
  final List<VideoYoutubeEntity> videoYoutubeEntities;
  VideosYoutubeSuccess({required this.videoYoutubeEntities});
}

final class VideosYoutubeFailure extends ManageAboutReligionState {
  final String message;

  VideosYoutubeFailure({required this.message});
}

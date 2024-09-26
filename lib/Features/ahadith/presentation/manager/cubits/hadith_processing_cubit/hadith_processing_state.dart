part of 'hadith_processing_cubit.dart';

@immutable
sealed class HadithProcessingState {}

final class HadithProcessingInitial extends HadithProcessingState {}

class HadithProcessingLoading extends HadithProcessingState {}

class HadithProcessingLoaded extends HadithProcessingState {
  final List<HadithEntity> allAhadith;
  HadithProcessingLoaded(this.allAhadith);
}

class HadithProcessingError extends HadithProcessingState {
  final String error;
  HadithProcessingError(this.error);
}

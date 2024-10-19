part of 'quran_cubit.dart';

@immutable
sealed class QuranState {
  const QuranState();
}

final class QuranInitial extends QuranState {}

final class SurahsLoaded extends QuranState {
  final List<SurahEntity> surahs;

  const SurahsLoaded({required this.surahs});
}

final class SurahsLoading extends QuranState {}

final class SurahsFailure extends QuranState {
  final String errMessage;
  const SurahsFailure(this.errMessage);
}

final class SearchInQuranFailure extends QuranState {
  final String errMessage;
  const SearchInQuranFailure(this.errMessage);
}

final class SearchInQuranLoading extends QuranState {}

final class SearchInQuranLoaded extends QuranState {
  final List<AyahEntity> ayat;
  const SearchInQuranLoaded({required this.ayat});
}

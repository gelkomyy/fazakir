part of 'manage_azkar_cubit.dart';

@immutable
sealed class ManageAzkarState {}

final class ManageAzkarInitial extends ManageAzkarState {}

final class FetchAzkarLoading extends ManageAzkarState {}

final class FetchAzkarSuccess extends ManageAzkarState {
  final List<AzkarCategoryEntity> azkarCategories;
  FetchAzkarSuccess({required this.azkarCategories});
}

final class FetchAzkarFailure extends ManageAzkarState {
  final String message;

  FetchAzkarFailure({required this.message});
}

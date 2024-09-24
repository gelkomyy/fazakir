part of 'manage_sebha_zikr_cubit.dart';

@immutable
sealed class ManageSebhaZikrState {}

final class ManageSebhaZikrInitial extends ManageSebhaZikrState {}

final class ManageSebhaZikrLoading extends ManageSebhaZikrState {}

final class GetAzkarFailure extends ManageSebhaZikrState {
  final String message;
  GetAzkarFailure({required this.message});
}

final class GetAzkarSuccess extends ManageSebhaZikrState {
  final List<SebhaZikrModel> azkar;
  GetAzkarSuccess({required this.azkar});
}

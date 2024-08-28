part of 'qiblah_cubit.dart';

abstract class QiblahState {}

class QiblahInitial extends QiblahState {}

class QiblahLoading extends QiblahState {}

class QiblahLocationUpdated extends QiblahState {
  final Position position;
  final double qiblahDirection;

  QiblahLocationUpdated(this.position, this.qiblahDirection);
}

class QiblahCompassUpdated extends QiblahState {
  final double heading;

  QiblahCompassUpdated(this.heading);
}

class QiblahError extends QiblahState {
  final String message;

  QiblahError(this.message);
}

import 'package:adhan/adhan.dart';
import 'package:fazakir/core/utils/extensions/cubit_safe_emit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:geolocator/geolocator.dart';

part 'qiblah_state.dart';

class QiblahCubit extends Cubit<QiblahState> {
  QiblahCubit() : super(QiblahInitial());
  double qiblahDirection = 137.3;
  void startTracking() {
    safeEmit(QiblahLoading());

    // Start location and compass updates
    _startLocationTracking();
    _startCompassTracking();
  }

  Future<void> _startLocationTracking() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ));
      qiblahDirection =
          _calculateQiblahDirection(position.latitude, position.longitude);
      safeEmit(QiblahLocationUpdated(position, qiblahDirection));
    } catch (e) {
      safeEmit(QiblahError("Error getting location: $e"));
    }
  }

  Future<void> _startCompassTracking() async {
    FlutterCompass.events!.listen((event) {
      if (event.heading != null) {
        safeEmit(QiblahCompassUpdated(event.heading!));
      }
    });
  }

  double _calculateQiblahDirection(double userLat, double userLng) {
    /* const double meccaLat = 21.4225;
    const double meccaLng = 39.8262;

    final double lat1 = userLat * pi / 180;
    final double lon1 = userLng * pi / 180;
    const double lat2 = meccaLat * pi / 180;
    const double lon2 = meccaLng * pi / 180;

    final double dLon = lon2 - lon1;

    final double y = sin(dLon) * cos(lat2);
    final double x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);

    final double brng = atan2(y, x) * 180 / pi;
    final double qiblahDirection = (brng + 360) % 360; */

    return Qibla(Coordinates(userLat, userLng)).direction;
  }
}

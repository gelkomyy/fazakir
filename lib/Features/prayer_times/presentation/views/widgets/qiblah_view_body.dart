import 'package:fazakir/Features/prayer_times/presentation/views/widgets/qiblah_compass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

class QiblahViewBody extends StatelessWidget {
  const QiblahViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FlutterQiblah.androidDeviceSensorSupport(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Error: ${snapshot.error.toString()}"),
          );
        }

        if (snapshot.data!) {
          return const QiblahCompass();
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

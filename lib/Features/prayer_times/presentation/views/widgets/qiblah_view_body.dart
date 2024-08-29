import 'package:fazakir/Features/prayer_times/presentation/views/widgets/move_for_compass_dialog.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/qiblah_compass.dart';
import 'package:flutter/material.dart';

class QiblahViewBody extends StatelessWidget {
  const QiblahViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        QiblahCompass(),
        MoveForCompassDialog(),
      ],
    );
  }
}

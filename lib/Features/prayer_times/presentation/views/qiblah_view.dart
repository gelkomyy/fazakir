import 'package:fazakir/Features/prayer_times/presentation/views/widgets/qiblah_view_body.dart';
import 'package:flutter/material.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  static const String routeName = 'qiblahView';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: QiblahViewBody(),
      ),
    );
  }
}

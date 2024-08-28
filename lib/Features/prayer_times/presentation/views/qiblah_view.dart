import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/qiblah_cubit/qiblah_cubit.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/qiblah_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  static const String routeName = 'qiblahView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiblahCubit()..startTracking(),
      child: const Scaffold(
        body: SafeArea(
          child: QiblahViewBody(),
        ),
      ),
    );
  }
}

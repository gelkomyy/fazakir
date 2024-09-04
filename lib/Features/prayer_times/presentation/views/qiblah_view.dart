import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/qiblah_cubit/qiblah_cubit.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/qiblah_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class QiblahView extends StatelessWidget {
  const QiblahView({super.key});

  static const String routeName = 'qiblahView';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QiblahCubit()..startTracking(),
      child: Scaffold(
        appBar: AppBar(
          leading: Bounceable(
            child: const Card(
              color: AppColors.textBlackColor,
              shape: CircleBorder(),
              margin: EdgeInsetsDirectional.only(start: 24),
              child: Icon(
                Icons.arrow_back_outlined,
                color: Colors.white,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: const SafeArea(
          child: QiblahViewBody(),
        ),
      ),
    );
  }
}

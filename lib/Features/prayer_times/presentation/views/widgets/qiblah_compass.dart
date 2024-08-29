import 'dart:math';

import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/qiblah_cubit/qiblah_cubit.dart';
import 'package:fazakir/Features/prayer_times/presentation/views/widgets/qiblah_compass_bottom.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Adjust the import according to your directory

class QiblahCompass extends StatelessWidget {
  const QiblahCompass({super.key});

  @override
  Widget build(BuildContext context) {
    final S txt = S.of(context);
    return BlocBuilder<QiblahCubit, QiblahState>(
      builder: (context, state) {
        if (state is QiblahLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is QiblahError) {
          return Center(child: Text(state.message));
        } else if (state is QiblahLocationUpdated ||
            state is QiblahCompassUpdated) {
          double qiblahDirection = context.read<QiblahCubit>().qiblahDirection;

          return BlocBuilder<QiblahCubit, QiblahState>(
            builder: (context, state) {
              if (state is QiblahCompassUpdated) {
                double direction = state.heading;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedRotation(
                            //  turns:
                            //     ((direction - qiblahDirection) * pi / 180) * -1,
                            turns: -2 * pi * (direction / 360),
                            duration: const Duration(seconds: 1),
                            alignment: Alignment.center,
                            child: Transform(
                              alignment: FractionalOffset.center,
                              transform:
                                  Matrix4.rotationZ(qiblahDirection * pi / 180),
                              origin: Offset.zero,
                              child: SvgPicture.asset(
                                Assets.assetsImagesCompassShapeWithKaabaSvg,
                                fit: BoxFit.contain,
                                alignment: Alignment.center,
                              ),
                            ),
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.transparent,
                            radius: 140,
                            child: Transform.rotate(
                              angle: -2 * pi * (direction / 360),
                              child: Transform(
                                alignment: FractionalOffset.center,
                                transform: Matrix4.rotationZ(
                                    qiblahDirection * pi / 180),
                                origin: Offset.zero,
                                child: const Align(
                                  alignment: Alignment.topCenter,
                                  child: Icon(
                                    Icons.expand_less_outlined,
                                    color: AppColors.primaryColor,
                                    size: 32,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    QiblahCompassBottom(
                      direction: direction,
                      qiblahDirection: qiblahDirection,
                    ),
                  ],
                );
              } else {
                return Center(
                    child: Text(
                  txt.waiting_for_compass_data,
                  style: AppFontStyles.styleRegular16(context),
                ));
              }
            },
          );
        } else {
          return Center(
              child: Text(
            txt.some_error_occurred,
            style: AppFontStyles.styleRegular16(context),
          ));
        }
      },
    );
  }
}

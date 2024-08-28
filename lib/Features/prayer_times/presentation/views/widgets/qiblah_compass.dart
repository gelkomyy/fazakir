import 'dart:math';

import 'package:fazakir/Features/prayer_times/presentation/manager/cubits/qiblah_cubit/qiblah_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Adjust the import according to your directory

class QiblahCompass extends StatelessWidget {
  const QiblahCompass({super.key});

  @override
  Widget build(BuildContext context) {
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
                                Assets.assetsImagesCompassShapeSvg,
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
                                child: Align(
                                  alignment: Alignment.topCenter,
                                  child: Image.asset(
                                    Assets.assetsImagesKaaba,
                                    width: 24,
                                    alignment: Alignment.topCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'تحرك مع السهم ',
                            style: TextStyle(
                              color: Color(0xFF1E201E),
                              fontSize: 16,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: 'الاحمر',
                            style: TextStyle(
                              color: Color(0xFFB90000),
                              fontSize: 16,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text: ' لتعرف زاوية قبلة الصلاة',
                            style: TextStyle(
                              color: Color(0xFF1E201E),
                              fontSize: 16,
                              fontFamily: 'Almarai',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'زاوية القبلة : ${qiblahDirection.toInt()}°',
                          style: AppFontStyles.styleRegular14(context),
                        ),
                        Container(
                          margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: 8),
                          color: AppColors.greyColor,
                          height: 10,
                          width: 1,
                        ),
                        Text(
                          showHeading(direction, qiblahDirection),
                          style: AppFontStyles.styleBold16(context).copyWith(
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                );
              } else {
                return const Center(child: Text('Waiting for compass data...'));
              }
            },
          );
        } else {
          return const Center(child: Text('Some error occurred'));
        }
      },
    );
  }

  String showHeading(double direction, double qiblaDirection) {
    return qiblaDirection.toInt() != direction.toInt()
        ? 'الزاوية الحالية :  ${direction.toStringAsFixed(0)}°'
        : "You're facing Makkah!";
  }
}

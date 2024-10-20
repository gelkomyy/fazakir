import 'package:fazakir/Features/sebha/data/models/sebha_zikr_model.dart';
import 'package:fazakir/Features/sebha/presentation/views/widgets/sebha_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class SebhaView extends StatelessWidget {
  const SebhaView({super.key, required this.zikrModel});
  static const String routeName = 'sebhaView';
  final SebhaZikrModel zikrModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          zikrModel.zikr,
          style: AppFontStyles.styleBold20(context),
        ),
        centerTitle: true,
        actions: [
          Bounceable(
            child: Card(
              color: AppColors.textBlackColor,
              shape: const CircleBorder(),
              margin: const EdgeInsetsDirectional.only(end: 24),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: SvgPicture.asset(
                  Assets.assetsImagesEditIconSvg,
                  width: 14,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: SebhaViewBody(
          zikrModel: zikrModel,
        ),
      ),
    );
  }
}

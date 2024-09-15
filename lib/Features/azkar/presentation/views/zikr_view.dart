import 'package:fazakir/Features/azkar/domain/entities/azkar_category_entity.dart';
import 'package:fazakir/Features/azkar/presentation/views/widgets/zikr_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class ZikrView extends StatelessWidget {
  const ZikrView({super.key, required this.azkar});
  static const String routeName = 'zikrView';
  final AzkarCategoryEntity azkar;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          azkar.category,
          style: AppFontStyles.styleBold20(context),
        ),
        centerTitle: true,
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
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: ZikrViewBody(
          azkar: azkar.azkar,
        ),
      ),
    );
  }
}

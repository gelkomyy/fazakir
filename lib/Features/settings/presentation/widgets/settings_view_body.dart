import 'package:fazakir/Features/settings/data/model/settings_list_model.dart';
import 'package:fazakir/Features/settings/presentation/widgets/app_creators.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/func/helper_funcs.dart';
import 'package:fazakir/core/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...getSettingsList(context).map((e) => e.buildList(context)),
            const SizedBox(
              height: 6,
            ),
            const AppCreators(),
            const SizedBox(
              height: 32,
            ),
            CustomTextButton(
              onPressed: () {
                shareApp(context);
              },
              padding: const EdgeInsets.all(14),
              text: '',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(Assets.assetsImagesStarIconSvg),
                  Text(
                    'شارك التجربة مع الاصدقاء',
                    style: AppFontStyles.styleBold14(context).copyWith(
                      color: Colors.white,
                    ),
                  ),
                  SvgPicture.asset(Assets.assetsImagesStarIconSvg),
                ],
              ),
            ),
            const SizedBox(
              height: 90,
            ),
          ],
        ),
      ),
    );
  }
}

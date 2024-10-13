import 'package:fazakir/Features/settings/data/model/settings_list_model.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
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
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              decoration: ShapeDecoration(
                color: const Color(0x51BBBBBB),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.assetsImagesElkomyLogo,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'برمجة وتطوير',
                        style: AppFontStyles.styleRegular14(context).copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'م: جاسر الكومى',
                        style: AppFontStyles.styleBold14(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          openLink('https://www.linkedin.com/in/gelkomy/');
                        },
                        child: SvgPicture.asset(
                          Assets.assetsImagesLinkedinIconSvg,
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        Assets.assetsImagesZiad,
                        width: 42,
                        height: 42,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        'مصمم واجهات',
                        style: AppFontStyles.styleRegular14(context).copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'م: زياد محمد',
                        style: AppFontStyles.styleBold14(context),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              openLink('https://www.facebook.com/el.zoz.7161/');
                            },
                            child: SvgPicture.asset(
                              Assets.assetsImagesFacebookIconSvg,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              openLink(
                                  'https://www.linkedin.com/in/ziad-mahmed-043a17322/');
                            },
                            child: SvgPicture.asset(
                              Assets.assetsImagesLinkedinIconSvg,
                              width: 18,
                              height: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              openLink('https://www.behance.net/ziadmahmed/');
                            },
                            child: SvgPicture.asset(
                              Assets.assetsImagesBehanceIconSvg,
                              width: 18,
                              height: 18,
                              colorFilter: const ColorFilter.mode(
                                AppColors.greyColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomTextButton(
              onPressed: () {
                openLink(
                    'https://play.google.com/store/apps/details?id=com.fazakir.elkomy');
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

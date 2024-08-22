import 'package:fazakir/Features/home/presentation/views/widgets/about_religion_column.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/container_zikr_of_the_day.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/home_view_body_header.dart';
import 'package:fazakir/Features/home/presentation/views/widgets/short_cut_items_list_view.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/row_label_with_show_more.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final S txt = S.of(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const HomeViewBodyHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      Assets.assetsImagesTimeElapsedSvg,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      'صلاة المغرب بعد ساعة و ٥ دقائق',
                      style: AppFontStyles.styleRegular14(context),
                    ),
                  ],
                ),
                const SizedBox(height: 42),
                RowLabelWithShowMore(
                  labelText: txt.shortcuts,
                ),
              ],
            ),
          ),
          const SizedBox(height: 38),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.2,
            child: const ShortCutItemsListView(),
          ),
          const SizedBox(height: 35),
          const ContainerZikrOfTheDay(),
          const SizedBox(height: 35),
          const AboutReligionColumn(),
        ],
      ),
    );
  }
}

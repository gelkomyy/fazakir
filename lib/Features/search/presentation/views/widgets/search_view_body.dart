import 'package:fazakir/Features/search/presentation/views/widgets/search_view_body_header.dart';
import 'package:fazakir/Features/search/presentation/views/widgets/search_view_body_list.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/custom_selection_items.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 24,
        end: 24,
        top: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomSelectionItems(
            texts: [
              'حديث',
              'ذكر',
            ],
            filterKey: 'search_type',
            backgroundColor: AppColors.greyColor,
            activeColor: AppColors.primaryColor,
            activeTextColor: Colors.white,
          ),
          const SizedBox(height: 24),
          const SearchViewBodyHeader(),
          const SizedBox(height: 32),
          Text(
            'نتائج البحث : ',
            style: AppFontStyles.styleBold20(context),
          ),
          const SizedBox(height: 8),
          const Expanded(child: SearchViewBodyList()),
        ],
      ),
    );
  }
}

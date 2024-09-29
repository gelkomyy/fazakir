import 'package:fazakir/Features/search/presentation/views/widgets/search_view_body_header.dart';
import 'package:fazakir/Features/search/presentation/views/widgets/search_view_body_list.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 32,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

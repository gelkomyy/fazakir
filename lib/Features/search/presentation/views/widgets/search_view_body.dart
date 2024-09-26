import 'package:fazakir/core/widgets/custom_search_text_field.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          CustomSearchTextField(
            hintText: S.of(context).search_mention_or_reciter,
          ),
          // SearchViewBodyHeader(),
          //    SearchViewBodyList(),
        ],
      ),
    );
  }
}

import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:fazakir/Features/search/presentation/views/widgets/search_field_with_suggetion_history.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SearchViewBodyHeader extends StatelessWidget {
  const SearchViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: SearchFieldWithSuggetionHistory(),
        ),
        const SizedBox(width: 16),
        Bounceable(
          onTap: () {
            context.read<SearchCubit>().searchContent();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              'بحث',
              style: AppFontStyles.styleBold14(context).copyWith(
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}

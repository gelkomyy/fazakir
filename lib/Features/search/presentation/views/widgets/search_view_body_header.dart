import 'package:fazakir/Features/search/presentation/manager/cubits/cubit/search_cubit.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:searchfield/searchfield.dart';

class SearchViewBodyHeader extends StatelessWidget {
  const SearchViewBodyHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 0,
                )
              ],
            ),
            child: SearchField<String>(
              autofocus: true,
              onTapOutside: (_) {
                FocusScope.of(context).unfocus();
              },
              suggestions: [
                SearchFieldListItem(
                  'Item 1',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.history,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Item 1',
                        style: AppFontStyles.styleRegular14(context),
                      ),
                      const Spacer(),
                      Bounceable(
                        onTap: () {},
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.red.shade900,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                SearchFieldListItem<String>(
                  'Item 2',
                  child: Row(
                    children: [
                      const Icon(
                        Icons.history,
                        size: 18,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Item 2',
                        style: AppFontStyles.styleRegular14(context),
                      ),
                      const Spacer(),
                      Bounceable(
                        onTap: () {},
                        child: Icon(
                          Icons.close_outlined,
                          color: Colors.red.shade900,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              searchInputDecoration: SearchInputDecoration(
                cursorColor: AppColors.primaryColor,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                searchStyle: AppFontStyles.styleRegular14(context),
                hintStyle: AppFontStyles.styleRegular11(context).copyWith(
                  color: AppColors.greyColor,
                ),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: SvgPicture.asset(
                    Assets.assetsImagesSearchIconSvg,
                    width: 16,
                    height: 16,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 12,
                  minWidth: 12,
                ),
                border: getBorder(),
                enabledBorder: getBorder(),
                hintText: S.of(context).search_zikr_or_hadith,
              ),
              suggestionsDecoration: SuggestionDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(6),
                ),
                color: Colors.white,
                elevation: 5,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Bounceable(
          onTap: () {
            context.read<SearchCubit>().searchContent('بني الدار');
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

  OutlineInputBorder getBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(5),
      ),
    );
  }
}
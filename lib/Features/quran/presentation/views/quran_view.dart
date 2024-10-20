import 'package:fazakir/Features/quran/data/repos/quran_repo_impl.dart';
import 'package:fazakir/Features/quran/presentation/manager/cubits/quran_cubit/quran_cubit.dart';
import 'package:fazakir/Features/quran/presentation/widgets/quran_view_body.dart';
import 'package:fazakir/core/utils/app_assets.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/utils/func/get_it_setup.dart';
import 'package:fazakir/core/widgets/custom_search_text_field.dart';
import 'package:fazakir/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:flutter_svg/svg.dart';

class QuranView extends StatefulWidget {
  const QuranView({super.key});
  static const String routeName = 'quranView';

  @override
  State<QuranView> createState() => _QuranViewState();
}

class _QuranViewState extends State<QuranView> {
  bool _isSearching = false; // Track search mode
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode(); // FocusNode for managing focus
  void _toggleSearch() {
    setState(() {
      _isSearching = !_isSearching;
    });

    // If search is activated, request focus for the TextField
    if (_isSearching) {
      _focusNode.requestFocus();
    } else {
      // If search is deactivated, clear the search input
      _searchController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit(
        getIt<QuranRepoImpl>(),
      )..fetchSurahs(),
      child: Scaffold(
        appBar: AppBar(
          title: _isSearching
              ? AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 40,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 6,
                        offset: Offset(0, 2),
                        spreadRadius: 0,
                      )
                    ],
                  ),
                  child: Builder(builder: (context) {
                    return CustomSearchTextField(
                      controller: _searchController,
                      focusNode: _focusNode,
                      onChanged: (query) {
                        context
                            .read<QuranCubit>()
                            .searchInQuranWithIsolateDebounce(query);
                        context
                            .read<QuranCubit>()
                            .filterSurahsWithDebounce(query);
                      },
                      hintText:
                          'ابحث برقم او بكلمة (سور, آيات, صفحات)' ' ..... ',
                    );
                  }),
                )
              : Text(
                  S.of(context).holy_quran,
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
                  padding: const EdgeInsets.all(7),
                  child: SvgPicture.asset(
                    Assets.assetsImagesSearchIconSvg,
                    width: 19,
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              onTap: () {
                _toggleSearch();
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
        body: const SafeArea(
          child: QuranViewBody(),
        ),
      ),
    );
  }
}

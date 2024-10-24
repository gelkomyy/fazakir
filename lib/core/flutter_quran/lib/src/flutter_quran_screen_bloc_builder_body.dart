import 'package:fazakir/core/flutter_quran/lib/src/app_bloc.dart';
import 'package:fazakir/core/flutter_quran/lib/src/models/quran_page.dart';
import 'package:fazakir/core/flutter_quran/lib/src/widgets/header_of_quran_screen.dart';
import 'package:fazakir/core/flutter_quran/lib/src/widgets/page_number_of_quran_widget.dart';
import 'package:fazakir/core/flutter_quran/lib/src/widgets/quran_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'controllers/quran_controller.dart';

class FlutterQuranScreenBlocBuilderBody extends StatelessWidget {
  const FlutterQuranScreenBlocBuilderBody({
    super.key,
    this.onPageChanged,
    required this.shouldHighlightText,
    required this.highlightVerse,
  });

  final Function(int)? onPageChanged;

  final bool shouldHighlightText;
  final String highlightVerse;
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.sizeOf(context);
    final Orientation currentOrientation = MediaQuery.orientationOf(context);
    return BlocBuilder<QuranCubit, List<QuranPage>>(
      builder: (ctx, pages) {
        return pages.isEmpty
            ? const Center(
                child: CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF705C42)),
                ),
              )
            : SafeArea(
                child: PageView.builder(
                  itemCount: pages.length,
                  controller: AppBloc.quranCubit.pageController,
                  onPageChanged: (page) {
                    if (onPageChanged != null) {
                      onPageChanged!(page + 1);
                    }

                    AppBloc.quranCubit.saveLastPage(page + 1);
                  },
                  pageSnapping: true,
                  itemBuilder: (ctx, index) {
                    List<String> newSurahs = [];
                    return Container(
                      height: deviceSize.height * 0.8,
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          HeaderOfQuranScreen(
                            pageNumber: pages[index].pageNumber,
                          ),
                          QuranScreenBody(
                            shouldHighlightText: shouldHighlightText,
                            highlightVerse: highlightVerse,
                            pages: pages,
                            deviceSize: deviceSize,
                            currentOrientation: currentOrientation,
                            newSurahs: newSurahs,
                            index: index,
                          ),
                          PageNumberOfQuranWidget(
                            pageNumber: pages[index].pageNumber,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}

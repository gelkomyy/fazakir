import 'package:fazakir/Features/ahadith/presentation/views/widgets/section_of_book_hadith_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/search_icon_in_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class SectionOfBookHadithView extends StatelessWidget {
  const SectionOfBookHadithView({super.key, required this.bookName});
  static const String routeName = 'sectionOfBookHadithView';
  final String bookName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          bookName,
          style: AppFontStyles.styleBold20(context),
        ),
        centerTitle: true,
        actions: const [
          SearchIconInAppBar(),
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
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SectionOfBookHadithViewBody(
          bookName: bookName,
        ),
      ),
    );
  }
}

import 'package:fazakir/Features/ahadith/presentation/views/widgets/a_6books_of_hadith_view_body.dart';
import 'package:fazakir/core/utils/app_colors.dart';
import 'package:fazakir/core/utils/app_font_styles.dart';
import 'package:fazakir/core/widgets/search_icon_in_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class A6BooksOfHadithView extends StatelessWidget {
  const A6BooksOfHadithView({super.key});
  static const String routeName = 'a6BooksOfHadithView';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الاحاديث النبوية',
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
      body: const SafeArea(
        child: A6BooksOfHadithViewBody(),
      ),
    );
  }
}

import 'package:fazakir/Features/ahadith/presentation/views/section_of_book_hadith_view.dart';
import 'package:fazakir/core/extensions/manage_hadiths_extensions.dart';
import 'package:fazakir/core/widgets/title_with_arrow_container.dart';
import 'package:flutter/material.dart';

class A6BooksOfHadithViewBody extends StatelessWidget {
  const A6BooksOfHadithViewBody({super.key});
  @override
  Widget build(BuildContext context) {
    final a6BooksOfHadiths = ManageHadithsExtensions.getDisplayNames();
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: a6BooksOfHadiths.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: index + 1 == a6BooksOfHadiths.length ? 0 : 24),
            child: TextWithArrowContainer(
              text: a6BooksOfHadiths[index],
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SectionOfBookHadithView.routeName,
                  arguments: a6BooksOfHadiths[index],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

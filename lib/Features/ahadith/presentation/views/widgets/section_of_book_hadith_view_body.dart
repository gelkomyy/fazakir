import 'package:fazakir/Features/ahadith/presentation/views/ahadith_view.dart';
import 'package:fazakir/core/extensions/manage_hadiths_extensions.dart';
import 'package:fazakir/core/widgets/title_with_arrow_container.dart';
import 'package:flutter/material.dart';
import 'package:hadith/hadith.dart';

class SectionOfBookHadithViewBody extends StatelessWidget {
  const SectionOfBookHadithViewBody({super.key, required this.bookName});
  final String bookName;
  @override
  Widget build(BuildContext context) {
    final sectionsOfBookHadith =
        getBooks(ManageHadithsExtensions.getCollectionByName(bookName));
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: sectionsOfBookHadith.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: index + 1 == sectionsOfBookHadith.length ? 0 : 24),
            child: TextWithArrowContainer(
              text: sectionsOfBookHadith[index].book[1].name,
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AhadithView.routeName,
                  arguments: {
                    'sectionOfBookHadithNumber': (bookName == 'سنن ابن ماجه' ||
                            bookName == 'صحيح مسلم')
                        ? int.tryParse(
                                    sectionsOfBookHadith[index].bookNumber) ==
                                null
                            ? 1
                            : int.parse(
                                    sectionsOfBookHadith[index].bookNumber) +
                                1
                        : int.parse(sectionsOfBookHadith[index].bookNumber),
                    'sectionOfBookHadith':
                        sectionsOfBookHadith[index].book[1].name,
                    'bookName': bookName,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

import 'package:fazakir/Features/ahadith/domain/entities/hadith_entity.dart';
import 'package:fazakir/Features/ahadith/presentation/views/widgets/container_hadith_item.dart';
import 'package:fazakir/core/extensions/manage_hadiths_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hadith/hadith.dart';

class AhadithViewBody extends StatelessWidget {
  const AhadithViewBody(
      {super.key,
      required this.sectionOfBookHadithNumber,
      required this.bookName});
  final int sectionOfBookHadithNumber;
  final String bookName;
  @override
  Widget build(BuildContext context) {
    final ahadith = getHadiths(
        ManageHadithsExtensions.getCollectionByName(bookName),
        sectionOfBookHadithNumber);
    return Padding(
      padding: const EdgeInsets.all(18),
      child: ListView.builder(
        clipBehavior: Clip.none,
        itemCount: ahadith.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
                bottom: index + 1 == ahadith.length ? 0 : 24),
            child: ContainerHadithItem(
              hadithEntity: HadithEntity(
                hadith: parseHadith(ahadith[index].hadith[1].body),
                bookName: bookName,
                sectionOfBookHadith: getBook(
                        ManageHadithsExtensions.getCollectionByName(bookName),
                        int.parse(ahadith[index].bookNumber))
                    .book[1]
                    .name,
                hadithNumber: ahadith[index].hadithNumber,
                grades: ahadith[index].hadith[1].grades,
              ),
            ),
          );
        },
      ),
    );
  }

  String parseHadith(String hadith) {
    // Replace custom tags with empty strings or spaces where needed
    hadith = hadith.replaceAll(
        RegExp(r'\[/?prematn\]'), ''); // Remove [prematn] and [/prematn]
    hadith = hadith.replaceAll(
        RegExp(r'\[/?matn\]'), ''); // Remove [matn] and [/matn]
    hadith = hadith.replaceAll(RegExp(r'\[/?narrator[^\]]*\]'),
        ''); // Remove narrator tags and their attributes
    hadith = hadith.replaceAll(
        RegExp(r'<[^>]*>'), ''); // Remove any leftover HTML tags

    // Optionally replace newline characters with actual newlines in Flutter
    hadith = hadith.replaceAll('\\n', '\n');

    return hadith;
  }
}

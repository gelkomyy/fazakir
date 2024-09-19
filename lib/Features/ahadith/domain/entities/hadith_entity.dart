class HadithEntity {
  final String hadith;

  final String hadithNumber;
  final String bookName;
  final String sectionOfBookHadith;
  final List grades;
  HadithEntity({
    required this.hadith,
    required this.bookName,
    required this.sectionOfBookHadith,
    required this.hadithNumber,
    required this.grades,
  });
}

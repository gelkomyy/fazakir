import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';

class HadithEntity extends FavoriteEntity {
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

  @override
  factory HadithEntity.fromJson(Map<String, dynamic> json) {
    return HadithEntity(
      hadith: json['hadith'],
      bookName: json['bookName'],
      sectionOfBookHadith: json['sectionOfBookHadith'],
      hadithNumber: json['hadithNumber'],
      grades: json['grades'],
    );
  }

  @override
  String getIdentifier() => "hadith-$hadithNumber-$sectionOfBookHadith";

  @override
  Map<String, dynamic> toJson() {
    return {
      'hadith': hadith,
      'bookName': bookName,
      'sectionOfBookHadith': sectionOfBookHadith,
      'hadithNumber': hadithNumber,
      'grades': grades,
    };
  }
}

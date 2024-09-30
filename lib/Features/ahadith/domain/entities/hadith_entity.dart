import 'dart:convert';

import 'package:fazakir/Features/favorites/domain/entities/favorite_entity.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class HadithEntity extends FavoriteEntity {
  @Id()
  int id = 0;
  final String hadith;
  final String hadithWithoutTashkeel;
  final String hadithNumber;
  final String bookName;
  final String sectionOfBookHadith;
  // Store the dynamic list as a JSON string
  final String gradesJson;

  // Getter to decode the JSON string back to List<dynamic>
  List<dynamic> get grades => jsonDecode(gradesJson);

  // Constructor without the `grades` parameter
  HadithEntity({
    required this.hadith,
    required this.bookName,
    required this.sectionOfBookHadith,
    required this.hadithNumber,
    required this.gradesJson,
  }) : hadithWithoutTashkeel = removeDiacritics(hadith);

  // Static method to create an instance with a `grades` list
  static HadithEntity create({
    required String hadith,
    required String bookName,
    required String sectionOfBookHadith,
    required String hadithNumber,
    required List<dynamic> grades,
  }) {
    return HadithEntity(
      hadith: hadith,
      bookName: bookName,
      sectionOfBookHadith: sectionOfBookHadith,
      hadithNumber: hadithNumber,
      gradesJson: jsonEncode(grades), // Convert List to JSON
    );
  }

  @override
  factory HadithEntity.fromJson(Map<String, dynamic> json) {
    return HadithEntity.create(
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

String removeDiacritics(String input) {
  final RegExp diacriticRegExp = RegExp(
      r'[\u0610-\u061A\u064B-\u065F\u06D6-\u06DC\u06DF-\u06E8\u06EA-\u06ED]');
  return input.replaceAll(diacriticRegExp, '');
}

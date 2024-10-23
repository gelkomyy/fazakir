// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AyahModel {
  final int id;
  final int jozz;
  final int suraNo;
  final String suraNameEn;
  final String suraNameAr;
  final int page;
  final int lineStart;
  final int lineEnd;
  final int ayaNo;
  final String ayaText;
  final String ayaTextEmlaey;

  AyahModel({
    required this.id,
    required this.jozz,
    required this.suraNo,
    required this.suraNameEn,
    required this.suraNameAr,
    required this.page,
    required this.lineStart,
    required this.lineEnd,
    required this.ayaNo,
    required this.ayaText,
    required this.ayaTextEmlaey,
  });

  AyahModel copyWith({
    int? id,
    int? jozz,
    int? suraNo,
    String? suraNameEn,
    String? suraNameAr,
    int? page,
    int? lineStart,
    int? lineEnd,
    int? ayaNo,
    String? ayaText,
    String? ayaTextEmlaey,
  }) {
    return AyahModel(
      id: id ?? this.id,
      jozz: jozz ?? this.jozz,
      suraNo: suraNo ?? this.suraNo,
      suraNameEn: suraNameEn ?? this.suraNameEn,
      suraNameAr: suraNameAr ?? this.suraNameAr,
      page: page ?? this.page,
      lineStart: lineStart ?? this.lineStart,
      lineEnd: lineEnd ?? this.lineEnd,
      ayaNo: ayaNo ?? this.ayaNo,
      ayaText: ayaText ?? this.ayaText,
      ayaTextEmlaey: ayaTextEmlaey ?? this.ayaTextEmlaey,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'jozz': jozz,
      'sura_no': suraNo,
      'sura_name_en': suraNameEn,
      'sura_name_ar': suraNameAr,
      'page': page,
      'line_start': lineStart,
      'line_end': lineEnd,
      'aya_no': ayaNo,
      'aya_text': ayaText,
      'aya_text_emlaey': ayaTextEmlaey,
    };
  }

  factory AyahModel.fromMap(Map<String, dynamic> map) {
    return AyahModel(
      id: map['id'] as int,
      jozz: map['jozz'] as int,
      suraNo: map['sura_no'] as int,
      suraNameEn: map['sura_name_en'] as String,
      suraNameAr: map['sura_name_ar'] as String,
      page: map['page'] as int,
      lineStart: map['line_start'] as int,
      lineEnd: map['line_end'] as int,
      ayaNo: map['aya_no'] as int,
      ayaText: map['aya_text'] as String,
      ayaTextEmlaey: map['aya_text_emlaey'] as String,
    );
  }

  static List<AyahModel> listOfMapsToListOfAyahModel(
      List<Map<String, dynamic>> listOfMaps) {
    return listOfMaps.map((map) => AyahModel.fromMap(map)).toList();
  }

  String toJson() => json.encode(toMap());

  factory AyahModel.fromJson(String source) =>
      AyahModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AyahModel(id: $id, jozz: $jozz, suraNo: $suraNo, suraNameEn: $suraNameEn, suraNameAr: $suraNameAr, page: $page, lineStart: $lineStart, lineEnd: $lineEnd, ayaNo: $ayaNo, ayaText: $ayaText, ayaTextEmlaey: $ayaTextEmlaey)';
  }

  @override
  bool operator ==(covariant AyahModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.jozz == jozz &&
        other.suraNo == suraNo &&
        other.suraNameEn == suraNameEn &&
        other.suraNameAr == suraNameAr &&
        other.page == page &&
        other.lineStart == lineStart &&
        other.lineEnd == lineEnd &&
        other.ayaNo == ayaNo &&
        other.ayaText == ayaText &&
        other.ayaTextEmlaey == ayaTextEmlaey;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        jozz.hashCode ^
        suraNo.hashCode ^
        suraNameEn.hashCode ^
        suraNameAr.hashCode ^
        page.hashCode ^
        lineStart.hashCode ^
        lineEnd.hashCode ^
        ayaNo.hashCode ^
        ayaText.hashCode ^
        ayaTextEmlaey.hashCode;
  }
}

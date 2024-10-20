extension NumberConverter on num {
  String toArabicDigits() {
    final String number = toString();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      sb.write(arabicDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }

  String toEnglishDigits() {
    final String number = toString();
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < number.length; i++) {
      sb.write(englishDigits[number[i]] ?? number[i]);
    }
    return sb.toString();
  }

  String toQuranJuz() {
    return quranJuz[this] ?? 'غير معروف';
  }
}

extension NumberConverterString on String {
  String toArabicDigits() {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < length; i++) {
      sb.write(arabicDigits[this[i]] ?? this[i]);
    }
    return sb.toString();
  }

  String toEnglishDigits() {
    StringBuffer sb = StringBuffer();
    for (int i = 0; i < length; i++) {
      sb.write(englishDigits[this[i]] ?? this[i]);
    }
    return sb.toString();
  }
}

const Map<String, String> arabicDigits = <String, String>{
  '0': '\u0660',
  '1': '\u0661',
  '2': '\u0662',
  '3': '\u0663',
  '4': '\u0664',
  '5': '\u0665',
  '6': '\u0666',
  '7': '\u0667',
  '8': '\u0668',
  '9': '\u0669',
};

const Map<String, String> englishDigits = <String, String>{
  '\u0660': '0',
  '\u0661': '1',
  '\u0662': '2',
  '\u0663': '3',
  '\u0664': '4',
  '\u0665': '5',
  '\u0666': '6',
  '\u0667': '7',
  '\u0668': '8',
  '\u0669': '9',
};

const Map<int, String> quranJuz = {
  1: 'الجزء الأول',
  2: 'الجزء الثاني',
  3: 'الجزء الثالث',
  4: 'الجزء الرابع',
  5: 'الجزء الخامس',
  6: 'الجزء السادس',
  7: 'الجزء السابع',
  8: 'الجزء الثامن',
  9: 'الجزء التاسع',
  10: 'الجزء العاشر',
  11: 'الجزء الحادي عشر',
  12: 'الجزء الثاني عشر',
  13: 'الجزء الثالث عشر',
  14: 'الجزء الرابع عشر',
  15: 'الجزء الخامس عشر',
  16: 'الجزء السادس عشر',
  17: 'الجزء السابع عشر',
  18: 'الجزء الثامن عشر',
  19: 'الجزء التاسع عشر',
  20: 'الجزء العشرون',
  21: 'الجزء الحادي والعشرون',
  22: 'الجزء الثاني والعشرون',
  23: 'الجزء الثالث والعشرون',
  24: 'الجزء الرابع والعشرون',
  25: 'الجزء الخامس والعشرون',
  26: 'الجزء السادس والعشرون',
  27: 'الجزء السابع والعشرون',
  28: 'الجزء الثامن والعشرون',
  29: 'الجزء التاسع والعشرون',
  30: 'الجزء الثلاثون',
};

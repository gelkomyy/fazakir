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

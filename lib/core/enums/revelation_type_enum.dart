enum RevelationTypeEnum {
  meccan,
  medinan,
}

extension RevelationTypeExtension on RevelationTypeEnum {
  String get arabicName {
    switch (this) {
      case RevelationTypeEnum.meccan:
        return 'مكيّة';
      case RevelationTypeEnum.medinan:
        return 'مدنيّة';
    }
  }
}

RevelationTypeEnum getRevelationTypeEnum(String name) {
  switch (name.toLowerCase()) {
    case 'مكيّة':
    case 'مكي':
    case 'meccan':
      return RevelationTypeEnum.meccan;
    case 'مدنيّة':
    case 'مدني':
    case 'medinan':
      return RevelationTypeEnum.medinan;
    default:
      throw Exception('Unknown revelation type: $name');
  }
}

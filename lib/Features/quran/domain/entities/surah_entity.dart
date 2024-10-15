import 'package:fazakir/core/enums/revelation_type_enum.dart';

class SurahEntity {
  final int number;
  final String name;
  final int numberOfAyahs;
  final RevelationTypeEnum revelationType;
  const SurahEntity({
    required this.number,
    required this.name,
    required this.numberOfAyahs,
    required this.revelationType,
  });

  @override
  bool operator ==(covariant SurahEntity other) {
    if (identical(this, other)) return true;

    return other.number == number &&
        other.name == name &&
        other.numberOfAyahs == numberOfAyahs &&
        other.revelationType == revelationType;
  }

  @override
  int get hashCode {
    return number.hashCode ^
        name.hashCode ^
        numberOfAyahs.hashCode ^
        revelationType.hashCode;
  }
}

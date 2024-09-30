// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hadith_entity.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetHadithEntityCollection on Isar {
  IsarCollection<HadithEntity> get hadithEntitys => this.collection();
}

const HadithEntitySchema = CollectionSchema(
  name: r'HadithEntity',
  id: -5617803252536652507,
  properties: {
    r'bookName': PropertySchema(
      id: 0,
      name: r'bookName',
      type: IsarType.string,
    ),
    r'gradesJson': PropertySchema(
      id: 1,
      name: r'gradesJson',
      type: IsarType.string,
    ),
    r'hadith': PropertySchema(
      id: 2,
      name: r'hadith',
      type: IsarType.string,
    ),
    r'hadithNumber': PropertySchema(
      id: 3,
      name: r'hadithNumber',
      type: IsarType.string,
    ),
    r'hadithWithoutTashkeel': PropertySchema(
      id: 4,
      name: r'hadithWithoutTashkeel',
      type: IsarType.string,
    ),
    r'sectionOfBookHadith': PropertySchema(
      id: 5,
      name: r'sectionOfBookHadith',
      type: IsarType.string,
    )
  },
  estimateSize: _hadithEntityEstimateSize,
  serialize: _hadithEntitySerialize,
  deserialize: _hadithEntityDeserialize,
  deserializeProp: _hadithEntityDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _hadithEntityGetId,
  getLinks: _hadithEntityGetLinks,
  attach: _hadithEntityAttach,
  version: '3.1.0+1',
);

int _hadithEntityEstimateSize(
  HadithEntity object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.bookName.length * 3;
  bytesCount += 3 + object.gradesJson.length * 3;
  bytesCount += 3 + object.hadith.length * 3;
  bytesCount += 3 + object.hadithNumber.length * 3;
  bytesCount += 3 + object.hadithWithoutTashkeel.length * 3;
  bytesCount += 3 + object.sectionOfBookHadith.length * 3;
  return bytesCount;
}

void _hadithEntitySerialize(
  HadithEntity object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.bookName);
  writer.writeString(offsets[1], object.gradesJson);
  writer.writeString(offsets[2], object.hadith);
  writer.writeString(offsets[3], object.hadithNumber);
  writer.writeString(offsets[4], object.hadithWithoutTashkeel);
  writer.writeString(offsets[5], object.sectionOfBookHadith);
}

HadithEntity _hadithEntityDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HadithEntity(
    bookName: reader.readString(offsets[0]),
    gradesJson: reader.readString(offsets[1]),
    hadith: reader.readString(offsets[2]),
    hadithNumber: reader.readString(offsets[3]),
    sectionOfBookHadith: reader.readString(offsets[5]),
  );
  return object;
}

P _hadithEntityDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _hadithEntityGetId(HadithEntity object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _hadithEntityGetLinks(HadithEntity object) {
  return [];
}

void _hadithEntityAttach(
    IsarCollection<dynamic> col, Id id, HadithEntity object) {}

extension HadithEntityQueryWhereSort
    on QueryBuilder<HadithEntity, HadithEntity, QWhere> {
  QueryBuilder<HadithEntity, HadithEntity, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HadithEntityQueryWhere
    on QueryBuilder<HadithEntity, HadithEntity, QWhereClause> {
  QueryBuilder<HadithEntity, HadithEntity, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HadithEntityQueryFilter
    on QueryBuilder<HadithEntity, HadithEntity, QFilterCondition> {
  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      bookNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gradesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gradesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gradesJson',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gradesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gradesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gradesJson',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gradesJson',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      gradesJsonIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gradesJson',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> hadithEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> hadithBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hadith',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> hadithMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hadith',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hadith',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hadith',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hadithNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hadithNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hadithNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hadithNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hadithNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hadithNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hadithNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hadithNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hadithNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hadithNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hadithWithoutTashkeel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hadithWithoutTashkeel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hadithWithoutTashkeel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hadithWithoutTashkeel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hadithWithoutTashkeel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hadithWithoutTashkeel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hadithWithoutTashkeel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hadithWithoutTashkeel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hadithWithoutTashkeel',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      hadithWithoutTashkeelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hadithWithoutTashkeel',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sectionOfBookHadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sectionOfBookHadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sectionOfBookHadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sectionOfBookHadith',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sectionOfBookHadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sectionOfBookHadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sectionOfBookHadith',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sectionOfBookHadith',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sectionOfBookHadith',
        value: '',
      ));
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterFilterCondition>
      sectionOfBookHadithIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sectionOfBookHadith',
        value: '',
      ));
    });
  }
}

extension HadithEntityQueryObject
    on QueryBuilder<HadithEntity, HadithEntity, QFilterCondition> {}

extension HadithEntityQueryLinks
    on QueryBuilder<HadithEntity, HadithEntity, QFilterCondition> {}

extension HadithEntityQuerySortBy
    on QueryBuilder<HadithEntity, HadithEntity, QSortBy> {
  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> sortByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> sortByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> sortByGradesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradesJson', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      sortByGradesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradesJson', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> sortByHadith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadith', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> sortByHadithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadith', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> sortByHadithNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithNumber', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      sortByHadithNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithNumber', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      sortByHadithWithoutTashkeel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithWithoutTashkeel', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      sortByHadithWithoutTashkeelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithWithoutTashkeel', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      sortBySectionOfBookHadith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionOfBookHadith', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      sortBySectionOfBookHadithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionOfBookHadith', Sort.desc);
    });
  }
}

extension HadithEntityQuerySortThenBy
    on QueryBuilder<HadithEntity, HadithEntity, QSortThenBy> {
  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByGradesJson() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradesJson', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      thenByGradesJsonDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradesJson', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByHadith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadith', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByHadithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadith', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByHadithNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithNumber', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      thenByHadithNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithNumber', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      thenByHadithWithoutTashkeel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithWithoutTashkeel', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      thenByHadithWithoutTashkeelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hadithWithoutTashkeel', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      thenBySectionOfBookHadith() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionOfBookHadith', Sort.asc);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QAfterSortBy>
      thenBySectionOfBookHadithDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sectionOfBookHadith', Sort.desc);
    });
  }
}

extension HadithEntityQueryWhereDistinct
    on QueryBuilder<HadithEntity, HadithEntity, QDistinct> {
  QueryBuilder<HadithEntity, HadithEntity, QDistinct> distinctByBookName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QDistinct> distinctByGradesJson(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gradesJson', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QDistinct> distinctByHadith(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hadith', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QDistinct> distinctByHadithNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hadithNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QDistinct>
      distinctByHadithWithoutTashkeel({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hadithWithoutTashkeel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HadithEntity, HadithEntity, QDistinct>
      distinctBySectionOfBookHadith({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sectionOfBookHadith',
          caseSensitive: caseSensitive);
    });
  }
}

extension HadithEntityQueryProperty
    on QueryBuilder<HadithEntity, HadithEntity, QQueryProperty> {
  QueryBuilder<HadithEntity, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HadithEntity, String, QQueryOperations> bookNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookName');
    });
  }

  QueryBuilder<HadithEntity, String, QQueryOperations> gradesJsonProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gradesJson');
    });
  }

  QueryBuilder<HadithEntity, String, QQueryOperations> hadithProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hadith');
    });
  }

  QueryBuilder<HadithEntity, String, QQueryOperations> hadithNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hadithNumber');
    });
  }

  QueryBuilder<HadithEntity, String, QQueryOperations>
      hadithWithoutTashkeelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hadithWithoutTashkeel');
    });
  }

  QueryBuilder<HadithEntity, String, QQueryOperations>
      sectionOfBookHadithProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sectionOfBookHadith');
    });
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_timer.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetWorkoutTimerCollection on Isar {
  IsarCollection<WorkoutTimer> get workoutTimers => this.collection();
}

const WorkoutTimerSchema = CollectionSchema(
  name: r'WorkoutTimer',
  id: 1604844873729151931,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'restCountDown': PropertySchema(
      id: 1,
      name: r'restCountDown',
      type: IsarType.long,
    ),
    r'runs': PropertySchema(
      id: 2,
      name: r'runs',
      type: IsarType.long,
    ),
    r'sessionCooldownTime': PropertySchema(
      id: 3,
      name: r'sessionCooldownTime',
      type: IsarType.long,
    ),
    r'sessions': PropertySchema(
      id: 4,
      name: r'sessions',
      type: IsarType.long,
    ),
    r'workoutCountDown': PropertySchema(
      id: 5,
      name: r'workoutCountDown',
      type: IsarType.long,
    ),
    r'workoutDurations': PropertySchema(
      id: 6,
      name: r'workoutDurations',
      type: IsarType.longList,
    )
  },
  estimateSize: _workoutTimerEstimateSize,
  serialize: _workoutTimerSerialize,
  deserialize: _workoutTimerDeserialize,
  deserializeProp: _workoutTimerDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _workoutTimerGetId,
  getLinks: _workoutTimerGetLinks,
  attach: _workoutTimerAttach,
  version: '3.1.0',
);

int _workoutTimerEstimateSize(
  WorkoutTimer object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.workoutDurations.length * 8;
  return bytesCount;
}

void _workoutTimerSerialize(
  WorkoutTimer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeLong(offsets[1], object.restCountDown);
  writer.writeLong(offsets[2], object.runs);
  writer.writeLong(offsets[3], object.sessionCooldownTime);
  writer.writeLong(offsets[4], object.sessions);
  writer.writeLong(offsets[5], object.workoutCountDown);
  writer.writeLongList(offsets[6], object.workoutDurations);
}

WorkoutTimer _workoutTimerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutTimer(
    name: reader.readString(offsets[0]),
    restCountDown: reader.readLong(offsets[1]),
    runs: reader.readLong(offsets[2]),
    sessionCooldownTime: reader.readLongOrNull(offsets[3]),
    sessions: reader.readLongOrNull(offsets[4]),
    workoutCountDown: reader.readLong(offsets[5]),
    workoutDurations: reader.readLongList(offsets[6]) ?? const [],
  );
  object.id = id;
  return object;
}

P _workoutTimerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readLongOrNull(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLongList(offset) ?? const []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _workoutTimerGetId(WorkoutTimer object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _workoutTimerGetLinks(WorkoutTimer object) {
  return [];
}

void _workoutTimerAttach(
    IsarCollection<dynamic> col, Id id, WorkoutTimer object) {
  object.id = id;
}

extension WorkoutTimerQueryWhereSort
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QWhere> {
  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension WorkoutTimerQueryWhere
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QWhereClause> {
  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterWhereClause> idBetween(
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

extension WorkoutTimerQueryFilter
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QFilterCondition> {
  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> idBetween(
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

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      restCountDownEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'restCountDown',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      restCountDownGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'restCountDown',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      restCountDownLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'restCountDown',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      restCountDownBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'restCountDown',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> runsEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'runs',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      runsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'runs',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> runsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'runs',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition> runsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'runs',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionCooldownTimeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sessionCooldownTime',
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionCooldownTimeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sessionCooldownTime',
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionCooldownTimeEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionCooldownTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionCooldownTimeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionCooldownTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionCooldownTimeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionCooldownTime',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionCooldownTimeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionCooldownTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionsIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'sessions',
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionsIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'sessions',
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionsEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessions',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionsGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessions',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionsLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessions',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      sessionsBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutCountDownEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutCountDown',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutCountDownGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutCountDown',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutCountDownLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutCountDown',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutCountDownBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutCountDown',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsElementEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'workoutDurations',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsElementGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'workoutDurations',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsElementLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'workoutDurations',
        value: value,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsElementBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'workoutDurations',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workoutDurations',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workoutDurations',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workoutDurations',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workoutDurations',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workoutDurations',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterFilterCondition>
      workoutDurationsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'workoutDurations',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension WorkoutTimerQueryObject
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QFilterCondition> {}

extension WorkoutTimerQueryLinks
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QFilterCondition> {}

extension WorkoutTimerQuerySortBy
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QSortBy> {
  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortByRestCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restCountDown', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      sortByRestCountDownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restCountDown', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortByRuns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runs', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortByRunsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runs', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      sortBySessionCooldownTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionCooldownTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      sortBySessionCooldownTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionCooldownTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortBySessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessions', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> sortBySessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessions', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      sortByWorkoutCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutCountDown', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      sortByWorkoutCountDownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutCountDown', Sort.desc);
    });
  }
}

extension WorkoutTimerQuerySortThenBy
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QSortThenBy> {
  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenByRestCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restCountDown', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      thenByRestCountDownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'restCountDown', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenByRuns() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runs', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenByRunsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'runs', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      thenBySessionCooldownTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionCooldownTime', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      thenBySessionCooldownTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessionCooldownTime', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenBySessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessions', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy> thenBySessionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sessions', Sort.desc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      thenByWorkoutCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutCountDown', Sort.asc);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QAfterSortBy>
      thenByWorkoutCountDownDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'workoutCountDown', Sort.desc);
    });
  }
}

extension WorkoutTimerQueryWhereDistinct
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct> {
  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct>
      distinctByRestCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'restCountDown');
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct> distinctByRuns() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'runs');
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct>
      distinctBySessionCooldownTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessionCooldownTime');
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct> distinctBySessions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sessions');
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct>
      distinctByWorkoutCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutCountDown');
    });
  }

  QueryBuilder<WorkoutTimer, WorkoutTimer, QDistinct>
      distinctByWorkoutDurations() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutDurations');
    });
  }
}

extension WorkoutTimerQueryProperty
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QQueryProperty> {
  QueryBuilder<WorkoutTimer, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<WorkoutTimer, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<WorkoutTimer, int, QQueryOperations> restCountDownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'restCountDown');
    });
  }

  QueryBuilder<WorkoutTimer, int, QQueryOperations> runsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'runs');
    });
  }

  QueryBuilder<WorkoutTimer, int?, QQueryOperations>
      sessionCooldownTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessionCooldownTime');
    });
  }

  QueryBuilder<WorkoutTimer, int?, QQueryOperations> sessionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sessions');
    });
  }

  QueryBuilder<WorkoutTimer, int, QQueryOperations> workoutCountDownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutCountDown');
    });
  }

  QueryBuilder<WorkoutTimer, List<int>, QQueryOperations>
      workoutDurationsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutDurations');
    });
  }
}

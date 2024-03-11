// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timer.dart';

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
    r'restCountDown': PropertySchema(
      id: 0,
      name: r'restCountDown',
      type: IsarType.long,
    ),
    r'runs': PropertySchema(
      id: 1,
      name: r'runs',
      type: IsarType.long,
    ),
    r'workoutCountDown': PropertySchema(
      id: 2,
      name: r'workoutCountDown',
      type: IsarType.long,
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
  return bytesCount;
}

void _workoutTimerSerialize(
  WorkoutTimer object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.restCountDown);
  writer.writeLong(offsets[1], object.runs);
  writer.writeLong(offsets[2], object.workoutCountDown);
}

WorkoutTimer _workoutTimerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = WorkoutTimer(
    restCountDown: reader.readLong(offsets[0]),
    runs: reader.readLong(offsets[1]),
    workoutCountDown: reader.readLong(offsets[2]),
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
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
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
}

extension WorkoutTimerQueryObject
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QFilterCondition> {}

extension WorkoutTimerQueryLinks
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QFilterCondition> {}

extension WorkoutTimerQuerySortBy
    on QueryBuilder<WorkoutTimer, WorkoutTimer, QSortBy> {
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
      distinctByWorkoutCountDown() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'workoutCountDown');
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

  QueryBuilder<WorkoutTimer, int, QQueryOperations> workoutCountDownProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'workoutCountDown');
    });
  }
}

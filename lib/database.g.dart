// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PersonsTable extends Persons with TableInfo<$PersonsTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<int> uuid = GeneratedColumn<int>(
      'uuid', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumnWithTypeConverter<Gender, int> gender =
      GeneratedColumn<int>('gender', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Gender>($PersonsTable.$convertergender);
  @override
  List<GeneratedColumn> get $columns => [uuid, firstName, lastName, gender];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(Insertable<Person> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    context.handle(_genderMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      uuid: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}uuid'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      gender: $PersonsTable.$convertergender.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender'])!),
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, int, int> $convertergender =
      const EnumIndexConverter<Gender>(Gender.values);
}

class Person extends DataClass implements Insertable<Person> {
  final int uuid;
  final String firstName;
  final String lastName;
  final Gender gender;
  const Person(
      {required this.uuid,
      required this.firstName,
      required this.lastName,
      required this.gender});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<int>(uuid);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    {
      map['gender'] =
          Variable<int>($PersonsTable.$convertergender.toSql(gender));
    }
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      uuid: Value(uuid),
      firstName: Value(firstName),
      lastName: Value(lastName),
      gender: Value(gender),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      uuid: serializer.fromJson<int>(json['uuid']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      gender: $PersonsTable.$convertergender
          .fromJson(serializer.fromJson<int>(json['gender'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<int>(uuid),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'gender':
          serializer.toJson<int>($PersonsTable.$convertergender.toJson(gender)),
    };
  }

  Person copyWith(
          {int? uuid, String? firstName, String? lastName, Gender? gender}) =>
      Person(
        uuid: uuid ?? this.uuid,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
      );
  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('uuid: $uuid, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uuid, firstName, lastName, gender);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.uuid == this.uuid &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.gender == this.gender);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<int> uuid;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<Gender> gender;
  const PersonsCompanion({
    this.uuid = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.uuid = const Value.absent(),
    required String firstName,
    required String lastName,
    required Gender gender,
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        gender = Value(gender);
  static Insertable<Person> custom({
    Expression<int>? uuid,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? gender,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (gender != null) 'gender': gender,
    });
  }

  PersonsCompanion copyWith(
      {Value<int>? uuid,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<Gender>? gender}) {
    return PersonsCompanion(
      uuid: uuid ?? this.uuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<int>(uuid.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (gender.present) {
      map['gender'] =
          Variable<int>($PersonsTable.$convertergender.toSql(gender.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender')
          ..write(')'))
        .toString();
  }
}

class $RelationTableTable extends RelationTable
    with TableInfo<$RelationTableTable, Relation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumnWithTypeConverter<Gender, int> gender =
      GeneratedColumn<int>('gender', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Gender>($RelationTableTable.$convertergender);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _baseRelationMeta =
      const VerificationMeta('baseRelation');
  @override
  late final GeneratedColumn<int> baseRelation = GeneratedColumn<int>(
      'base_relation', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relation_table (id)'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumnWithTypeConverter<Color, int> color =
      GeneratedColumn<int>('color', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Color>($RelationTableTable.$convertercolor);
  @override
  List<GeneratedColumn> get $columns =>
      [id, gender, label, baseRelation, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relation_table';
  @override
  VerificationContext validateIntegrity(Insertable<Relation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    context.handle(_genderMeta, const VerificationResult.success());
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    if (data.containsKey('base_relation')) {
      context.handle(
          _baseRelationMeta,
          baseRelation.isAcceptableOrUnknown(
              data['base_relation']!, _baseRelationMeta));
    }
    context.handle(_colorMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Relation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Relation(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      gender: $RelationTableTable.$convertergender.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender'])!),
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label']),
      baseRelation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}base_relation']),
      color: $RelationTableTable.$convertercolor.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])!),
    );
  }

  @override
  $RelationTableTable createAlias(String alias) {
    return $RelationTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, int, int> $convertergender =
      const EnumIndexConverter<Gender>(Gender.values);
  static TypeConverter<Color, int> $convertercolor = const ColorConverter();
}

class Relation extends DataClass implements Insertable<Relation> {
  final int id;
  final Gender gender;
  final String? label;
  final int? baseRelation;
  final Color color;
  const Relation(
      {required this.id,
      required this.gender,
      this.label,
      this.baseRelation,
      required this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['gender'] =
          Variable<int>($RelationTableTable.$convertergender.toSql(gender));
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || baseRelation != null) {
      map['base_relation'] = Variable<int>(baseRelation);
    }
    {
      map['color'] =
          Variable<int>($RelationTableTable.$convertercolor.toSql(color));
    }
    return map;
  }

  RelationTableCompanion toCompanion(bool nullToAbsent) {
    return RelationTableCompanion(
      id: Value(id),
      gender: Value(gender),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
      baseRelation: baseRelation == null && nullToAbsent
          ? const Value.absent()
          : Value(baseRelation),
      color: Value(color),
    );
  }

  factory Relation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Relation(
      id: serializer.fromJson<int>(json['id']),
      gender: $RelationTableTable.$convertergender
          .fromJson(serializer.fromJson<int>(json['gender'])),
      label: serializer.fromJson<String?>(json['label']),
      baseRelation: serializer.fromJson<int?>(json['baseRelation']),
      color: serializer.fromJson<Color>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'gender': serializer
          .toJson<int>($RelationTableTable.$convertergender.toJson(gender)),
      'label': serializer.toJson<String?>(label),
      'baseRelation': serializer.toJson<int?>(baseRelation),
      'color': serializer.toJson<Color>(color),
    };
  }

  Relation copyWith(
          {int? id,
          Gender? gender,
          Value<String?> label = const Value.absent(),
          Value<int?> baseRelation = const Value.absent(),
          Color? color}) =>
      Relation(
        id: id ?? this.id,
        gender: gender ?? this.gender,
        label: label.present ? label.value : this.label,
        baseRelation:
            baseRelation.present ? baseRelation.value : this.baseRelation,
        color: color ?? this.color,
      );
  @override
  String toString() {
    return (StringBuffer('Relation(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('label: $label, ')
          ..write('baseRelation: $baseRelation, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, gender, label, baseRelation, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Relation &&
          other.id == this.id &&
          other.gender == this.gender &&
          other.label == this.label &&
          other.baseRelation == this.baseRelation &&
          other.color == this.color);
}

class RelationTableCompanion extends UpdateCompanion<Relation> {
  final Value<int> id;
  final Value<Gender> gender;
  final Value<String?> label;
  final Value<int?> baseRelation;
  final Value<Color> color;
  const RelationTableCompanion({
    this.id = const Value.absent(),
    this.gender = const Value.absent(),
    this.label = const Value.absent(),
    this.baseRelation = const Value.absent(),
    this.color = const Value.absent(),
  });
  RelationTableCompanion.insert({
    this.id = const Value.absent(),
    required Gender gender,
    this.label = const Value.absent(),
    this.baseRelation = const Value.absent(),
    required Color color,
  })  : gender = Value(gender),
        color = Value(color);
  static Insertable<Relation> custom({
    Expression<int>? id,
    Expression<int>? gender,
    Expression<String>? label,
    Expression<int>? baseRelation,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (gender != null) 'gender': gender,
      if (label != null) 'label': label,
      if (baseRelation != null) 'base_relation': baseRelation,
      if (color != null) 'color': color,
    });
  }

  RelationTableCompanion copyWith(
      {Value<int>? id,
      Value<Gender>? gender,
      Value<String?>? label,
      Value<int?>? baseRelation,
      Value<Color>? color}) {
    return RelationTableCompanion(
      id: id ?? this.id,
      gender: gender ?? this.gender,
      label: label ?? this.label,
      baseRelation: baseRelation ?? this.baseRelation,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(
          $RelationTableTable.$convertergender.toSql(gender.value));
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (baseRelation.present) {
      map['base_relation'] = Variable<int>(baseRelation.value);
    }
    if (color.present) {
      map['color'] =
          Variable<int>($RelationTableTable.$convertercolor.toSql(color.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationTableCompanion(')
          ..write('id: $id, ')
          ..write('gender: $gender, ')
          ..write('label: $label, ')
          ..write('baseRelation: $baseRelation, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }
}

class $RelationshipTableTable extends RelationshipTable
    with TableInfo<$RelationshipTableTable, Relationship> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationshipTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _personAMeta =
      const VerificationMeta('personA');
  @override
  late final GeneratedColumn<int> personA = GeneratedColumn<int>(
      'person_a', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES persons (uuid)'));
  static const VerificationMeta _personBMeta =
      const VerificationMeta('personB');
  @override
  late final GeneratedColumn<int> personB = GeneratedColumn<int>(
      'person_b', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES persons (uuid)'));
  static const VerificationMeta _relationMeta =
      const VerificationMeta('relation');
  @override
  late final GeneratedColumn<int> relation = GeneratedColumn<int>(
      'relation', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES relation_table (id)'));
  @override
  List<GeneratedColumn> get $columns => [personA, personB, relation];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relationship_table';
  @override
  VerificationContext validateIntegrity(Insertable<Relationship> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('person_a')) {
      context.handle(_personAMeta,
          personA.isAcceptableOrUnknown(data['person_a']!, _personAMeta));
    } else if (isInserting) {
      context.missing(_personAMeta);
    }
    if (data.containsKey('person_b')) {
      context.handle(_personBMeta,
          personB.isAcceptableOrUnknown(data['person_b']!, _personBMeta));
    } else if (isInserting) {
      context.missing(_personBMeta);
    }
    if (data.containsKey('relation')) {
      context.handle(_relationMeta,
          relation.isAcceptableOrUnknown(data['relation']!, _relationMeta));
    } else if (isInserting) {
      context.missing(_relationMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Relationship map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Relationship(
      personA: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}person_a'])!,
      personB: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}person_b'])!,
      relation: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}relation'])!,
    );
  }

  @override
  $RelationshipTableTable createAlias(String alias) {
    return $RelationshipTableTable(attachedDatabase, alias);
  }
}

class Relationship extends DataClass implements Insertable<Relationship> {
  final int personA;
  final int personB;
  final int relation;
  const Relationship(
      {required this.personA, required this.personB, required this.relation});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['person_a'] = Variable<int>(personA);
    map['person_b'] = Variable<int>(personB);
    map['relation'] = Variable<int>(relation);
    return map;
  }

  RelationshipTableCompanion toCompanion(bool nullToAbsent) {
    return RelationshipTableCompanion(
      personA: Value(personA),
      personB: Value(personB),
      relation: Value(relation),
    );
  }

  factory Relationship.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Relationship(
      personA: serializer.fromJson<int>(json['personA']),
      personB: serializer.fromJson<int>(json['personB']),
      relation: serializer.fromJson<int>(json['relation']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'personA': serializer.toJson<int>(personA),
      'personB': serializer.toJson<int>(personB),
      'relation': serializer.toJson<int>(relation),
    };
  }

  Relationship copyWith({int? personA, int? personB, int? relation}) =>
      Relationship(
        personA: personA ?? this.personA,
        personB: personB ?? this.personB,
        relation: relation ?? this.relation,
      );
  @override
  String toString() {
    return (StringBuffer('Relationship(')
          ..write('personA: $personA, ')
          ..write('personB: $personB, ')
          ..write('relation: $relation')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(personA, personB, relation);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Relationship &&
          other.personA == this.personA &&
          other.personB == this.personB &&
          other.relation == this.relation);
}

class RelationshipTableCompanion extends UpdateCompanion<Relationship> {
  final Value<int> personA;
  final Value<int> personB;
  final Value<int> relation;
  final Value<int> rowid;
  const RelationshipTableCompanion({
    this.personA = const Value.absent(),
    this.personB = const Value.absent(),
    this.relation = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipTableCompanion.insert({
    required int personA,
    required int personB,
    required int relation,
    this.rowid = const Value.absent(),
  })  : personA = Value(personA),
        personB = Value(personB),
        relation = Value(relation);
  static Insertable<Relationship> custom({
    Expression<int>? personA,
    Expression<int>? personB,
    Expression<int>? relation,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (personA != null) 'person_a': personA,
      if (personB != null) 'person_b': personB,
      if (relation != null) 'relation': relation,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipTableCompanion copyWith(
      {Value<int>? personA,
      Value<int>? personB,
      Value<int>? relation,
      Value<int>? rowid}) {
    return RelationshipTableCompanion(
      personA: personA ?? this.personA,
      personB: personB ?? this.personB,
      relation: relation ?? this.relation,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (personA.present) {
      map['person_a'] = Variable<int>(personA.value);
    }
    if (personB.present) {
      map['person_b'] = Variable<int>(personB.value);
    }
    if (relation.present) {
      map['relation'] = Variable<int>(relation.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationshipTableCompanion(')
          ..write('personA: $personA, ')
          ..write('personB: $personB, ')
          ..write('relation: $relation, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $RelationTableTable relationTable = $RelationTableTable(this);
  late final $RelationshipTableTable relationshipTable =
      $RelationshipTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [persons, relationTable, relationshipTable];
}

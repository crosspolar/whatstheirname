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
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<String> contactId = GeneratedColumn<String>(
      'contact_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
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
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [uuid, contactId, firstName, lastName, gender, description];
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
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
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
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
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
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}contact_id']),
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      gender: $PersonsTable.$convertergender.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}gender'])!),
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
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
  final String? contactId;
  final String firstName;
  final String lastName;
  final Gender gender;
  final String? description;
  const Person(
      {required this.uuid,
      this.contactId,
      required this.firstName,
      required this.lastName,
      required this.gender,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<int>(uuid);
    if (!nullToAbsent || contactId != null) {
      map['contact_id'] = Variable<String>(contactId);
    }
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    {
      map['gender'] =
          Variable<int>($PersonsTable.$convertergender.toSql(gender));
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      uuid: Value(uuid),
      contactId: contactId == null && nullToAbsent
          ? const Value.absent()
          : Value(contactId),
      firstName: Value(firstName),
      lastName: Value(lastName),
      gender: Value(gender),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
    );
  }

  factory Person.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      uuid: serializer.fromJson<int>(json['uuid']),
      contactId: serializer.fromJson<String?>(json['contactId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      gender: $PersonsTable.$convertergender
          .fromJson(serializer.fromJson<int>(json['gender'])),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<int>(uuid),
      'contactId': serializer.toJson<String?>(contactId),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'gender':
          serializer.toJson<int>($PersonsTable.$convertergender.toJson(gender)),
      'description': serializer.toJson<String?>(description),
    };
  }

  Person copyWith(
          {int? uuid,
          Value<String?> contactId = const Value.absent(),
          String? firstName,
          String? lastName,
          Gender? gender,
          Value<String?> description = const Value.absent()}) =>
      Person(
        uuid: uuid ?? this.uuid,
        contactId: contactId.present ? contactId.value : this.contactId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        gender: gender ?? this.gender,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('uuid: $uuid, ')
          ..write('contactId: $contactId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(uuid, contactId, firstName, lastName, gender, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.uuid == this.uuid &&
          other.contactId == this.contactId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.gender == this.gender &&
          other.description == this.description);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<int> uuid;
  final Value<String?> contactId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<Gender> gender;
  final Value<String?> description;
  const PersonsCompanion({
    this.uuid = const Value.absent(),
    this.contactId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.gender = const Value.absent(),
    this.description = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.uuid = const Value.absent(),
    this.contactId = const Value.absent(),
    required String firstName,
    required String lastName,
    required Gender gender,
    this.description = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        gender = Value(gender);
  static Insertable<Person> custom({
    Expression<int>? uuid,
    Expression<String>? contactId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<int>? gender,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (contactId != null) 'contact_id': contactId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (gender != null) 'gender': gender,
      if (description != null) 'description': description,
    });
  }

  PersonsCompanion copyWith(
      {Value<int>? uuid,
      Value<String?>? contactId,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<Gender>? gender,
      Value<String?>? description}) {
    return PersonsCompanion(
      uuid: uuid ?? this.uuid,
      contactId: contactId ?? this.contactId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      gender: gender ?? this.gender,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<int>(uuid.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<String>(contactId.value);
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
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('uuid: $uuid, ')
          ..write('contactId: $contactId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('gender: $gender, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class $RelationTypesTable extends RelationTypes
    with TableInfo<$RelationTypesTable, RelationType> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationTypesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupLabelMeta =
      const VerificationMeta('groupLabel');
  @override
  late final GeneratedColumn<String> groupLabel = GeneratedColumn<String>(
      'group_label', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _groupIDMeta =
      const VerificationMeta('groupID');
  @override
  late final GeneratedColumn<int> groupID = GeneratedColumn<int>(
      'group_i_d', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumnWithTypeConverter<Color?, int> color =
      GeneratedColumn<int>('color', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<Color?>($RelationTypesTable.$convertercolorn);
  @override
  List<GeneratedColumn> get $columns => [groupLabel, groupID, color];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relation_types';
  @override
  VerificationContext validateIntegrity(Insertable<RelationType> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_label')) {
      context.handle(
          _groupLabelMeta,
          groupLabel.isAcceptableOrUnknown(
              data['group_label']!, _groupLabelMeta));
    }
    if (data.containsKey('group_i_d')) {
      context.handle(_groupIDMeta,
          groupID.isAcceptableOrUnknown(data['group_i_d']!, _groupIDMeta));
    }
    context.handle(_colorMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {groupID};
  @override
  RelationType map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationType(
      groupLabel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}group_label']),
      groupID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_i_d'])!,
      color: $RelationTypesTable.$convertercolorn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}color'])),
    );
  }

  @override
  $RelationTypesTable createAlias(String alias) {
    return $RelationTypesTable(attachedDatabase, alias);
  }

  static TypeConverter<Color, int> $convertercolor = const ColorConverter();
  static TypeConverter<Color?, int?> $convertercolorn =
      NullAwareTypeConverter.wrap($convertercolor);
}

class RelationType extends DataClass implements Insertable<RelationType> {
  final String? groupLabel;
  final int groupID;
  final Color? color;
  const RelationType({this.groupLabel, required this.groupID, this.color});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || groupLabel != null) {
      map['group_label'] = Variable<String>(groupLabel);
    }
    map['group_i_d'] = Variable<int>(groupID);
    if (!nullToAbsent || color != null) {
      map['color'] =
          Variable<int>($RelationTypesTable.$convertercolorn.toSql(color));
    }
    return map;
  }

  RelationTypesCompanion toCompanion(bool nullToAbsent) {
    return RelationTypesCompanion(
      groupLabel: groupLabel == null && nullToAbsent
          ? const Value.absent()
          : Value(groupLabel),
      groupID: Value(groupID),
      color:
          color == null && nullToAbsent ? const Value.absent() : Value(color),
    );
  }

  factory RelationType.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationType(
      groupLabel: serializer.fromJson<String?>(json['groupLabel']),
      groupID: serializer.fromJson<int>(json['groupID']),
      color: serializer.fromJson<Color?>(json['color']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupLabel': serializer.toJson<String?>(groupLabel),
      'groupID': serializer.toJson<int>(groupID),
      'color': serializer.toJson<Color?>(color),
    };
  }

  RelationType copyWith(
          {Value<String?> groupLabel = const Value.absent(),
          int? groupID,
          Value<Color?> color = const Value.absent()}) =>
      RelationType(
        groupLabel: groupLabel.present ? groupLabel.value : this.groupLabel,
        groupID: groupID ?? this.groupID,
        color: color.present ? color.value : this.color,
      );
  @override
  String toString() {
    return (StringBuffer('RelationType(')
          ..write('groupLabel: $groupLabel, ')
          ..write('groupID: $groupID, ')
          ..write('color: $color')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupLabel, groupID, color);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationType &&
          other.groupLabel == this.groupLabel &&
          other.groupID == this.groupID &&
          other.color == this.color);
}

class RelationTypesCompanion extends UpdateCompanion<RelationType> {
  final Value<String?> groupLabel;
  final Value<int> groupID;
  final Value<Color?> color;
  const RelationTypesCompanion({
    this.groupLabel = const Value.absent(),
    this.groupID = const Value.absent(),
    this.color = const Value.absent(),
  });
  RelationTypesCompanion.insert({
    this.groupLabel = const Value.absent(),
    this.groupID = const Value.absent(),
    this.color = const Value.absent(),
  });
  static Insertable<RelationType> custom({
    Expression<String>? groupLabel,
    Expression<int>? groupID,
    Expression<int>? color,
  }) {
    return RawValuesInsertable({
      if (groupLabel != null) 'group_label': groupLabel,
      if (groupID != null) 'group_i_d': groupID,
      if (color != null) 'color': color,
    });
  }

  RelationTypesCompanion copyWith(
      {Value<String?>? groupLabel, Value<int>? groupID, Value<Color?>? color}) {
    return RelationTypesCompanion(
      groupLabel: groupLabel ?? this.groupLabel,
      groupID: groupID ?? this.groupID,
      color: color ?? this.color,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupLabel.present) {
      map['group_label'] = Variable<String>(groupLabel.value);
    }
    if (groupID.present) {
      map['group_i_d'] = Variable<int>(groupID.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(
          $RelationTypesTable.$convertercolorn.toSql(color.value));
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationTypesCompanion(')
          ..write('groupLabel: $groupLabel, ')
          ..write('groupID: $groupID, ')
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
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES relation_types (group_i_d)'));
  static const VerificationMeta _relationshipStatusMeta =
      const VerificationMeta('relationshipStatus');
  @override
  late final GeneratedColumnWithTypeConverter<RelationshipStatus?, int>
      relationshipStatus = GeneratedColumn<int>(
              'relationship_status', aliasedName, true,
              type: DriftSqlType.int, requiredDuringInsert: false)
          .withConverter<RelationshipStatus?>(
              $RelationshipTableTable.$converterrelationshipStatusn);
  @override
  List<GeneratedColumn> get $columns =>
      [personA, personB, relation, relationshipStatus];
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
    context.handle(_relationshipStatusMeta, const VerificationResult.success());
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
      relationshipStatus: $RelationshipTableTable.$converterrelationshipStatusn
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.int, data['${effectivePrefix}relationship_status'])),
    );
  }

  @override
  $RelationshipTableTable createAlias(String alias) {
    return $RelationshipTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<RelationshipStatus, int, int>
      $converterrelationshipStatus =
      const EnumIndexConverter<RelationshipStatus>(RelationshipStatus.values);
  static JsonTypeConverter2<RelationshipStatus?, int?, int?>
      $converterrelationshipStatusn =
      JsonTypeConverter2.asNullable($converterrelationshipStatus);
}

class Relationship extends DataClass implements Insertable<Relationship> {
  final int personA;
  final int personB;
  final int relation;
  final RelationshipStatus? relationshipStatus;
  const Relationship(
      {required this.personA,
      required this.personB,
      required this.relation,
      this.relationshipStatus});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['person_a'] = Variable<int>(personA);
    map['person_b'] = Variable<int>(personB);
    map['relation'] = Variable<int>(relation);
    if (!nullToAbsent || relationshipStatus != null) {
      map['relationship_status'] = Variable<int>($RelationshipTableTable
          .$converterrelationshipStatusn
          .toSql(relationshipStatus));
    }
    return map;
  }

  RelationshipTableCompanion toCompanion(bool nullToAbsent) {
    return RelationshipTableCompanion(
      personA: Value(personA),
      personB: Value(personB),
      relation: Value(relation),
      relationshipStatus: relationshipStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(relationshipStatus),
    );
  }

  factory Relationship.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Relationship(
      personA: serializer.fromJson<int>(json['personA']),
      personB: serializer.fromJson<int>(json['personB']),
      relation: serializer.fromJson<int>(json['relation']),
      relationshipStatus: $RelationshipTableTable.$converterrelationshipStatusn
          .fromJson(serializer.fromJson<int?>(json['relationshipStatus'])),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'personA': serializer.toJson<int>(personA),
      'personB': serializer.toJson<int>(personB),
      'relation': serializer.toJson<int>(relation),
      'relationshipStatus': serializer.toJson<int?>($RelationshipTableTable
          .$converterrelationshipStatusn
          .toJson(relationshipStatus)),
    };
  }

  Relationship copyWith(
          {int? personA,
          int? personB,
          int? relation,
          Value<RelationshipStatus?> relationshipStatus =
              const Value.absent()}) =>
      Relationship(
        personA: personA ?? this.personA,
        personB: personB ?? this.personB,
        relation: relation ?? this.relation,
        relationshipStatus: relationshipStatus.present
            ? relationshipStatus.value
            : this.relationshipStatus,
      );
  @override
  String toString() {
    return (StringBuffer('Relationship(')
          ..write('personA: $personA, ')
          ..write('personB: $personB, ')
          ..write('relation: $relation, ')
          ..write('relationshipStatus: $relationshipStatus')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(personA, personB, relation, relationshipStatus);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Relationship &&
          other.personA == this.personA &&
          other.personB == this.personB &&
          other.relation == this.relation &&
          other.relationshipStatus == this.relationshipStatus);
}

class RelationshipTableCompanion extends UpdateCompanion<Relationship> {
  final Value<int> personA;
  final Value<int> personB;
  final Value<int> relation;
  final Value<RelationshipStatus?> relationshipStatus;
  final Value<int> rowid;
  const RelationshipTableCompanion({
    this.personA = const Value.absent(),
    this.personB = const Value.absent(),
    this.relation = const Value.absent(),
    this.relationshipStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationshipTableCompanion.insert({
    required int personA,
    required int personB,
    required int relation,
    this.relationshipStatus = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : personA = Value(personA),
        personB = Value(personB),
        relation = Value(relation);
  static Insertable<Relationship> custom({
    Expression<int>? personA,
    Expression<int>? personB,
    Expression<int>? relation,
    Expression<int>? relationshipStatus,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (personA != null) 'person_a': personA,
      if (personB != null) 'person_b': personB,
      if (relation != null) 'relation': relation,
      if (relationshipStatus != null) 'relationship_status': relationshipStatus,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationshipTableCompanion copyWith(
      {Value<int>? personA,
      Value<int>? personB,
      Value<int>? relation,
      Value<RelationshipStatus?>? relationshipStatus,
      Value<int>? rowid}) {
    return RelationshipTableCompanion(
      personA: personA ?? this.personA,
      personB: personB ?? this.personB,
      relation: relation ?? this.relation,
      relationshipStatus: relationshipStatus ?? this.relationshipStatus,
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
    if (relationshipStatus.present) {
      map['relationship_status'] = Variable<int>($RelationshipTableTable
          .$converterrelationshipStatusn
          .toSql(relationshipStatus.value));
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
          ..write('relationshipStatus: $relationshipStatus, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RelationTypeWithGendersTable extends RelationTypeWithGenders
    with TableInfo<$RelationTypeWithGendersTable, RelationTypeWithGender> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RelationTypeWithGendersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _groupIDMeta =
      const VerificationMeta('groupID');
  @override
  late final GeneratedColumn<int> groupID = GeneratedColumn<int>(
      'group_i_d', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES relation_types (group_i_d)'));
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumnWithTypeConverter<Gender, int> gender =
      GeneratedColumn<int>('gender', aliasedName, false,
              type: DriftSqlType.int, requiredDuringInsert: true)
          .withConverter<Gender>(
              $RelationTypeWithGendersTable.$convertergender);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
      'label', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [groupID, gender, label];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'relation_type_with_genders';
  @override
  VerificationContext validateIntegrity(
      Insertable<RelationTypeWithGender> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('group_i_d')) {
      context.handle(_groupIDMeta,
          groupID.isAcceptableOrUnknown(data['group_i_d']!, _groupIDMeta));
    } else if (isInserting) {
      context.missing(_groupIDMeta);
    }
    context.handle(_genderMeta, const VerificationResult.success());
    if (data.containsKey('label')) {
      context.handle(
          _labelMeta, label.isAcceptableOrUnknown(data['label']!, _labelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  RelationTypeWithGender map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RelationTypeWithGender(
      groupID: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}group_i_d'])!,
      gender: $RelationTypeWithGendersTable.$convertergender.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.int, data['${effectivePrefix}gender'])!),
      label: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}label']),
    );
  }

  @override
  $RelationTypeWithGendersTable createAlias(String alias) {
    return $RelationTypeWithGendersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Gender, int, int> $convertergender =
      const EnumIndexConverter<Gender>(Gender.values);
}

class RelationTypeWithGender extends DataClass
    implements Insertable<RelationTypeWithGender> {
  final int groupID;
  final Gender gender;
  final String? label;
  const RelationTypeWithGender(
      {required this.groupID, required this.gender, this.label});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['group_i_d'] = Variable<int>(groupID);
    {
      map['gender'] = Variable<int>(
          $RelationTypeWithGendersTable.$convertergender.toSql(gender));
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    return map;
  }

  RelationTypeWithGendersCompanion toCompanion(bool nullToAbsent) {
    return RelationTypeWithGendersCompanion(
      groupID: Value(groupID),
      gender: Value(gender),
      label:
          label == null && nullToAbsent ? const Value.absent() : Value(label),
    );
  }

  factory RelationTypeWithGender.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RelationTypeWithGender(
      groupID: serializer.fromJson<int>(json['groupID']),
      gender: $RelationTypeWithGendersTable.$convertergender
          .fromJson(serializer.fromJson<int>(json['gender'])),
      label: serializer.fromJson<String?>(json['label']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'groupID': serializer.toJson<int>(groupID),
      'gender': serializer.toJson<int>(
          $RelationTypeWithGendersTable.$convertergender.toJson(gender)),
      'label': serializer.toJson<String?>(label),
    };
  }

  RelationTypeWithGender copyWith(
          {int? groupID,
          Gender? gender,
          Value<String?> label = const Value.absent()}) =>
      RelationTypeWithGender(
        groupID: groupID ?? this.groupID,
        gender: gender ?? this.gender,
        label: label.present ? label.value : this.label,
      );
  @override
  String toString() {
    return (StringBuffer('RelationTypeWithGender(')
          ..write('groupID: $groupID, ')
          ..write('gender: $gender, ')
          ..write('label: $label')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(groupID, gender, label);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RelationTypeWithGender &&
          other.groupID == this.groupID &&
          other.gender == this.gender &&
          other.label == this.label);
}

class RelationTypeWithGendersCompanion
    extends UpdateCompanion<RelationTypeWithGender> {
  final Value<int> groupID;
  final Value<Gender> gender;
  final Value<String?> label;
  final Value<int> rowid;
  const RelationTypeWithGendersCompanion({
    this.groupID = const Value.absent(),
    this.gender = const Value.absent(),
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RelationTypeWithGendersCompanion.insert({
    required int groupID,
    required Gender gender,
    this.label = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : groupID = Value(groupID),
        gender = Value(gender);
  static Insertable<RelationTypeWithGender> custom({
    Expression<int>? groupID,
    Expression<int>? gender,
    Expression<String>? label,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (groupID != null) 'group_i_d': groupID,
      if (gender != null) 'gender': gender,
      if (label != null) 'label': label,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RelationTypeWithGendersCompanion copyWith(
      {Value<int>? groupID,
      Value<Gender>? gender,
      Value<String?>? label,
      Value<int>? rowid}) {
    return RelationTypeWithGendersCompanion(
      groupID: groupID ?? this.groupID,
      gender: gender ?? this.gender,
      label: label ?? this.label,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (groupID.present) {
      map['group_i_d'] = Variable<int>(groupID.value);
    }
    if (gender.present) {
      map['gender'] = Variable<int>(
          $RelationTypeWithGendersTable.$convertergender.toSql(gender.value));
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RelationTypeWithGendersCompanion(')
          ..write('groupID: $groupID, ')
          ..write('gender: $gender, ')
          ..write('label: $label, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PersonsTable persons = $PersonsTable(this);
  late final $RelationTypesTable relationTypes = $RelationTypesTable(this);
  late final $RelationshipTableTable relationshipTable =
      $RelationshipTableTable(this);
  late final $RelationTypeWithGendersTable relationTypeWithGenders =
      $RelationTypeWithGendersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [persons, relationTypes, relationshipTable, relationTypeWithGenders];
}

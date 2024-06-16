import 'dart:ui';

import 'package:drift/drift.dart';

// These additional imports are necessary to open the sqlite3 database
import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';

@DataClassName("Person")
class Persons extends Table {
  IntColumn get uuid => integer().autoIncrement()();

  TextColumn get firstName => text()();

  TextColumn get lastName => text()();

  IntColumn get gender => intEnum<Gender>()(); // TODO with default
}

class ColorConverter extends TypeConverter<Color, int> {
  const ColorConverter();

  @override
  Color fromSql(int fromDb) => Color(fromDb);

  @override
  int toSql(Color value) => value.value;
}

enum Gender {
  male("male", "Male"),
  female("female", "Female"),
  genderNeutral("gender_neutral", "Gender-neutral");

  const Gender(this.key, this.label);

  final String key;
  final String label;
}

// class Gender extends Table {
//   IntColumn get id => integer().autoIncrement()();
//   TextColumn get description => text()();
// }

String fullName(Person person) {
  final firstName = person.firstName;
  final lastName = person.lastName;
  return '$firstName $lastName';
}

@DataClassName('Relationship')
class RelationshipTable extends Table {
  IntColumn get personA => integer().references(Persons, #uuid)();

  IntColumn get personB => integer().references(Persons, #uuid)();

  IntColumn get relation => integer().references(RelationTypes, #id)();
}

@DataClassName("RelationType")
class RelationTypes extends Table {
  @override
  List<Set<Column>> get uniqueKeys => [
        {gender, groupID},
        {id}
      ];

  IntColumn get id => integer().autoIncrement()();

  IntColumn get gender => intEnum<Gender>()();

  TextColumn get label => text().unique().nullable()();

  IntColumn get groupID => integer().nullable()();

  // We can use type converters to store custom classes in tables.
  // Here, we're storing colors as integers.
  IntColumn get color => integer().map(const ColorConverter()).nullable()();
}

@DriftDatabase(tables: [Persons, RelationshipTable, RelationTypes])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Person>> get allPersons => select(persons).get();

  Future<List<RelationType>> get allRelationTypes =>
      select(relationTypes).get();

  Future<List<Relationship>> relationsOf(int personId) {
    return (select(relationshipTable)..where((t) => t.personA.equals(personId)))
        .get();
  }

  Future<Person> personByID(int personId) {
    // TODO Check that really only one person exists
    return (select(persons)..where((tbl) => tbl.uuid.equals(personId)))
        .getSingle();
  }

  Future<RelationType> relationByID(int relationID) {
    return (select(relationTypes)..where((tbl) => tbl.id.equals(relationID)))
        .getSingle();
  }

  // returns the generated id
  Future<int> addRelationship(RelationshipTableCompanion entry) {
    return into(relationshipTable).insert(entry);
  }

  Future deleteRelationship(Relationship relationshipToDelete) {
    return (delete(relationshipTable)
          ..where((t) =>
              t.personA.equals(relationshipToDelete.personA) &
              t.personB.equals(relationshipToDelete.personB) &
              t.relation.equals(relationshipToDelete.relation)))
        .go();
  }

  // returns the generated id
  Future<int> addPerson(PersonsCompanion entry) {
    return into(persons).insert(entry);
  }

  Future updatePerson(Person entry) {
    // using replace will update all fields from the entry that are not marked as a primary key.
    // it will also make sure that only the entry with the same primary key will be updated.
    // Here, this means that the row that has the same id as entry will be updated to reflect
    // the entry's title, content and category. As its where clause is set automatically, it
    // cannot be used together with where.
    return update(persons).replace(entry);
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(onCreate: (m) async {
      await m.createAll(); // create all tables
      await batch((batch) {
        batch.insertAll(relationTypes, [
          RelationTypesCompanion.insert(
              gender: Gender.genderNeutral,
              label: const Value("Parent's sibling"),
              groupID: const Value(1)),
          RelationTypesCompanion.insert(
              gender: Gender.male,
              label: const Value("Uncle"),
              groupID: const Value(1)),
          RelationTypesCompanion.insert(
              gender: Gender.female,
              label: const Value("Aunt"),
              groupID: const Value(1)),
          RelationTypesCompanion.insert(
              gender: Gender.genderNeutral,
              label: const Value("Sibling"),
              groupID: const Value(2)),
          RelationTypesCompanion.insert(
              gender: Gender.male,
              label: const Value("Brother"),
              groupID: const Value(2)),
          RelationTypesCompanion.insert(
              gender: Gender.female,
              label: const Value("Sister"),
              groupID: const Value(2)),
          RelationTypesCompanion.insert(
              gender: Gender.genderNeutral,
              label: const Value("Child"),
              groupID: const Value(3)),
          RelationTypesCompanion.insert(
              gender: Gender.female,
              label: const Value("Daughter"),
              groupID: const Value(3)),
          RelationTypesCompanion.insert(
              gender: Gender.male,
              label: const Value("Son"),
              groupID: const Value(3)),
          RelationTypesCompanion.insert(
              gender: Gender.genderNeutral,
              label: const Value("Parent"),
              groupID: const Value(4)),
          RelationTypesCompanion.insert(
              gender: Gender.female,
              label: const Value("Mother"),
              groupID: const Value(4)),
          RelationTypesCompanion.insert(
              gender: Gender.male,
              label: const Value("Father"),
              groupID: const Value(4)),
        ]);
      });
    }, beforeOpen: (details) async {
      // Make sure that foreign keys are enabled
      await customStatement('PRAGMA foreign_keys = ON');
    });
  }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));

    // Also work around limitations on old Android versions
    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    // Make sqlite3 pick a more suitable location for temporary files - the
    // one from the system may be inaccessible due to sandboxing.
    final cachebase = (await getTemporaryDirectory()).path;
    // We can't access /tmp on Android, which sqlite3 would try by default.
    // Explicitly tell it about the correct temporary directory.
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}

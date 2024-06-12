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

@DataClassName('Relationship')
class RelationshipTable extends Table {
  IntColumn get personA => integer().references(Persons, #uuid)();

  IntColumn get personB => integer().references(Persons, #uuid)();

  IntColumn get relation => integer().references(RelationTable, #id)();
}

@DataClassName("Relation")
class RelationTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get gender => intEnum<Gender>()();

  TextColumn get label => text().unique().nullable()();

  IntColumn get baseRelation =>
      integer().references(RelationTable, #id).nullable()();

  // We can use type converters to store custom classes in tables.
  // Here, we're storing colors as integers.
  IntColumn get color => integer().map(const ColorConverter()).nullable()();
}

@DriftDatabase(tables: [Persons, RelationshipTable, RelationTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Person>> get allPersons => select(persons).get();

  Future<List<Relation>> get allRelationTypes => select(relationTable).get();

  Future<List<Relationship>> relationsOf(int personId) {
    return (select(relationshipTable)..where((t) => t.personA.equals(personId)))
        .get();
  }

  Future<Person> personByID(int personId) {
    // TODO Check that really only one person exists
    return (select(persons)..where((tbl) => tbl.uuid.equals(personId)))
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
      await into(relationTable).insert(const RelationTableCompanion(
          gender: Value(Gender.male),
          label: Value("Uncle"))); // insert on first run.
    }, beforeOpen: (details) async {
      // Make sure that foreign keys are enabled
      await customStatement('PRAGMA foreign_keys = ON');

      // TODO default werte erstellen
      // if (details.wasCreated) {
      //   // Create a bunch of default values so the app doesn't look too empty
      //   // on the first start.
      //   await batch((b) {
      //     b.insert(
      //       categories,
      //       CategoriesCompanion.insert(name: 'Important', color: Colors.red),
      //     );
      //
      //     b.insertAll(todoEntries, [
      //       TodoEntriesCompanion.insert(description: 'Check out drift'),
      //       TodoEntriesCompanion.insert(
      //           description: 'Fix session invalidation bug',
      //           category: const Value(1)),
      //       TodoEntriesCompanion.insert(
      //           description: 'Add favorite movies to home page'),
      //     ]);
      //   });
      // }
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

import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'database.dart';

void main() {
  runApp(
    Provider<AppDatabase>(
      create: (context) => AppDatabase(),
      dispose: (context, db) => db.close(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        title: 'Passing Data',
        home: const PersonOverview(),
      ),
    ),
  );
}

class PersonOverview extends StatefulWidget {
  const PersonOverview({super.key});

  @override
  PersonOverviewState createState() => PersonOverviewState();
}

class PersonOverviewState extends State<PersonOverview> {
  @override
  void initState() {
    super.initState();
  }

  Widget buildListView(persons) {
    return FutureBuilder<List<Person>>(
        future: persons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(fullName(snapshot.data![index])),
                  onLongPress: () async {
                    var personToEdit = snapshot.data![index];
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddUpdatePersonPage(person: personToEdit)),
                    );
                    if (result != null) snapshot.data![index] = result;
                    setState(() {});
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailScreen(
                          person: snapshot.data![index],
                        ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Text("Enter first person");
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    var persons = Provider.of<AppDatabase>(context).allPersons;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
      body: buildListView(persons),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUpdatePersonPage(),
            ),
          );
          setState(() {});
        },
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final Person person;

  const DetailScreen({super.key, required this.person});

  @override
  DetailScreenState createState() => DetailScreenState();
}

class DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    super.initState();
    person = widget.person;
  }

  // Declare a field that holds the Person.
  late Person person;
  List<Relationship> allRelations = [];

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    db.relationsOf(person.uuid).then((value) => setState(() {
          allRelations = value;
        }));
    // Use the Person to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(fullName(person)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(fullName(person)),
            Text(person.gender.label),
            Text(person.description ?? ""),
            Expanded(child: buildListView(allRelations)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push<Relationship>(
            context,
            MaterialPageRoute(
              builder: (context) => AddRelationship(currentPerson: person),
            ),
          );
          if (result != null) {
            db.addRelationship(result.toCompanion(true));
          }
          setState(() {});
        },
      ),
    );
  }

  Widget buildListView(relationships) {
    final db = Provider.of<AppDatabase>(context);
    return ListView.builder(
      itemCount: relationships.length,
      itemBuilder: (context, index) => ListTile(
        leading: const Icon(Icons.supervisor_account),
        title: FutureBuilder<String>(
            future: relationNameBuild(relationships[index]),
            builder: (context2, snapshot2) {
              if (snapshot2.hasData) {
                return Text(snapshot2.data!);
              } else {
                return const Text("");
              }
            }),
        trailing: IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: () {
            // snapshot.data!.remove(snapshot.data![index]);
            db.deleteRelationship(relationships[index]);
            setState(() {});
          },
        ),
      ),
    );
  }

  Future<String> relationNameBuild(Relationship r) async {
    final db = Provider.of<AppDatabase>(context);
    final Person personA = await db.personByID(r.personA);
    final Person personB = await db.personByID(r.personB);

    final RelationTypeWithGender relation =
        await db.relationByGroupIDAndGender(r.relation, personA.gender);
    final String relationLabel = relation.label ?? "not associated";
    final String relationshipStatusLabel = r.relationshipStatus?.label ?? "";
    return '${personA.firstName} is $relationshipStatusLabel $relationLabel of ${fullName(personB)}';
  }
}

class AddUpdatePersonPage extends StatefulWidget {
  final Person? person;

  const AddUpdatePersonPage({super.key, this.person});

  @override
  AddUpdatePersonPageState createState() => AddUpdatePersonPageState();
}

class AddUpdatePersonPageState extends State<AddUpdatePersonPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final descriptionController = TextEditingController();

  bool isUpdate = false;
  Gender? selectedGender;

  @override
  void initState() {
    super.initState();

    isUpdate = widget.person?.uuid != null;
    firstNameController.text = widget.person?.firstName ?? "";
    lastNameController.text = widget.person?.lastName ?? "";
    descriptionController.text = widget.person?.description ?? "";
    selectedGender = widget.person?.gender ?? Gender.genderNeutral;
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.toString()),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              onChanged: () {},
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: const InputDecoration(hintText: 'First Name'),
                    controller: firstNameController,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Last Name'),
                    controller: lastNameController,
                  ),
                  DropdownButton<Gender>(
                    value: selectedGender,
                    onChanged: (Gender? gender) {
                      setState(() {
                        selectedGender = gender;
                      });
                    },
                    items: Gender.values.map((Gender gender) {
                      return DropdownMenuItem<Gender>(
                          value: gender, child: Text(gender.label));
                    }).toList(),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: "Description"),
                    controller: descriptionController,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        if (isUpdate) {
                          final p = Person(
                            uuid: widget.person!.uuid,
                            gender: selectedGender ?? Gender.genderNeutral,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            description: descriptionController.text,
                          );
                          db.updatePerson(p);
                          Navigator.pop(context, p);
                        } else {
                          final p = PersonsCompanion(
                            gender: drift.Value(
                                selectedGender ?? Gender.genderNeutral),
                            firstName: drift.Value(firstNameController.text),
                            lastName: drift.Value(lastNameController.text),
                          );
                          db.addPerson(p);
                          Navigator.pop(context, p);
                        }
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddRelationship extends StatefulWidget {
  final Person currentPerson;

  const AddRelationship({super.key, required this.currentPerson});

  @override
  State<AddRelationship> createState() => _AddRelationshipState();
}

class _AddRelationshipState extends State<AddRelationship> {
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController personController = TextEditingController();
  RelationTypeWithGender? selectedRelation;
  Person? selectedPerson;
  RelationshipStatus? selectedRelationshipStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<AppDatabase>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Relationship for ${fullName(widget.currentPerson)}"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${widget.currentPerson.firstName} is"),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(
                      future: db.allRelationTypesForGender(
                          widget.currentPerson.gender),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return DropdownMenu<RelationTypeWithGender>(
                            controller: relationshipController,
                            // requestFocusOnTap is enabled/disabled by platforms when it is null.
                            // On mobile platforms, this is false by default. Setting this to true will
                            // trigger focus request on the text field and virtual keyboard will appear
                            // afterward. On desktop platforms however, this defaults to true.
                            requestFocusOnTap: true,
                            label: const Text('Relation'),
                            onSelected: (RelationTypeWithGender? relation) {
                              setState(() {
                                selectedRelation = relation;
                              });
                            },
                            dropdownMenuEntries: snapshot.data!
                                .map<DropdownMenuEntry<RelationTypeWithGender>>(
                                    (RelationTypeWithGender relation) {
                              return DropdownMenuEntry<RelationTypeWithGender>(
                                value: relation,
                                label: relation.label ?? "no label",
                                enabled: relation.label != '',
                                // TODO
                                // style: MenuItemButton.styleFrom(
                                //   foregroundColor: relation.color,
                                // ),
                              );
                            }).toList(),
                          );
                        } else {
                          return const Text("No Data here");
                        }
                      }),
                  const SizedBox(width: 20),
                  const Text(" of "),
                  const SizedBox(
                    width: 20,
                  ),
                  FutureBuilder(
                    future: db.allPersons,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DropdownMenu<Person>(
                          controller: personController,
                          enableFilter: true,
                          requestFocusOnTap: true,
                          leadingIcon: const Icon(Icons.search),
                          label: const Text('Person'),
                          inputDecorationTheme: const InputDecorationTheme(
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 5.0),
                          ),
                          onSelected: (Person? person) {
                            setState(() {
                              selectedPerson = person;
                            });
                          },
                          dropdownMenuEntries:
                              snapshot.data!.map<DropdownMenuEntry<Person>>(
                            (Person person) {
                              return DropdownMenuEntry<Person>(
                                value: person,
                                label: fullName(person),
                              );
                            },
                          ).toList(),
                        );
                      } else {
                        return const Text("No Data here");
                      }
                    },
                  ),
                ],
              ),
            ),
            DropdownButton<RelationshipStatus>(
              value: selectedRelationshipStatus,
              onChanged: (RelationshipStatus? relationshipStatus) {
                setState(() {
                  selectedRelationshipStatus = relationshipStatus;
                });
              },
              items: RelationshipStatus.values
                  .map((RelationshipStatus relationshipStatus) {
                return DropdownMenuItem<RelationshipStatus>(
                    value: relationshipStatus,
                    child: Text(relationshipStatus.label));
              }).toList(),
            ),
            if (selectedRelation == null || selectedPerson == null)
              const Text('Please select a relation and a person.'),
            ElevatedButton(
              onPressed: (selectedRelation == null || selectedPerson == null)
                  ? null
                  : () {
                      // Validate returns true if the form is valid, or false otherwise.
                      final r = Relationship(
                          personA: widget.currentPerson.uuid,
                          personB: selectedPerson!.uuid,
                          relation: selectedRelation!.groupID,
                          relationshipStatus: selectedRelationshipStatus);
                      Navigator.pop(context, r);
                    },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

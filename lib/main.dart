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
        home: const PersonOverview(
          // persons: List.generate(
          //   5,
          //       (i) =>
          //       Person(
          //         uuid: i.toString(),
          //         firstName: 'Person $i',
          //         description: 'A description of Person $i',
          //       ),
          // ),
        ),
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
                  title: Text(snapshot.data![index].toString()),
                  onLongPress: () async {
                    var personToEdit = snapshot.data![index];
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddUpdatePersonPage(person: personToEdit)),
                    );
                    // var result = await _navigateAndDisplaySelection(context, persons[index]);
                    if (result != null) snapshot.data![index] = result;
                    setState(() {});
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailScreen(
                              person: snapshot.data![index],
                            ),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        }
    );
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
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddUpdatePersonPage(),
            ),
          );
          // var result = await _navigateAndDisplaySelection(context, persons[index]);
          // if (result != null) persons.add(result); TODO
          setState(() {});
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Person.
  const DetailScreen(
      {super.key, required this.person});

  // Declare a field that holds the Person.
  final Person person;

  @override
  Widget build(BuildContext context) {
    var allRelations = Provider.of<AppDatabase>(context).relationsOf(person.uuid);


    // Use the Person to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(person.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(person.toString()),
            Text(person.gender.toString()),
            Expanded(
              child: buildListView(allRelations)
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: const Icon(Icons.add),
      //   onPressed: () async {
      //     final result = await Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) =>
      //             AddRelationship(currentPerson: person, persons: otherPersons),
      //       ),
      //     );
      //     // allRelations.add(result); TODO
      //   },
      // ),
    );
  }

  Widget buildListView(relationships) {
    return FutureBuilder<List<Relationship>>(
        future: relationships,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: relationships.length,
              itemBuilder: (context, index) =>
                  ListTile(
                    leading: const Icon(Icons.supervisor_account),
                    title: Text(relationships[index].toString()),
                    trailing: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: () {
                        relationships.remove(relationships[index]);
                      },
                    ),
                  ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }


    }
    );
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


  bool isUpdate = false;
  Gender? selectedGender;

  @override
  void initState() {
    super.initState();

    isUpdate = widget.person?.uuid != null;
    firstNameController.text = widget.person?.firstName ?? "";
    lastNameController.text = widget.person?.lastName ?? "";
    // selectedGender = widget.person?.gender ?? Gender(; // TODO
  }


  @override
  Widget build(BuildContext context) {
    var db = Provider.of<AppDatabase>(context);
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
                            value: gender,
                            child: Text(gender.label));
                      }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        if (isUpdate) {
                          final p = Person(
                            uuid:  widget.person!.uuid,
                            gender: selectedGender ?? Gender.genderNeutral,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                          );
                          db.updatePerson(p);
                          Navigator.pop(context, p);
                        }
                        else {
                          final p = PersonsCompanion(
                            gender: drift.Value(selectedGender ?? Gender.genderNeutral),
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

// class AddRelationship extends StatefulWidget {
//   final Person currentPerson;
//   final List<Person> persons;
//
//   const AddRelationship(
//       {super.key, required this.currentPerson, required this.persons});
//
//   @override
//   State<AddRelationship> createState() => _AddRelationshipState();
// }
//
// class _AddRelationshipState extends State<AddRelationship> {
//   final TextEditingController relationshipController = TextEditingController();
//   final TextEditingController personController = TextEditingController();
//   Relation? selectedRelation;
//   Person? selectedPerson;
//   List<Person> persons = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     persons = widget.persons;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Update for ${widget.currentPerson.toString()}"),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("${widget.currentPerson.firstName} is"),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   DropdownMenu<Relation>(
//                     controller: relationshipController,
//                     // requestFocusOnTap is enabled/disabled by platforms when it is null.
//                     // On mobile platforms, this is false by default. Setting this to true will
//                     // trigger focus request on the text field and virtual keyboard will appear
//                     // afterward. On desktop platforms however, this defaults to true.
//                     requestFocusOnTap: true,
//                     label: const Text('Relation'),
//                     onSelected: (Relation? relation) {
//                       setState(() {
//                         selectedRelation = relation;
//                       });
//                     },
//                     dropdownMenuEntries: Relation.values
//                         .map<DropdownMenuEntry<Relation>>((Relation relation) {
//                       return DropdownMenuEntry<Relation>(
//                         value: relation,
//                         label: relation.label,
//                         enabled: relation.label != 'Grey',
//                         style: MenuItemButton.styleFrom(
//                           foregroundColor: relation.color,
//                         ),
//                       );
//                     }).toList(),
//                   ),
//                   const SizedBox(width: 20),
//                   const Text(" of "),
//                   const SizedBox(
//                     width: 20,
//                   ),
//                   DropdownMenu<Person>(
//                     controller: personController,
//                     enableFilter: true,
//                     requestFocusOnTap: true,
//                     leadingIcon: const Icon(Icons.search),
//                     label: const Text('Person'),
//                     inputDecorationTheme: const InputDecorationTheme(
//                       filled: true,
//                       contentPadding: EdgeInsets.symmetric(vertical: 5.0),
//                     ),
//                     onSelected: (Person? person) {
//                       setState(() {
//                         selectedPerson = person;
//                       });
//                     },
//                     dropdownMenuEntries: persons.map<DropdownMenuEntry<Person>>(
//                           (Person icon) {
//                         return DropdownMenuEntry<Person>(
//                           value: icon,
//                           label: icon.fullName(),
//                         );
//                       },
//                     ).toList(),
//                   ),
//                 ],
//               ),
//             ),
//             if (selectedRelation == null || selectedPerson == null)
//               const Text('Please select a relation and a person.'),
//             ElevatedButton(
//               onPressed: (selectedRelation == null || selectedPerson == null)
//                   ? null
//                   : () {
//                 // Validate returns true if the form is valid, or false otherwise.
//                 final r = Relationship(
//                     personA: widget.currentPerson,
//                     personB: selectedPerson!,
//                     relation: selectedRelation!);
//                 Navigator.pop(context, r);
//               },
//               child: const Text('Submit'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

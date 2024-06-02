import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/persons.dart';
import 'models/relationship.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Relationships(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.green,
        ),
        title: 'Passing Data',
        home: PersonOverview(
          persons: List.generate(
            5,
            (i) => Person(
              firstName: 'Person $i',
              description: 'A description of Person $i',
            ),
          ),
        ),
      ),
    ),
  );
}

class PersonOverview extends StatefulWidget {
  final List<Person> persons;

  const PersonOverview({super.key, required this.persons});

  @override
  PersonOverviewState createState() => PersonOverviewState();
}

class PersonOverviewState extends State<PersonOverview> {
  List<Person> persons = [];

  @override
  void initState() {
    super.initState();

    persons = widget.persons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Persons'),
      ),
      body: ListView.builder(
        itemCount: persons.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(persons[index].fullName()),
            onLongPress: () async {
              var personToEdit = persons[index];
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        AddUpdatePersonPage(person: personToEdit)),
              );
              // var result = await _navigateAndDisplaySelection(context, persons[index]);
              if (result != null) persons[index] = result;
              setState(() {});
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(
                    person: persons[index],
                    otherPersons: persons,
                  ),
                ),
              );
            },
          );
        },
      ),
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
          if (result != null) persons.add(result);
          setState(() {});
        },
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  // In the constructor, require a Person.
  const DetailScreen(
      {super.key, required this.person, required this.otherPersons});

  // Declare a field that holds the Person.
  final Person person;
  final List<Person> otherPersons;

  @override
  Widget build(BuildContext context) {
    var relationships = context.watch<Relationships>();

    var allRelations = relationships.relationsOf(person);

    // Use the Person to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(person.fullName()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(person.description),
            Expanded(
              child: ListView.builder(
                itemCount: allRelations.length,
                itemBuilder: (context, index) => ListTile(
                  leading: const Icon(Icons.person_2_outlined),
                  title: Text(allRelations[index].toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      relationships.remove(allRelations[index]);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddRelationship(currentPerson: person, persons: otherPersons),
            ),
          );
          relationships.add(result);
        },
      ),
    );
  }
}

class AddUpdatePersonPage extends StatefulWidget {
  final Person person;

  const AddUpdatePersonPage({super.key, this.person = const Person()});

  @override
  AddUpdatePersonPageState createState() => AddUpdatePersonPageState();
}

class AddUpdatePersonPageState extends State<AddUpdatePersonPage> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();

    isUpdate = widget.person.id != null;
    firstNameController.text = widget.person.firstName;
    lastNameController.text = widget.person.lastName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.fullName()),
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
                  ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        final p = Person(
                            id: widget.person.id,
                            firstName: firstNameController.text,
                            lastName: lastNameController.text);
                        Navigator.pop(context, p);
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
  final List<Person> persons;

  const AddRelationship(
      {super.key, required this.currentPerson, required this.persons});

  @override
  State<AddRelationship> createState() => _AddRelationshipState();
}

class _AddRelationshipState extends State<AddRelationship> {
  final TextEditingController relationshipController = TextEditingController();
  final TextEditingController personController = TextEditingController();
  Relation? selectedRelation;
  Person? selectedPerson;
  List<Person> persons = [];

  @override
  void initState() {
    super.initState();

    persons = widget.persons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Update for ${widget.currentPerson.fullName()}"),
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
                  DropdownMenu<Relation>(
                    initialSelection: Relation.uncle,
                    controller: relationshipController,
                    // requestFocusOnTap is enabled/disabled by platforms when it is null.
                    // On mobile platforms, this is false by default. Setting this to true will
                    // trigger focus request on the text field and virtual keyboard will appear
                    // afterward. On desktop platforms however, this defaults to true.
                    requestFocusOnTap: true,
                    label: const Text('Relation'),
                    onSelected: (Relation? relation) {
                      setState(() {
                        selectedRelation = relation;
                      });
                    },
                    dropdownMenuEntries: Relation.values
                        .map<DropdownMenuEntry<Relation>>((Relation relation) {
                      return DropdownMenuEntry<Relation>(
                        value: relation,
                        label: relation.label,
                        enabled: relation.label != 'Grey',
                        style: MenuItemButton.styleFrom(
                          foregroundColor: relation.color,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(width: 20),
                  const Text(" of "),
                  const SizedBox(
                    width: 20,
                  ),
                  DropdownMenu<Person>(
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
                    dropdownMenuEntries: persons.map<DropdownMenuEntry<Person>>(
                      (Person icon) {
                        return DropdownMenuEntry<Person>(
                          value: icon,
                          label: icon.fullName(),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            if (selectedRelation == null || selectedPerson == null)
              const Text('Please select a relation and a person.'),
            ElevatedButton(
              onPressed: (selectedRelation == null || selectedPerson == null)
                  ? null
                  : () {
                      // Validate returns true if the form is valid, or false otherwise.
                      final r = Relationship(
                          personA: widget.currentPerson,
                          personB: selectedPerson!,
                          relation: selectedRelation!);
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

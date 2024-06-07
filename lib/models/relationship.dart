import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:whatshisname/models/persons.dart';

String commentMark(int mark) {
  String msg;
  switch (mark) {
    case 0: // Enter this block if mark == 0
      msg = "mark is 0";
    case 1:
    case 2:
    case 3: // Enter this block if mark == 1 or mark == 2 or mark == 3
      msg = "mark is either 1, 2 or 3";
    // etc.
    default:
      msg = "mark is not 0, 1, 2 or 3";
  }
  return msg;
}

class Relationship {
  final Person personA;
  final Person personB;
  final Relation relation;

  const Relationship(
      {required this.personA, required this.personB, required this.relation});

  @override
  String toString() {
    String df;
    switch (personB.gender) {
      case Gender.genderNeutral:
        df = relation.label;
      case Gender.male:
        df = relation.male;
      case Gender.female:
        df = relation.female;
    }
    return '${personA.firstName} is $df of ${personB.fullName()}';
  }
}

class Relationships extends ChangeNotifier {
  final List<Relationship> _relationships = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Relationship> get items =>
      UnmodifiableListView(_relationships);

  List<Relationship> relationsOf(Person person) {
    List<Relationship> l = [];
    for (final i in _relationships) {
      if (i.personA.id == person.id) {
        l.add(i);
      }
    }
    return l;
  }

  void add(Relationship relationship) {
    _relationships.add(relationship);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void remove(Relationship relationship) {
    _relationships.remove(relationship);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}

enum Relation {
  parentsSibling("Parent's sibling", Colors.redAccent, "Aunt", "Uncle"),
  sibling("Sibling", Colors.yellow, "Sister", "Brother"),
  neighbor('Neighbor', Colors.brown, "Neighbor", "Neighbor"),
  parent("Parent", Colors.indigo, "Mother", "Father"),
  cousin("Cousin", Colors.cyanAccent, "Cousin", "Cousin"),
  childOfSibling("Child of sibling", Colors.greenAccent, "Niece", "Nephew"),
  child("Child", Colors.deepPurpleAccent, "Daughter", "Son"),
  stepparent("Stepparent", Colors.black26, "Stepmother", "Stepfather");

  const Relation(this.label, this.color, this.female, this.male);

  final String label;
  final Color color;
  final String female;
  final String male;
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:whatshisname/models/persons.dart';

class Relationship {
  final Person personA;
  final Person personB;
  final Relation relation;

  const Relationship(
      {required this.personA, required this.personB, required this.relation});

  @override
  String toString() {
    return '${personA.firstName} is ${relation.label} of ${personB.fullName()}';
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
      if (i.personA == person) {
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
  uncle('Uncle', Colors.redAccent),
  aunt('Aunt', Colors.redAccent),
  sister('Sister', Colors.yellow),
  brother('Brother', Colors.yellow),
  neighbor('Neighbor', Colors.brown),
  mother("Mother", Colors.indigo),
  father("Father", Colors.indigo),
  parent("Parent", Colors.indigo),
  cousin("Cousin", Colors.cyanAccent),
  nephew("Nephew", Colors.greenAccent),
  niece("Niece", Colors.greenAccent),
  daughter("Daughter", Colors.deepPurpleAccent),
  son("Son", Colors.deepPurpleAccent),
  child("Child", Colors.deepPurpleAccent),
  stepfather("Stepfather", Colors.black26),
  stepmother("Stepmother", Colors.black26);

  const Relation(this.label, this.color);

  final String label;
  final Color color;
}

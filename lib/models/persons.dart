class Person {
  final int? id;
  final String firstName;
  final String lastName;
  final String description;
  final Gender gender;

  const Person(
      {this.id,
      this.firstName = '',
      this.lastName = '',
      this.description = '',
      this.gender = Gender.genderNeutral});

  @override
  String toString() {
    return '{$firstName $lastName}';
  }

  String fullName() {
    return '$firstName $lastName';
  }
}

enum Gender {
  male("Male"),
  female("Female"),
  genderNeutral("Gender-neutral");

  const Gender(this.label);

  final String label;
}

class Person {
  final int? id;
  final String firstName;
  final String lastName;
  final String description;

  const Person(
      {this.id,
        this.firstName = '',
        this.lastName = '',
        this.description = ''});

  @override
  String toString() {
    return '{$firstName $lastName}';
  }

  String fullName() {
    return '$firstName $lastName';
  }
}
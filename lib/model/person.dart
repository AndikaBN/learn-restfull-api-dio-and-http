// ignore_for_file: public_member_api_docs, sort_constructors_first
class Person {
  Person({
    required this.id,
    required this.name,
    required this.email,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json["id"],
      name: json["first_name"] + " " + json["last_name"],
      email: json["email"],
    );
  }

  final int id;
  final String name;
  final String email;
}

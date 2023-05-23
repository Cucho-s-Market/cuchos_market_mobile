import 'dart:ffi';

class User {
  final Long id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });
}

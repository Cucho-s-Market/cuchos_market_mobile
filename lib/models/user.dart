import 'dart:ffi';

class User {
  static final User _instance = User._internal();
  late Long id;
  late String firstName;
  late String lastName;
  late String email;
  late String password;

  factory User() {
    return _instance;
  }

  User._internal();
}

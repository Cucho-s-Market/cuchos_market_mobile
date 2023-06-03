class User {
  final String email;
  final String password;
  final String? firstName;
  final String? lastName;

  User({
    required this.email,
    required this.password,
    this.firstName,
    this.lastName,
  });

  factory User.fromJson({required Map<String, dynamic> json, required String email, required String password}) {
    return User(
      email: email,
      password: password,
      firstName: json["firstName"],
      lastName: json["lastName"],
    );
  }
}

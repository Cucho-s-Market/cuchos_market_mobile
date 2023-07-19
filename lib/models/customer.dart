class Customer {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime? birthdate;
  final int telephone;
  final int? dni;

  Customer({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    this.birthdate,
    required this.telephone,
    this.dni,
  });

  factory Customer.fromJson({required Map<String, dynamic> json, required String email, required String password}) {
    return Customer(
      email: email,
      password: password,
      firstName: json["firstName"],
      lastName: json["lastName"],
      birthdate: json["birthdate"] != null ? DateTime.parse(json["birthdate"]) : json["birthdate"],
      telephone: json["telephone"],
      dni: json["dni"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'birthdate': birthdate != null ? birthdate.toString().split(' ').first : '',
      'telephone': telephone,
      'dni': dni,
    };
  }
}

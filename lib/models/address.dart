class Address {
  final int id;
  final String address;
  final int doorNumber;
  final String location;
  final String state;

  Address({
    required this.id,
    required this.address,
    required this.doorNumber,
    required this.location,
    required this.state,
  });

  factory Address.fromJson({required Map<String, dynamic> json}) {
    return Address(
      id: json["id"],
      address: json["address"],
      doorNumber: json["doorNumber"],
      location: json["location"],
      state: json["state"],
    );
  }
}

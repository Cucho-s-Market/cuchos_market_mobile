import 'dart:ffi';

class Adress {
  final int id;
  final String address;
  final int doorNumber;
  final String location;
  final String state;

  Adress({
    required this.id,
    required this.address,
    required this.doorNumber,
    required this.location,
    required this.state,
  });
}

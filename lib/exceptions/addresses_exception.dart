class AddressesException implements Exception {
  final String message;

  AddressesException(this.message);

  @override
  String toString() {
    return message;
  }
}

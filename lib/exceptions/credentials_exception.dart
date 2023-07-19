class CredentialsException implements Exception {
  final String message;

  CredentialsException(this.message);

  @override
  String toString() {
    return message;
  }
}

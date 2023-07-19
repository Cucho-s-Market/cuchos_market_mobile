class BranchException implements Exception {
  final String message;

  BranchException(this.message);

  @override
  String toString() {
    return message;
  }
}

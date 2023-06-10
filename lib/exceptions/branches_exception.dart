class BranchesException implements Exception {
  final String message;

  BranchesException(this.message);

  @override
  String toString() {
    return message;
  }
}

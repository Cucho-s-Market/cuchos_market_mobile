class CategoryException implements Exception {
  final String message;

  CategoryException(this.message);

  @override
  String toString() {
    return message;
  }
}

class CategoriesException implements Exception {
  final String message;

  CategoriesException(this.message);

  @override
  String toString() {
    return message;
  }
}

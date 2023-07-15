class Product {
  final String name;
  final String description;
  final DateTime entryDate;
  final double price;
  final String brand;
  final int? categoryId;
  final List<dynamic> images;

  Product({
    required this.name,
    required this.description,
    required this.entryDate,
    required this.price,
    required this.brand,
    this.categoryId,
    required this.images,
  });

  factory Product.fromJson({required Map<String, dynamic> json}) {
    return Product(
      name: json["name"],
      description: json["description"],
      entryDate: DateTime.parse(json["entryDate"]),
      price: json["price"],
      brand: json["brand"],
      categoryId: json["categoryId"],
      images: json.containsKey("images") ? json["images"] : [],
    );
  }
}

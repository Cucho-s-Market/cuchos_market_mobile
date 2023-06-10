import 'package:cuchos_market_mobile/models/product.dart';

class Category {
  final int id;
  final String name;
  final String description;
  final int? parent;
  final String? image;
  final List<Category> subcategories = [];
  final Map<String, Product>? products = {};

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.parent,
    this.image,
  });

  factory Category.fromJson({required Map<String, dynamic> json}) {
    return Category(
      id: json["id"],
      name: json["name"],
      description: json["description"],
      parent: json["categoryParent"],
      image: json["image"],
    );
  }

  void addSubcategory(Category subCategory) {
    subcategories.add(subCategory);
  }
}

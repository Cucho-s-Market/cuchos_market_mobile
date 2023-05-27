import 'dart:ffi';

import 'package:cuchos_market_mobile/models/product.dart';

class Category {
  final Long id;
  final String name;
  final String description;
  final Category? parent;
  final List<Category>? subcategories;
  final Map<String, Product>? products;

  Category({
    required this.id,
    required this.name,
    required this.description,
    this.parent,
    this.subcategories,
    this.products,
  });
}

import 'dart:convert';

import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final DateTime entryDate;
  final double price;
  final String brand;
  final List<dynamic> images;

  Product({
    required this.name,
    required this.description,
    required this.entryDate,
    required this.price,
    required this.brand,
    required this.images,
  });

  factory Product.fromJson({required Map<String, dynamic> json}) {
    return Product(
      name: json["name"],
      description: json["description"],
      entryDate: DateTime.parse(json["entryDate"]),
      price: json["price"],
      brand: json["brand"],
      images: json["images"], //TODO: Controlar caso imagenes null
    );
  }
}

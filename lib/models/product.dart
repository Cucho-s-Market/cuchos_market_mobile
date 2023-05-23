import 'dart:ffi';

import 'package:flutter/material.dart';

class Product {
  final String name;
  final String description;
  final DateTime entryDate;
  final Float price;
  final String brand;
  final List<Image> images;

  Product({
    required this.name,
    required this.description,
    required this.entryDate,
    required this.price,
    required this.brand,
    required this.images,
  });
}

import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/categories_exception.dart';
import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/models/session.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Categories {
  static final Categories _instance = Categories._internal();
  final ValueNotifier<Map<int, Category>> categories = ValueNotifier<Map<int, Category>>({});

  factory Categories() {
    return _instance;
  }

  Categories._internal();

  Future<void> loadCategories() async {
    final Map<int, Category> newCategories = {};

    final Uri url = Uri.parse("http://localhost:8080/categories");
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${Session().token}',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body["error"] == true) throw CategoriesException(body["message"]);

        for (final Map<String, dynamic> categoryJson in body["data"]) {
          Category category = Category.fromJson(
            json: categoryJson,
          );

          if (category.parent == 0) {
            newCategories[category.id] = category;
          }
          //If category is a subcategory
          else if (newCategories.containsKey(category.parent)) {
            newCategories[category.parent]?.addSubcategory(category);
          }
        }
        break;
      case 403:
        throw CategoriesException("Forbidden: Error al obtener categorias.");
      default:
        throw CategoriesException("Respuesta ${response.statusCode} indeterminada.");
    }

    categories.value = newCategories;
  }
}

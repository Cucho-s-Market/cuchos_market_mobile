import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/category_exception.dart';
import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class CategoryController {
  static final CategoryController _instance = CategoryController._internal();
  final ValueNotifier<Map<int, Category>> categories = ValueNotifier<Map<int, Category>>({});

  factory CategoryController() {
    return _instance;
  }

  CategoryController._internal();

  Future<void> loadCategories() async {
    final Map<int, Category> newCategories = {};

    final Uri url = Uri.parse("https://cuchos-market-2023-34241c211eef.herokuapp.com/categories");
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw CategoryException(body["message"]);

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
        throw CategoryException("Forbidden: Error al obtener categorias.");
      default:
        throw CategoryException("Respuesta ${response.statusCode} indeterminada.");
    }

    categories.value = newCategories;
  }

  void addProductToCategory({required int categoryId, required Product product}) {
    Category category = categories.value.values.firstWhere((category) => category.subcategories.containsKey(categoryId));

    category.subcategories[categoryId]?.products[product.name] = product;
  }
}

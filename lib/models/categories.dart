import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/categories_exception.dart';
import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/models/session.dart';

import 'package:http/http.dart' as http;

class Categories {
  static final Categories _instance = Categories._internal();
  final Map<int, Category> _categories = {};

  factory Categories() {
    return _instance;
  }

  Categories._internal();

  Map<int, Category> get categories {
    return _categories;
  }

  Future<void> loadCategories() async {
    final Uri url = Uri.parse("http://localhost:8080/categories");
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${Session().token}',
    };

    final response = await http.get(url, headers: headers);

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body["error"] == true) throw CategoriesException(body["message"]);

        _categories.clear();

        for (final Map<String, dynamic> categoryJson in body["data"]) {
          Category category = Category.fromJson(
            json: categoryJson,
          );

          if (category.parent == 0) {
            _categories[category.id] = category;
          }
          //If category is a subcategory
          else if (_categories.containsKey(category.parent)) {
            _categories[category.parent]?.addSubcategory(category);
          }
        }
        break;
      case 403:
        throw CategoriesException("Forbidden: Error al obtener categorias.");
      default:
    }
  }
}

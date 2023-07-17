import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/product_exception.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/utilities/branch_controller.dart';
import 'package:cuchos_market_mobile/utilities/category_controller.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ProductController {
  static final ProductController _instance = ProductController._internal();
  final ValueNotifier<Map<String, Product>> products = ValueNotifier<Map<String, Product>>({});
  final BranchController branchController = BranchController();
  final CategoryController categoryController = CategoryController();

  factory ProductController() {
    return _instance;
  }

  ProductController._internal();

  Future<void> loadProducts({int? categoryId}) async {
    //TODO: Obtener stock producto
    final Map<String, String> parameters = {};
    final Map<String, Product> newProducts = {};

    parameters['branch_id'] = branchController.selectedBranch.value.id.toString();
    if (categoryId != null) parameters['category_id'] = categoryId.toString();

    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/products',
      queryParameters: parameters,
    );

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

        if (body["error"] == true) throw ProductException(body["message"]);

        for (final Map<String, dynamic> productJson in body["data"]["content"]) {
          Product product = Product.fromJson(json: productJson);

          newProducts[product.name] = product;
          categoryController.addProductToCategory(categoryId: product.categoryId!, product: product);
        }

        break;

      case 403:
        throw ProductException("Forbidden: Error al obtener productos.");
      default:
        throw ProductException("Respuesta ${response.statusCode} indeterminada.");
    }

    products.value = newProducts;
  }
}

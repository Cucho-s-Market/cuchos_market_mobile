import 'dart:ffi';

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/pages/product_page.dart';
import 'package:cuchos_market_mobile/utilities/product_controller.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Product> filteredProducts = [];

  List<Product> products = ProductController().products.value.values.toList();

  void search(String query) {
    setState(
      () {
        filteredProducts.clear();
        if (query.isNotEmpty) {
          for (Product product in products) {
            if (product.name.toLowerCase().contains(query.toLowerCase()) |
                product.brand.toLowerCase().contains(query.toLowerCase()) |
                product.description.toLowerCase().contains(query.toLowerCase())) filteredProducts.add(product);
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _searchController,
                onChanged: search,
                decoration: InputDecoration(
                  label: const Text("Buscar"),
                  border: const OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ),
            Flexible(
              fit: FlexFit.tight,
              child: ListView.builder(
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductPage(
                        product: filteredProducts.elementAt(index),
                      ),
                    ),
                  ),
                  title: Text(
                    filteredProducts[index].name,
                    style: const TextStyle(fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

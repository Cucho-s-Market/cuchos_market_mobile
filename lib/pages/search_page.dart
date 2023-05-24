import 'dart:ffi';

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<Product> filteredProducts = [];

  //TODO: Implementar logica para obtener productos
  List<Product> products = [
    Product(
      name: 'test1',
      description: 'test1',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test1',
      images: [],
    ),
    Product(
      name: 'test2',
      description: 'test2',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test2',
      images: [],
    ),
    Product(
      name: 'test3',
      description: 'test3',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test3',
      images: [],
    ),
    Product(
      name: 'test4',
      description: 'test4',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test4',
      images: [],
    ),
    Product(
      name: 'test1',
      description: 'test1',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test1',
      images: [],
    ),
    Product(
      name: 'test2',
      description: 'test2',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test2',
      images: [],
    ),
    Product(
      name: 'test3',
      description: 'test3',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test3',
      images: [],
    ),
    Product(
      name: 'test4',
      description: 'test4',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test4',
      images: [],
    ),
    Product(
      name: 'test1',
      description: 'test1',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test1',
      images: [],
    ),
    Product(
      name: 'test2',
      description: 'test2',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test2',
      images: [],
    ),
    Product(
      name: 'test3',
      description: 'test3',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test3',
      images: [],
    ),
    Product(
      name: 'test4',
      description: 'test4',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test4',
      images: [],
    ),
    Product(
      name: 'test1',
      description: 'test1',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test1',
      images: [],
    ),
    Product(
      name: 'test2',
      description: 'test2',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test2',
      images: [],
    ),
    Product(
      name: 'test3',
      description: 'test3',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test3',
      images: [],
    ),
    Product(
      name: 'test4',
      description: 'test4',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test4',
      images: [],
    ),
    Product(
      name: 'test1',
      description: 'test1',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test1',
      images: [],
    ),
    Product(
      name: 'test2',
      description: 'test2',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test2',
      images: [],
    ),
    Product(
      name: 'test3',
      description: 'test3',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test3',
      images: [],
    ),
    Product(
      name: 'test4',
      description: 'test4',
      entryDate: DateTime.now(),
      price: const Float(),
      brand: 'test4',
      images: [],
    ),
  ];

  void search(String query) {
    setState(
      () {
        filteredProducts.clear();
        if (query.isNotEmpty) {
          for (Product product in products) {
            if (product.name.contains(query) | product.brand.contains(query) | product.description.contains(query)) filteredProducts.add(product);
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

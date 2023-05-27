import 'dart:ffi';

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/widgets/cart_button.dart';
import 'package:cuchos_market_mobile/widgets/product_widget.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/side_panel.dart';

class CatalogPage extends StatefulWidget {
  CatalogPage({Key? key}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      drawer: SidePanel(),
      floatingActionButton: const CartButton(),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) => ProductWidget(product: products[index]),
      ),
    );
  }
}

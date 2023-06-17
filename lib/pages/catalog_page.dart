import 'dart:ffi';

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/utilities/product_controller.dart';
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
  List<Product> products = ProductController().products.value.values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      drawer: const SidePanel(),
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

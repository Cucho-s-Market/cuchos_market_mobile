import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/widgets/cart_button.dart';
import 'package:cuchos_market_mobile/widgets/product_widget.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

import '../widgets/side_panel.dart';

class CatalogPage extends StatefulWidget {
  final List<Product> products;

  const CatalogPage({Key? key, required this.products}) : super(key: key);

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
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
        itemCount: widget.products.length,
        itemBuilder: (context, index) => ProductWidget(product: widget.products[index]),
      ),
    );
  }
}

import 'package:cuchos_market_mobile/widgets/category_grid.dart';
import 'package:cuchos_market_mobile/widgets/products_carousel.dart';
import 'package:cuchos_market_mobile/widgets/promos_carousel.dart';
import 'package:cuchos_market_mobile/widgets/side_panel.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      drawer: const SidePanel(),
      body: ListView(
        children: [
          PromosCarousel(),
          const CategoryGrid(),
          ProductsCarousel(
            title: const Text(
              "Mas vendido",
              style: TextStyle(fontSize: 20),
            ),
          ),
          ProductsCarousel(
            title: const Text(
              "Nuevos Productos",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Cart',
        child: const Icon(Icons.shopping_cart),
      ),
    );
    ;
  }
}
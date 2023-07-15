import 'package:cuchos_market_mobile/utilities/branch_controller.dart';
import 'package:cuchos_market_mobile/utilities/category_controller.dart';
import 'package:cuchos_market_mobile/utilities/product_controller.dart';
import 'package:cuchos_market_mobile/widgets/cart_button.dart';
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
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await BranchController().loadBranches();
    await CategoryController().loadCategories();
    await ProductController().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      drawer: const SidePanel(),
      floatingActionButton: const CartButton(),
      body: ListView(
        children: const [
          //PromosCarousel(),
          CategoryGrid(),
          ProductsCarousel(
            title: Text(
              "Mas vendido",
              style: TextStyle(fontSize: 20),
            ),
          ),
          ProductsCarousel(
            title: Text(
              "Nuevos Productos",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

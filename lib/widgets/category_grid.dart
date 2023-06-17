import 'package:cuchos_market_mobile/utilities/category_controller.dart';
import 'package:cuchos_market_mobile/widgets/category_card.dart';
import 'package:cuchos_market_mobile/widgets/section.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return Section(
      title: const Text(
        "Tenemos lo que necesitas",
        style: TextStyle(fontSize: 20),
      ),
      child: ValueListenableBuilder(
        valueListenable: CategoryController().categories,
        builder: (context, categories, child) => GridView.builder(
          shrinkWrap: true,
          primary: false,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
          itemCount: categories.values.length,
          itemBuilder: (context, index) => CategoryCard(
            category: categories.values.elementAt(index),
          ),
        ),
      ),
    );
  }
}

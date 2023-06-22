import 'package:cuchos_market_mobile/utilities/category_controller.dart';
import 'package:cuchos_market_mobile/widgets/subcategory_tile.dart';
import 'package:flutter/material.dart';

class CategoriesTiles extends StatefulWidget {
  CategoriesTiles({Key? key}) : super(key: key);

  @override
  State<CategoriesTiles> createState() => _CategoriesTilesState();
}

class _CategoriesTilesState extends State<CategoriesTiles> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryController().categories,
      builder: (context, categories, child) => ExpansionTile(
        leading: const Icon(Icons.list),
        title: const Text('Categorias'),
        children: List.generate(
          categories.length,
          (x) => categories.values.elementAt(x).subcategories.isEmpty
              ? ListTile(
                  title: Text(categories.values.elementAt(x).name),
                  onTap: () {},
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Text(
                        categories.values.elementAt(x).name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...List.generate(
                      categories.values.elementAt(x).subcategories.length,
                      (y) => SubCategoryTile(
                        subcategory: categories.values.elementAt(x).subcategories.values.elementAt(y),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

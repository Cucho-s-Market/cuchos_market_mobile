import 'package:cuchos_market_mobile/models/categories.dart';
import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/widgets/section.dart';
import 'package:flutter/material.dart';

class CategoryGrid extends StatefulWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  State<CategoryGrid> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  List<Widget> generateCategoryCards() {
    List<Category> categories = Categories().categories.values.toList();
    List<Widget> categoryCards = [];

    for (Category category in categories) {
      categoryCards.add(
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.name),
            ],
          ),
        ),
      );
    }

    return categoryCards;
  }

  @override
  Widget build(BuildContext context) {
    return Section(
      title: const Text(
        "Tenemos lo que necesitas",
        style: TextStyle(fontSize: 20),
      ),
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        primary: false,
        children: generateCategoryCards(),
      ),
    );
  }
}

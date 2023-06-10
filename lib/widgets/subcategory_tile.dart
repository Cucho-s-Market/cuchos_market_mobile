import 'package:cuchos_market_mobile/models/category.dart';
import 'package:flutter/material.dart';

class SubCategoryTile extends StatelessWidget {
  final Category subcategory;

  const SubCategoryTile({Key? key, required this.subcategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(' \u2981\t\t  ${subcategory.name}'),
      onTap: () {},
    );
  }
}

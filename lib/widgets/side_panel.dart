import 'dart:ffi';

import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/pages/catalog_page.dart';
import 'package:cuchos_market_mobile/pages/home_page.dart';
import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  final List<Category> categories = [
    Category(
      id: const Long(),
      name: 'Category 1',
      description: 'Category 1',
    ),
    Category(
      id: const Long(),
      name: 'Category 2',
      description: 'Category 2',
    ),
    Category(
      id: const Long(),
      name: 'Category 3',
      description: 'Category 3',
    ),
    Category(
      id: const Long(),
      name: 'Category 3',
      description: 'Category 3',
    ),
    Category(
      id: const Long(),
      name: 'Category 3',
      description: 'Category 3',
    ),
  ];

  SidePanel({Key? key}) : super(key: key);

  List<Widget> generateCategoryWidgets() {
    List<Widget> listTileCategories = [];
    for (Category category in categories) {
      listTileCategories.add(
        ListTile(
          title: Text(category.name),
        ),
      );
    }

    return listTileCategories;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: const Text('User'),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_sharp),
            title: const Text('Catalogo'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CatalogPage(),
              ),
            ),
          ),
          ExpansionTile(
            leading: const Icon(Icons.list),
            title: const Text('Categorias'),
            children: generateCategoryWidgets(),
          ),
        ],
      ),
    );
  }
}

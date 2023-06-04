import 'package:cuchos_market_mobile/models/categories.dart';
import 'package:cuchos_market_mobile/models/category.dart';
import 'package:cuchos_market_mobile/models/session.dart';
import 'package:cuchos_market_mobile/pages/catalog_page.dart';
import 'package:cuchos_market_mobile/pages/home_page.dart';
import 'package:cuchos_market_mobile/pages/login_page.dart';
import 'package:cuchos_market_mobile/widgets/drawer_session.dart';
import 'package:flutter/material.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  final Session session = Session();
  final List<Widget> categoryWidgets = [];

  @override
  void initState() {
    super.initState();

    Categories()
        .loadCategories()
        .then(
          (value) => setState(generateCategoryWidgets),
        )
        .onError(
      (error, stackTrace) {
        debugPrint(error.toString());
      },
    );
  }

  void generateCategoryWidgets() {
    List<Category> categories = Categories().categories.values.toList();

    for (Category category in categories) {
      if (category.subcategories.isEmpty) {
        categoryWidgets.add(
          ListTile(
            title: Text(category.name),
            onTap: () {},
          ),
        );
      } else {
        categoryWidgets.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  category.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...generateSubCategoryWidgets(category.subcategories),
            ],
          ),
        );
      }
    }
  }

  List<Widget> generateSubCategoryWidgets(List<Category> subcategories) {
    List<Widget> subCategoryWidgets = [];

    for (Category subCategory in subcategories) {
      subCategoryWidgets.add(
        ListTile(
          title: Text(' \u2981\t\t  ${subCategory.name}'),
          onTap: () {},
        ),
      );
    }

    return subCategoryWidgets;
  }

  void logout() {
    session.discardSesion();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerSession(),
        Expanded(
          child: ListView(
            children: [
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
                leading: const Icon(Icons.grid_view),
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
                children: categoryWidgets,
              ),
            ],
          ),
        ),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text('Cerrar Sesión'),
          onTap: logout,
        ),
      ],
    ));
  }
}

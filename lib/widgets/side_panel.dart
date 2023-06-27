import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:cuchos_market_mobile/pages/catalog_page.dart';
import 'package:cuchos_market_mobile/pages/home_page.dart';
import 'package:cuchos_market_mobile/pages/login_page.dart';
import 'package:cuchos_market_mobile/utilities/product_controller.dart';
import 'package:cuchos_market_mobile/widgets/branch_selector.dart';
import 'package:cuchos_market_mobile/widgets/categories_tiles.dart';
import 'package:cuchos_market_mobile/widgets/drawer_session.dart';
import 'package:flutter/material.dart';

class SidePanel extends StatefulWidget {
  const SidePanel({Key? key}) : super(key: key);

  @override
  State<SidePanel> createState() => _SidePanelState();
}

class _SidePanelState extends State<SidePanel> {
  final SessionController session = SessionController();

  void logout() {
    session.discardSesion();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  void showBranchSelector() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const BranchSelector(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerSession(),
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
                      builder: (context) => CatalogPage(
                        products: ProductController().products.value.values.toList(),
                      ),
                    ),
                  ),
                ),
                const CategoriesTiles(),
              ],
            ),
          ),
          const BranchSelector(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Cerrar Sesión'),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}

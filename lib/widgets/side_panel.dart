import 'package:flutter/material.dart';

class SidePanel extends StatelessWidget {
  const SidePanel({Key? key}) : super(key: key);

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
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.menu_book_sharp),
            title: const Text('Catalogo'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Categorias'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

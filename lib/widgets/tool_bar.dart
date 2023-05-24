import 'package:cuchos_market_mobile/pages/search_page.dart';
import 'package:flutter/material.dart';

class ToolBar extends StatefulWidget implements PreferredSizeWidget {
  final String title = 'Cucho\'s Market';

  const ToolBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<ToolBar> createState() => _ToolBarState();
}

class _ToolBarState extends State<ToolBar> {
  void search() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      actions: [
        IconButton(
          onPressed: search,
          icon: const Icon(Icons.search),
        )
      ],
    );
  }
}

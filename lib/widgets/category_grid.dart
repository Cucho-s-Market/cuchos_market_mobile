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
      child: GridView(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        primary: false,
        children: const [
          Card(
            child: Text("Ropa"),
          ),
          Card(
            child: Text("Tecnologia"),
          ),
          Card(
            child: Text("Alimentos"),
          ),
          Card(
            child: Text("Muebles"),
          ),
        ],
      ),
    );
  }
}

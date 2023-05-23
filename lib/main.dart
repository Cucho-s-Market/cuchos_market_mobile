import 'package:cuchos_market_mobile/widgets/category_grid.dart';
import 'package:cuchos_market_mobile/widgets/products_carousel.dart';
import 'package:cuchos_market_mobile/widgets/promos_carousel.dart';
import 'package:cuchos_market_mobile/widgets/section.dart';
import 'package:cuchos_market_mobile/widgets/side_panel.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(
          primary: Color.fromRGBO(245, 121, 59, 1),
          error: Color.fromRGBO(240, 58, 71, 1),
        ),
        brightness: Brightness.dark,
        useMaterial3: true,
        fontFamily: 'OpenSans',
        dividerColor: Colors.transparent,
      ),
      home: const CuchosMarketPage(title: 'Cucho\'s Market'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CuchosMarketPage extends StatefulWidget {
  const CuchosMarketPage({super.key, required this.title});

  final String title;

  @override
  State<CuchosMarketPage> createState() => _CuchosMarketPageState();
}

class _CuchosMarketPageState extends State<CuchosMarketPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: const SidePanel(),
      body: ListView(
        children: [
          PromosCarousel(),
          const CategoryGrid(),
          ProductsCarousel(
            title: const Text(
              "Mas vendido",
              style: TextStyle(fontSize: 20),
            ),
          ),
          ProductsCarousel(
            title: const Text(
              "Nuevos Productos",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Cart',
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

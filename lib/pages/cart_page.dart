import 'package:cuchos_market_mobile/models/cart.dart';
import 'package:cuchos_market_mobile/widgets/product_card.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartContent.value.length,
              itemBuilder: (context, index) => ProductCard(
                product: cartContent.value.keys.elementAt(index),
                initialQuantity: cartContent.value.values.elementAt(index),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {},
              child: const Text("Comprar"),
            ),
          ),
        ],
      ),
    );
  }
}

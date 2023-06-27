import 'package:cuchos_market_mobile/pages/cart_page.dart';
import 'package:flutter/material.dart';

class CartButton extends StatelessWidget {
  const CartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartPage(),
        ),
      ),
      tooltip: 'Cart',
      child: const Icon(Icons.shopping_cart),
    );
  }
}

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/widgets/add_to_cart_button.dart';
import 'package:cuchos_market_mobile/widgets/cart_button.dart';
import 'package:cuchos_market_mobile/widgets/product_description.dart';
import 'package:cuchos_market_mobile/widgets/product_information.dart';
import 'package:cuchos_market_mobile/widgets/products_carousel.dart';
import 'package:cuchos_market_mobile/widgets/tool_bar.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ToolBar(),
      floatingActionButton: const CartButton(),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ProductInformation(product: widget.product),
                AddToCartButton(product: widget.product),
                ProductDescription(
                  product: widget.product,
                ),
                const ProductsCarousel(
                  title: Text(
                    "Sigue comprando",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    Product product = widget.product;

    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          product.images.isNotEmpty ? product.images.first : const Text('NO DATA', style: TextStyle(color: Colors.red)),
          Card(
            child: Text(widget.product.name),
          ),
        ],
      ),
    );
  }
}

import 'package:cuchos_market_mobile/models/product.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatelessWidget {
  final Product product;

  const ProductDescription({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          child: const Text(
            'Descripción',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white38, fontSize: 15),
          ),
        ),
        Card(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(10),
            child: Text(
              product.description,
              style: const TextStyle(
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

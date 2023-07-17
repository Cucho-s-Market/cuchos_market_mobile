import 'package:cuchos_market_mobile/models/product.dart';
import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  final Product product;

  const ProductPrice({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Precio',
                      style: TextStyle(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'U\$D ${product.price.toString()}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              if (product.price != product.finalPrice)
                Row(
                  children: [
                    const VerticalDivider(),
                    Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Precio anterior',
                            style: TextStyle(color: Colors.white54, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'U\$D ${product.finalPrice.toString()}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }
}

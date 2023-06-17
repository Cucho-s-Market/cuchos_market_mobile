import 'package:cuchos_market_mobile/models/product.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          product.images.isNotEmpty
              ? Opacity(
                  opacity: 0.7,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: product.images.first!,
                    imageErrorBuilder: (context, error, stackTrace) => const Center(
                      child: Text(
                        'NO DATA',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                )
              : const Text('NO DATA', style: TextStyle(color: Colors.red)),
          Container(
            margin: const EdgeInsets.all(10),
            child: Card(
              child: Text(
                widget.product.name,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

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
        alignment: Alignment.center,
        children: [
          product.images.isNotEmpty
              ? Opacity(
                  opacity: 0.7,
                  child: FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    fit: BoxFit.fill,
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
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.all(10),
            child: Opacity(
              opacity: 0.8,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  widget.product.name,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

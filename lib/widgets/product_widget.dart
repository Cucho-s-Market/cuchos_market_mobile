import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/pages/product_page.dart';
import 'package:cuchos_market_mobile/widgets/image_loader.dart';
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

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductPage(product: product),
        ),
      ),
      child: Card(
        child: Stack(
          alignment: Alignment.center,
          children: [
            product.images.isNotEmpty
                ? ImageLoader(
                    imageUrl: product.images.first!,
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
      ),
    );
  }
}

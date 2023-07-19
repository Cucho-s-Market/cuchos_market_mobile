import 'package:carousel_slider/carousel_slider.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/widgets/image_loader.dart';
import 'package:flutter/material.dart';

import 'product_price.dart';

class ProductInformation extends StatefulWidget {
  final Product product;

  const ProductInformation({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductInformation> createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
  int _current = 0;

  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: List.generate(
            widget.product.images.length,
            (index) => Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ImageLoader(
                imageUrl: widget.product.images.elementAt(index),
              ),
            ),
          ),
          options: CarouselOptions(
            autoPlay: true,
            pauseAutoPlayOnTouch: true,
            onPageChanged: (index, reason) => setState(
              () {
                _current = index;
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.product.images.length,
            (index) => GestureDetector(
              onTap: () => _controller.animateToPage(index),
              child: Container(
                width: 5.0,
                height: 5.0,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: (Theme.of(context).brightness == Brightness.dark ? Colors.grey[200] : Colors.black)?.withOpacity(
                    _current == index ? 0.9 : 0.4,
                  ),
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Text(
            widget.product.name,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Center(
          child: Text(widget.product.brand),
        ),
        ProductPrice(
          product: widget.product,
        ),
      ],
    );
  }
}

import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cuchos_market_mobile/models/product.dart';
import 'package:cuchos_market_mobile/utilities/product_controller.dart';
import 'package:cuchos_market_mobile/widgets/product_widget.dart';
import 'package:cuchos_market_mobile/widgets/section.dart';
import 'package:flutter/material.dart';

class ProductsCarousel extends StatefulWidget {
  final Widget title;
  ProductsCarousel({Key? key, required this.title}) : super(key: key);

  @override
  State<ProductsCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<ProductsCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  //TODO: Implementar logica para obtener productos
  List<Product> products = ProductController().products.value.values.toList();

  @override
  Widget build(BuildContext context) {
    return Section(
      title: widget.title,
      child: Column(
        children: [
          //TODO: Refactorizar para utilizar ValueListenable
          CarouselSlider(
            carouselController: _controller,
            items: products.map(
              (product) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: ProductWidget(product: product),
                    );
                  },
                );
              },
            ).toList(),
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
            children: [1, 2, 3, 4, 5].asMap().entries.map(
              (entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 5.0,
                    height: 5.0,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.grey[200] : Colors.black)
                            ?.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}

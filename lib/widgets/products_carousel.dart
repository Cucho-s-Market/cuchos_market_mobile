import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Section(
      title: widget.title,
      child: ValueListenableBuilder(
        valueListenable: ProductController().products,
        builder: (context, products, child) => Column(
          children: [
            CarouselSlider(
              carouselController: _controller,
              items: List.generate(
                products.length,
                (index) => Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ProductWidget(
                    product: products.values.elementAt(index),
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
                products.length,
                (index) => GestureDetector(
                  onTap: () => _controller.animateToPage(index),
                  child: Container(
                    width: 5.0,
                    height: 5.0,
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark ? Colors.grey[200] : Colors.black)?.withOpacity(_current == index ? 0.9 : 0.4)),
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

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cuchos_market_mobile/widgets/section.dart';
import 'package:flutter/material.dart';

class PromosCarousel extends StatefulWidget {
  PromosCarousel({Key? key}) : super(key: key);

  @override
  State<PromosCarousel> createState() => _ProductsCarouselState();
}

class _ProductsCarouselState extends State<PromosCarousel> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: [1, 2, 3, 4, 5].map(
            (i) {
              return Builder(
                builder: (BuildContext context) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      'text $i',
                      style: const TextStyle(fontSize: 16.0),
                    ),
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
                  width: 10.0,
                  height: 10.0,
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color:
                          (Theme.of(context).brightness == Brightness.dark ? Colors.grey[200] : Colors.black)?.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

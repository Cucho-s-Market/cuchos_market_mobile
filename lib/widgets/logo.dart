import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final double height;

  const Logo({Key? key, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fit: BoxFit.scaleDown,
      height: height,
      'assets/images/logo.svg',
      semanticsLabel: 'Cucho\'s Market Logo',
    );
  }
}

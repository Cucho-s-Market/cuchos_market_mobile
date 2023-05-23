import 'dart:ffi';

import 'package:cuchos_market_mobile/models/product.dart';

class Item {
  final String id;
  final String name;
  final Float price;
  final Float finalPrice;
  final Int quantity;
  final Product product;

  Item({
    required this.id,
    required this.name,
    required this.price,
    required this.finalPrice,
    required this.quantity,
    required this.product,
  });
}

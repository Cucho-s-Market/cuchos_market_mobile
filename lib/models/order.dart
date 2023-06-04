import 'dart:ffi';

import 'package:cuchos_market_mobile/models/item.dart';
import 'package:cuchos_market_mobile/models/order_status.dart';
import 'package:cuchos_market_mobile/models/order_type.dart';

class Order {
  final int id;
  final Float totalPrice;
  final DateTime creationDate;
  final DateTime endDate;
  final OrderStatus status;
  final OrderType type;
  final List<Item> products;

  Order({
    required this.id,
    required this.totalPrice,
    required this.creationDate,
    required this.endDate,
    required this.status,
    required this.type,
    required this.products,
  });
}

import 'package:cuchos_market_mobile/models/item.dart';
import 'package:cuchos_market_mobile/models/order_status.dart';
import 'package:cuchos_market_mobile/models/order_type.dart';

class Order {
  final int? branchId;
  final int? id;
  final double? totalPrice;
  final DateTime creationDate;
  final DateTime? endDate;
  final OrderStatus? status;
  final int? addressId;
  final String? clientAddress;
  final OrderType type;
  final List<Item>? items;

  Order({
    required this.branchId,
    this.id,
    this.totalPrice,
    required this.creationDate,
    this.endDate,
    this.status,
    this.addressId,
    this.clientAddress,
    required this.type,
    this.items,
  });

  factory Order.fromJson({required Map<String, dynamic> json}) {
    Map<String, dynamic> orderJson = json['order'];

    return Order(
      branchId: json['branchId'],
      id: orderJson['id'],
      totalPrice: orderJson['totalPrice'],
      creationDate: DateTime.parse(orderJson['creationDate']),
      endDate: DateTime.tryParse(orderJson['endDate']),
      status: OrderStatus.values.byName(orderJson['status'].toString().toLowerCase()),
      addressId: orderJson['addressId'],
      clientAddress: orderJson['clientAddress'],
      type: OrderType.values.byName(orderJson['type'].toString().toLowerCase()),
      items: orderJson['products'].map<Item>((itemJson) => Item.fromJson(json: itemJson)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'branchId': branchId,
      'creationDate': creationDate.toString().split(' ').first,
      'type': type.name.toUpperCase(),
      'products': items?.map((item) => item.toJson()).toList(),
      'addressId': addressId,
    };
  }
}

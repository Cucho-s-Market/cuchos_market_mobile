import 'package:cuchos_market_mobile/models/order.dart';

class Branch {
  final int id;
  final String name;
  final String address;
  final List<Order> orders = [];

  Branch({
    required this.id,
    required this.name,
    required this.address,
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      id: json["id"],
      name: json["name"],
      address: json["name"],
    );
  }
}

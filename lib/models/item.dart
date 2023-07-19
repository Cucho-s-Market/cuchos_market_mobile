import 'package:cuchos_market_mobile/models/product.dart';

class Item {
  final String name;
  final double price;
  final double? finalPrice;
  final int quantity;
  final Product? product;

  Item({
    required this.name,
    required this.price,
    this.finalPrice,
    required this.quantity,
    required this.product,
  });

  factory Item.fromJson({required Map<String, dynamic> json}) {
    return Item(
      name: json['name'],
      price: json['unitPrice'],
      quantity: json['quantity'],
      product: json['product'] != null ? Product.fromJson(json: json['product']) : json['product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
    };
  }
}

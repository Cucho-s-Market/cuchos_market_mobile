import 'package:cuchos_market_mobile/models/product.dart';
import 'package:flutter/material.dart';

class Cart {
  static final _instance = Cart._internal();
  final ValueNotifier<Map<Product, int>> products = ValueNotifier({});
  final ValueNotifier<double> totalAmount = ValueNotifier(0);

  Cart._internal();

  factory Cart() {
    return _instance;
  }

  get cartContent => products.value;

  void updateCart({required Product product, required int quantity}) {
    if (quantity > 0) {
      products.value[product] = quantity;
      totalAmount.value = (product.price * quantity);
    } else if (products.value.containsKey(product)) {
      Map<Product, int> newProducts = {};

      totalAmount.value = (totalAmount.value) - (product.price * products.value[product]!);

      newProducts.addAll(products.value);
      newProducts.remove(product);
      products.value = newProducts;
    }
  }

  void cleanCart() {
    products.value = {};
    totalAmount.value = 0;
  }
}

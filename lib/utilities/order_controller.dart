import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/order_exception.dart';
import 'package:cuchos_market_mobile/models/issue.dart';
import 'package:cuchos_market_mobile/models/order.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class OrderController {
  static final OrderController _instance = OrderController._internal();
  String? token;
  final ValueNotifier<List<Order>> orders = ValueNotifier<List<Order>>([]);

  factory OrderController() {
    return _instance;
  }

  OrderController._internal();

  Future<bool> placeOrder(Order order) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/orders',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(order.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw OrderException(body["message"]);

        break;

      case 403:
        throw OrderException("Forbidden: Error al realizar orden.");
      default:
    }

    return true;
  }

  Future<bool> placeIssue(Issue issue) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/orders/issues',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> issueJson = issue.toJson();

    debugPrint(issueJson.toString());

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(issue.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw OrderException(body["message"]);

        break;

      case 403:
        throw OrderException("Forbidden: Error al realizar reclamo.");
      default:
    }

    return true;
  }

  Future<void> cancelOrder(Order order) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/orders/${order.id}',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
    };

    final response = await http.put(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body["error"] == true) throw OrderException(body["message"]);

        break;

      case 403:
        throw OrderException("Forbidden: Error al obtener ordenes.");
      default:
    }
  }

  Future<void> loadOrders() async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/orders/customer',
    );

    final List<Order> newOrders = [];

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw OrderException(body["message"]);

        for (final Map<String, dynamic> orderJson in body["data"]["content"]) {
          final int? orderId = orderJson['id'];

          if (orderId != null) {
            final Order? newOrder = await getOrderInformation(orderId);

            if (newOrder != null) newOrders.add(newOrder);
          }
        }

        orders.value = newOrders;

        break;

      case 403:
        throw OrderException("Forbidden: Error al obtener ordenes.");
      default:
    }
  }

  Future<Order?> getOrderInformation(int orderId) async {
    final Uri url = Uri.parse("https://cuchos-market-2023-34241c211eef.herokuapp.com/orders/${orderId.toString()}");
    final Order? order;

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw OrderException(body["message"]);

        order = Order.fromJson(json: body["data"]);

        return order;

      case 403:
        throw OrderException("Forbidden: Error al obtener información de orden.");
      default:
    }

    return null;
  }
}

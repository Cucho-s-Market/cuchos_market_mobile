import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/addresses_exception.dart';
import 'package:cuchos_market_mobile/exceptions/credentials_exception.dart';
import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/models/user.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SessionController {
  static final SessionController _instance = SessionController._internal();
  String? token;
  User? user;
  final ValueNotifier<List<Address>> addresses = ValueNotifier<List<Address>>([]);

  factory SessionController() {
    return _instance;
  }

  SessionController._internal();

  Future<void> login(String email, String password) async {
    if (email.isEmpty) throw CredentialsException('El email no puede estar vacio.');
    if (password.isEmpty) throw CredentialsException('La contraseña no puede estar vacia.');

    final Uri url = Uri.parse("http://localhost:8080/users/auth/login");

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
          'password': password,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body["error"] == true) throw CredentialsException(body["message"]);

        token = body["token"];
        debugPrint(token.toString());

        user = User.fromJson(
          json: body["data"],
          email: email,
          password: password,
        );
        break;

      case 403:
        throw CredentialsException("Forbidden: Error al iniciar sesion.");
      default:
    }
  }

  Future<void> loadAddresses() async {
    final Uri url = Uri.parse("http://localhost:8080/users/customer/address");

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body["error"] == true) throw AddressesException(body["message"]);

        List<Address> newAddresses = [];

        for (final Map<String, dynamic> addressJson in body["data"]) {
          newAddresses.add(Address.fromJson(json: addressJson));
        }

        addresses.value = newAddresses;
        break;

      case 403:
        throw AddressesException("Forbidden: Error al obtener direcciones.");
      default:
    }
  }

  void discardSesion() {
    user = null;
    token = null;
  }
}

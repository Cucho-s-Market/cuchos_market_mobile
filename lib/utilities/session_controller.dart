import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/addresses_exception.dart';
import 'package:cuchos_market_mobile/exceptions/credentials_exception.dart';
import 'package:cuchos_market_mobile/models/address.dart';
import 'package:cuchos_market_mobile/models/customer.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class SessionController {
  static final SessionController _instance = SessionController._internal();
  String? token;
  Customer? user;
  final ValueNotifier<List<Address>> addresses = ValueNotifier<List<Address>>([]);

  factory SessionController() {
    return _instance;
  }

  SessionController._internal();

  Future<void> login(String email, String password) async {
    if (email.isEmpty) throw CredentialsException('El email no puede estar vacio.');
    if (password.isEmpty) throw CredentialsException('La contraseña no puede estar vacia.');

    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/auth/login',
    );

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
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw CredentialsException(body["message"]);

        token = body["token"];
        debugPrint(token.toString());

        user = Customer.fromJson(
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

  Future<void> resetPassword(String email) async {
    if (email.isEmpty) throw CredentialsException('El email no puede estar vacio.');

    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/auth/resetPassword',
    );

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'email': email,
        },
      ),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw CredentialsException(body["message"]);

        break;

      case 403:
        throw CredentialsException("Forbidden: Error al iniciar sesion.");
      default:
    }
  }

  Future<void> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String telephone,
    required String dni,
    required DateTime birthdate,
  }) async {
    if (email.isEmpty) throw CredentialsException('El email no puede estar vacío.');
    if (password.isEmpty) throw CredentialsException('La contraseña no puede estar vacía.');
    if (firstName.isEmpty) throw CredentialsException('El nombre no puede estar vacío.');
    if (lastName.isEmpty) throw CredentialsException('El apellido no puede estar vacío.');
    if (telephone.isEmpty) throw CredentialsException('El número no puede estar vacío.');
    if (dni.isEmpty) throw CredentialsException('La Cédula no puede estar vacía.');
    if (birthdate.year >= DateTime.now().year) throw CredentialsException('Ingrese una fecha de nacimiento válida.');

    Customer customer = Customer(
      email: email,
      password: password,
      firstName: firstName,
      lastName: lastName,
      telephone: int.tryParse(telephone) ?? 0,
      dni: int.tryParse(dni) ?? 0,
      birthdate: birthdate,
    );

    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/customer',
    );

    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(customer.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw CredentialsException(body["message"]);

        break;

      case 403:
        throw CredentialsException("Forbidden: Error al registrar usuario.");
      default:
    }
  }

  Future<void> updateUserInformation(Customer customer) async {
    if (customer.email.isEmpty) throw CredentialsException('El email no puede estar vacio.');
    if (customer.password.isEmpty) throw CredentialsException('La contraseña no puede estar vacia.');

    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(customer.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw CredentialsException(body["message"]);

        user = customer;

        break;

      case 403:
        throw CredentialsException("Forbidden: Error al actualizar información del usuario.");
      default:
    }
  }

  Future<void> loadAddresses() async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/customer/address',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

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

  Future<void> addAddress(Address address) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/customer/address',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(address.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw AddressesException(body["message"]);

        loadAddresses();
        break;

      case 403:
        throw AddressesException("Forbidden: Error al crear dirección.");
      default:
    }
  }

  Future<void> updateAddress(Address address) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/customer/address',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(address.toJson()),
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw AddressesException(body["message"]);

        loadAddresses();
        break;

      case 403:
        throw AddressesException("Forbidden: Error al crear dirección.");
      default:
    }
  }

  Future<void> deleteAddress(Address address) async {
    final Uri url = Uri(
      scheme: 'https',
      host: 'cuchos-market-2023-34241c211eef.herokuapp.com',
      path: '/users/customer/address/${address.id}',
    );

    final Map<String, String> headers = {
      'Authorization': 'Bearer ${SessionController().token}',
      'Content-Type': 'application/json',
    };

    final response = await http.delete(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(utf8.decode(response.bodyBytes));

        if (body["error"] == true) throw AddressesException(body["message"]);

        loadAddresses();
        break;

      case 403:
        throw AddressesException("Forbidden: Error al crear dirección.");
      default:
    }
  }

  void discardSesion() {
    user = null;
    token = null;
  }
}

import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/credentials_exception.dart';
import 'package:cuchos_market_mobile/models/user.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Session {
  static final Session _instance = Session._internal();
  String? token;
  User? user;

  factory Session() {
    return _instance;
  }

  Session._internal();

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

  void discardSesion() {
    user = null;
    token = null;
  }
}

import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/branches_exception.dart';
import 'package:cuchos_market_mobile/models/branch.dart';
import 'package:cuchos_market_mobile/models/session.dart';

import 'package:http/http.dart' as http;

class Branches {
  static final Branches _instance = Branches._internal();
  final Map<int, Branch> branches = {};

  factory Branches() {
    return _instance;
  }

  Branches._internal();

  Future<void> loadBranches() async {
    final Uri url = Uri.parse("http://localhost:8080/branches");
    final Map<String, String> headers = {
      'Authorization': 'Bearer ${Session().token}',
    };

    final response = await http.get(
      url,
      headers: headers,
    );

    switch (response.statusCode) {
      case 200:
        Map<String, dynamic> body = jsonDecode(response.body);

        if (body["error"] == true) throw BranchesException(body["message"]);

        if (body["data"].isEmpty()) throw BranchesException("No se obtuvieron sucursales.");

        branches.clear();

        for (final Map<String, dynamic> branchJson in body["data"]) {
          branches[branchJson['id']] = Branch.fromJson(branchJson);
        }

        break;
      case 403:
        throw BranchesException("Forbidden: Error al obtener sucursales.");
      default:
    }
  }
}

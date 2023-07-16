import 'dart:convert';

import 'package:cuchos_market_mobile/exceptions/branch_exception.dart';
import 'package:cuchos_market_mobile/models/branch.dart';
import 'package:cuchos_market_mobile/utilities/session_controller.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class BranchController {
  static final BranchController _instance = BranchController._internal();
  final ValueNotifier<Map<int, Branch>> branches = ValueNotifier<Map<int, Branch>>({});
  final ValueNotifier<Branch> selectedBranch = ValueNotifier(Branch.empty());

  factory BranchController() {
    return _instance;
  }

  BranchController._internal();

  Future<void> loadBranches() async {
    final Map<int, Branch> newBranches = {};

    final Uri url = Uri.parse("https://cuchos-market-2023-34241c211eef.herokuapp.com/branches");
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

        if (body["error"] == true) throw BranchException(body["message"]);

        if (body["data"].isEmpty) throw BranchException("No se obtuvieron sucursales.");

        for (final Map<String, dynamic> branchJson in body["data"]) {
          newBranches[branchJson['id']] = Branch.fromJson(branchJson);
        }

        break;
      case 403:
        throw BranchException("Forbidden: Error al obtener sucursales.");
      default:
    }

    branches.value = newBranches;
    selectedBranch.value = branches.value.values.first;
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login/data/env/env.dart';
import 'package:login/data/storage/secure_storage.dart';

import 'package:login/domain/models/response/default_response.dart';
import 'package:login/domain/models/response/response_policy.dart';

class PolicyServices {
  Future<List<Policy>> getAllPolicy() async {
    // final token = await secureStorage.readToken();
    // print(token);

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-all-policy'),
        headers: {'Accept': 'application/json'}); //, 'xxx-token': token!});
    print('policy_services');
    return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  }
}

final policyService = PolicyServices();

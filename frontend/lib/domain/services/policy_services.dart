import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login/data/env/env.dart';
import 'package:login/data/storage/secure_storage.dart';
import 'package:login/domain/models/response/response_search.dart';
import 'package:login/domain/models/response/response_policy.dart';

import 'package:login/ui/helpers/debouncer.dart';

import 'package:login/domain/models/response/default_response.dart';
import 'package:login/domain/models/response/response_policy.dart';

class PolicyServices {
  final debouncer = DeBouncer(duration: const Duration(milliseconds: 800));
  final StreamController<List<Policy>> _streamController =
      StreamController<List<Policy>>.broadcast();
  Stream<List<Policy>> get searchProducts => _streamController.stream;

  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  Future<List<Policy>> getAllPolicy() async {
    // final token = await secureStorage.readToken();
    // print(token);

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-all-policy'),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
    print('policy_services');
    return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  }

  void searchPolicy(String searchValue) async {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      // final token = await secureStorage.readToken();
      final resp = await http.get(
          Uri.parse(
              '${Environment.urlApi}/policy/get-search-policy/' + searchValue),
          headers:
              _setHeaders()); //{'Accept': 'application/json'}); //, 'xxx-token': token! });

      print(resp.body);
      final listPolicies =
          ResponsePolicy.fromJson(json.decode(resp.body)).policies;

      _streamController.add(listPolicies);
    };

    final timer = Timer(
        const Duration(milliseconds: 200), () => debouncer.value = searchValue);
    Future.delayed(const Duration(milliseconds: 400))
        .then((_) => timer.cancel());
  }

  Future<List<Policy>> getAllPolicyForSearch() async {
    // final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-all-policy-for-search'),
        headers:
            _setHeaders() //{'Accept': 'application/json'} //, 'xxx-token' : token!}
        );

    return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  }
}

final policyService = PolicyServices();

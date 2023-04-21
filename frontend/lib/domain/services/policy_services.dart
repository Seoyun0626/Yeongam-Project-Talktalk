import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:login/data/env/env.dart';
import 'package:login/data/storage/secure_storage.dart';
import 'package:login/domain/models/response/default_response.dart';
import 'package:login/domain/models/response/response_banner.dart';
import 'package:login/domain/models/response/response_policy.dart';
import 'package:login/domain/models/response/response_policy_by_user.dart';
import 'package:login/ui/helpers/debouncer.dart';
// import 'package:login/ui/helpers/response_code.dart';

class PolicyServices {
  final debouncer = DeBouncer(duration: const Duration(milliseconds: 800));
  final StreamController<List<Policy>> _streamController =
      StreamController<List<Policy>>.broadcast();
  Stream<List<Policy>> get searchProducts => _streamController.stream;
  Stream<List<Policy>> get selectProducts => _streamController.stream;

  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  Future<List<Policy>> getAllPolicy() async {
    // final token = await secureStorage.readToken();
    // print(token);

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-all-policy'),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
    // print('policy_services');
    // print(resp.body);
    return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  }

  // // 코드 데이터
  // Future getCodeData() async {
  //   final resp = await http.get(
  //       Uri.parse('${Environment.urlApi}/policy/get-code-data'),
  //       headers:
  //           _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
  //   print('policy_services getCodeData');
  //   // print(resp.body);
  //   Map<String, dynamic> data = json.decode(resp.body);
  //   // List result = data['policies'] as List;

  //   return data; //ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  // }

  void searchPolicy(String searchValue) async {
    debouncer.value = "";
    debouncer.onValue = (value) async {
      // final token = await secureStorage.readToken();
      final resp = await http.get(
          Uri.parse(
              '${Environment.urlApi}/policy/get-search-policy/' + searchValue),
          headers:
              _setHeaders()); //{'Accept': 'application/json'}); //, 'xxx-token': token! });

      // print(resp.body);
      final listPolicies =
          ResponsePolicy.fromJson(json.decode(resp.body)).policies;

      _streamController.add(listPolicies);
    };

    final timer = Timer(
        const Duration(milliseconds: 200), () => debouncer.value = searchValue);
    Future.delayed(const Duration(milliseconds: 400))
        .then((_) => timer.cancel());
  }

  Future<List<Policy>> getPolicyBySelect(
      String codeName, String codeDetail) async {
    //
    // final token = await secureStorage.readToken();
    // print(token);
    print('getPolicyBySelect');

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-select-policy/' +
            codeName +
            '/' +
            codeDetail),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});

    // print('policy_services');
    // print(resp.body);
    return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  }

  // 정책 스크랩
  Future<DefaultResponse> scrapOrUnscrapPolicy(
      String uidPolicy, String uidUser) async {
    final token = await secureStorage.readToken();
    // print('policy_service : scrapOrUnscrapPolicy');
    // print(token);
    // print(uidPolicy);
    // print(uidUser);

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/policy/scrap-or-unscrap-policy'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'uidPolicy': uidPolicy, 'uidUser': uidUser});
    print(resp.body);

    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // void selectPolicy(String code) async {
  //   //Future<List<Policy>>
  //   // final token = await secureStorage.readToken();
  //   // print(token);
  //   print('getPolicyBySelect');
  //   debouncer.value = "";
  //   debouncer.onValue = (value) async {
  //     final resp = await http.get(
  //         Uri.parse('${Environment.urlApi}/policy/get-select-policy/' + code),
  //         headers:
  //             _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
  //     final listPolicies =
  //         ResponsePolicy.fromJson(json.decode(resp.body)).policies;

  //     _streamController.add(listPolicies);
  //   };

  //   final timer =
  //       Timer(const Duration(milliseconds: 200), () => debouncer.value = code);
  //   Future.delayed(const Duration(milliseconds: 400))
  //       .then((_) => timer.cancel());
  //   // print('policy_services');
  //   // print(resp.body);
  //   // return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  // }

  // Future<List<Policy>> getAllPolicyForSearch() async {
  //   // final token = await secureStorage.readToken();

  //   final resp = await http.get(
  //       Uri.parse('${Environment.urlApi}/policy/get-all-policy-for-search'),
  //       headers:
  //           _setHeaders() //{'Accept': 'application/json'} //, 'xxx-token' : token!}
  //       );

  //   return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  // }
  Future<List<Policy>> getScrappedPolicy() async {
    final token = await secureStorage.readToken();
    print('getScrappedPolicy');

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-scrapped-policy'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    // print(resp.body);

    return ResponsePolicy.fromJson(jsonDecode(resp.body)).policies;
  }

  Future<int> checkPolicyScrapped(String uidPolicy) async {
    final token = await secureStorage.readToken();
    // print('checkPolicyScrapped');

    final resp = await http.get(
        Uri.parse(
            '${Environment.urlApi}/policy/check-policy-scrapped/' + uidPolicy),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    // print(resp.body);

    final data = jsonDecode(resp.body);
    final result = data['isScrapped']['isScrapped'];
    return result;
  }
}

final policyService = PolicyServices();

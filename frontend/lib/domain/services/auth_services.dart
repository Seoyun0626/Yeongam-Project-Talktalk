import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/models/response/response_login.dart';
import 'package:teentalktalk/data/env/env.dart';

class AuthServices {
  Future<ResponseLogin> login(String userid, String password) async {
    final resp = await http.post(Uri.parse('${Environment.urlApi}/login/login'),
        headers: {'Accept': 'application/json'},
        body: {'userid': userid, 'userpw': password});
    // print('auth_services login');
    // print(resp.body);

    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }

  Future<bool> checkDuplicateID(String userid) async {
    final resp = await http.post(
      Uri.parse('${Environment.urlApi}/login/checkDuplicateID'),
      headers: {'Accept': 'application/json'},
      body: {'userid': userid},
    );
    return ResponseLogin.fromJson(jsonDecode(resp.body)).resp;
  }

  Future<ResponseLogin> renewLogin() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(Uri.parse('${Environment.urlApi}/renew-login'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }
}

final authServices = AuthServices();

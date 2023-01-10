import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/data/storage/secure_storage.dart';
import 'package:login/domain/models/response/response_login.dart';
import 'package:login/data/env/env.dart';

class AuthServices {
  Future<ResponseLogin> login(String id, String password) async {
    final resp = await http.post(Uri.parse('${Environment.urlApi}/login'),
        headers: {'Accept': 'application/json'},
        body: {'id': id, 'password': password});
    print('login' + resp.body);

    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }

  Future<ResponseLogin> renewLogin() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/auth/renew-login'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    return ResponseLogin.fromJson(jsonDecode(resp.body));
  }
}

final authServices = AuthServices();

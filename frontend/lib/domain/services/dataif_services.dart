import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/data/storage/secure_storage.dart';
import 'package:login/domain/models/response/default_response.dart';
import 'package:login/domain/models/response/response_event.dart';
import 'package:login/domain/models/response/response_login.dart';
import 'package:login/data/env/env.dart';
import 'package:login/domain/models/response/response_terms.dart';

class DataIfServices {
  Future<ResponseTerms> getTermsData() async {
    final resp = await http.get(Uri.parse('${Environment.urlApi}/dataif/terms'),
        headers: {'Accept': 'application/json'});
    // print(resp.body);

    return ResponseTerms.fromJson(jsonDecode(resp.body));
  }

  // 사용자 무화과 내역
  Future<ResponseEvent> getFigHistoryByUser() async {
    final token = await secureStorage.readToken();

    print('getFigHistoryByUser');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/dataif/fig-manage-by-user'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    print(resp.body);

    return ResponseEvent.fromJson(jsonDecode(resp.body));
  }
}

final dataIfService = DataIfServices();

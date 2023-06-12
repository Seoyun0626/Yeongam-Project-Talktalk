import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/models/response/response_terms.dart';

class DataIfServices {
  Future<ResponseTerms> getTermsData() async {
    final resp = await http.get(Uri.parse('${Environment.urlApi}/dataif/terms'),
        headers: {'Accept': 'application/json'});
    // print(resp.body);

    return ResponseTerms.fromJson(jsonDecode(resp.body));
  }
}

final dataIfService = DataIfServices();

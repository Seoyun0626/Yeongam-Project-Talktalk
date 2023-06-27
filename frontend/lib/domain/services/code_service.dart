import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/env/env.dart';
import 'package:teentalktalk/domain/models/response/default_response.dart';

class codeServices {
  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  //Future<List<commonCode>>
  getCodeData() async {
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/codeData/get-code-data'),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
    var result = jsonDecode(resp.body);
    return result;
  }

  getEvents(String eid) async {
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/codeData/get-events/$eid'),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
    var result = jsonDecode(resp.body);
    print(result);
    return result;
  }
}

final codeService = codeServices();

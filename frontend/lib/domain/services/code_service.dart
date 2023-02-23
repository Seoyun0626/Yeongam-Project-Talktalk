import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/data/env/env.dart';
import 'package:login/domain/models/response/response_code.dart';
import 'package:login/domain/services/policy_services.dart';

class codeServices {
  Map<String, String> _setHeaders() =>
      {'Content-Type': 'application/json;charset=UTF-8', 'Charset': 'utf-8'};

  //Future<List<commonCode>>
  getCodeData() async {
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/policy/get-code-data'),
        headers:
            _setHeaders()); // {'Accept': 'application/json'}); //, 'xxx-token': token!});
    // print('code_services getCodeData');
    // print(resp.body);
    var result = jsonDecode(resp.body);
    // var data = json.decode(resp.body);
    // // List result = data['policies'] as List;

    // var dataResponse = json.decode(resp.body);
    // var data = dataResponse['codes'];
    // var result = data.map((x) => commonCode.fromJson(x)).toList();

    return result; //ResponseCode.fromJson(jsonDecode(resp.body)).codes;
  }

  // getCodeName(String codeType, String code) {
  //   print(data);
  //   late String codeDetailName = '';
  //   // var len = data['codes'][codeType];
  //   // print(len);

  //   for (int i = 0; i < 6; i++) {
  //     var codeDetail = data['codes'][codeType][i]['code_detail'];
  //     if (codeDetail == code) {
  //       codeDetailName = data['codes'][codeType][i]['code_detail_name'];
  //       print(codeDetailName);
  //       return codeDetailName;
  //     }
  //   }
  // }

  // getInstitutionCodeData(String code) async {
  //   var data = await codeService.getCodeData('policy_institution_code', '01');
  //   // print(data);
  //   return data;
  // }
}

//

final codeService = codeServices();

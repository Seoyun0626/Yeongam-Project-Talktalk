import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/data/env/env.dart';
import 'package:login/domain/services/policy_services.dart';

class codeServices {
  getCodeData(String codeType, String code) async {
    var data = await policyService.getCodeData();
    late String codeDetailName = '';
    var len = data['policies'][codeType].length;
    // print(len);

    for (int i = 0; i < len; i++) {
      var codeDetail = data['policies'][codeType][i]['code_detail'];
      if (codeDetail == code) {
        codeDetailName = data['policies'][codeType][i]['code_detail_name'];
        // print(name);
        return codeDetailName;
      }
    }
  }

  getInstitutionCodeData(String code) async {
    var data = await codeService.getCodeData('policy_institution_code', '01');
    // print(data);
    return data;
  }
}

//

final codeService = codeServices();

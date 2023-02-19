import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/data/env/env.dart';
import 'package:login/domain/services/policy_services.dart';

class codeServices {
  getCodeData() async {
    var data = await policyService.getCodeData();
    // print(data);
    var policy_codes =
        data['policies']['policy_institution_code'][0]['code_detail_name'];
    // print(policy_codes);

    return policy_codes;
  }
}

final codeService = codeServices();

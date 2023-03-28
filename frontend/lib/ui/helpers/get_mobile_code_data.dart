import 'package:flutter/animation.dart';
import 'package:login/domain/services/code_service.dart';

class getMobileCodeFunctions {
  late Map<String, dynamic> codeData = {};

  void getCodeData() async {
    var data = await codeService.getCodeData();
    codeData = data;
  }

  String getCodeDetailName(String my_code_name, String my_code_detail) {
    // print(codeData);
    // late String code_detail_name = '';
    // int len = data["codes"][my_code_name].length;

    int index_code = int.parse(my_code_detail);
    String code_detail_name =
        codeData["codes"][my_code_name][index_code]["code_detail_name"];

    // for (int i = 0; i < len; i++) {
    //   var code_detail = data["codes"][my_code_name][i]["code_detail"];
    //   if (code_detail == my_code_detail) {
    //     var result = data["codes"][my_code_name][i]["code_detail_name"];
    //     // var result2 = data["codes"](my_code_name);
    //     // print(result2);

    //     code_detail_name = result;
    //   }
    // }

    return code_detail_name;
  }
}

final getMobileCodeService = getMobileCodeFunctions();


// late String policyInstitution = '';
  // late String policyField = '';

  // @override
  // void initState() {
  //   final Policy policies = widget.policies;
  //   final String institutionCode = policies.policy_institution_code; // 기관 코드
  //   final String fieldCode = policies.policy_field_code; // 분야 코드

  //   codeService.getCodeData().then((value) {
  //     setState(() {
  //       // test = value['codes'];
  //       var institutionLen = value['codes']['policy_institution_code'].length;
  //       var fieldLen = value['codes']['policy_field_code'].length;

  //       // 기관
  //       for (int i = 0; i < institutionLen; i++) {
  //         var codeDetail =
  //             value['codes']['policy_institution_code'][i]['code_detail'];
  //         if (codeDetail == institutionCode) {
  //           var codeDetailName = value['codes']['policy_institution_code'][i]
  //               ['code_detail_name'];
  //           policyInstitution = codeDetailName;
  //           // print(policyInstitution);
  //         }
  //       }

  //       // 분야
  //       for (int i = 0; i < fieldLen; i++) {
  //         var codeDetail =
  //             value['codes']['policy_field_code'][i]['code_detail'];
  //         if (codeDetail == fieldCode) {
  //           var codeDetailName =
  //               value['codes']['policy_field_code'][i]['code_detail_name'];
  //           policyField = codeDetailName;
  //           // print(policyInstitution);
  //         }
  //       }
  //     });
  //   });
  //   super.initState();
  // }

  // @override
  // void dispose() {
  //   policyInstitution;
  //   policyField;
  //   super.dispose();
  // }
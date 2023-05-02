// import 'package:flutter/animation.dart';
import 'package:login/domain/services/code_service.dart';

class CodeDetailData {
  final String detailName;
  final String code;
  final String codeName;
  bool selected;
  CodeDetailData(
      {required this.detailName,
      required this.code,
      required this.codeName,
      this.selected = false});
}

// class CodeData {
//   final String? codeName;
//   final List<CodeDetailData>? detailList;
//   CodeData({this.codeName, this.detailList});
// }

class getMobileCodeFunctions {
  late Map<String, dynamic> codeData = {};

  void getCodeData() async {
    var data = await codeService.getCodeData();
    codeData = data;
  }

/*
호출 예시
1. getCodeDetailName(예 : '적용 대상' 코드 '00' 값 이름 -> 'policy_tareget_code', 코드 값 전달 -> '부부/임산부' 반환)
getMobileCodeService.getCodeDetailName('policy_target_code', policies.policy_target_code);

2. getCodeDetailList(예 : '운영 기관' -> 'policy_institution_code' 전달 -> 리스트 반환 [['00', '영암군'], ['01', '청소년 수련관']...])
getMobileCodeService.getCodeDetailList('policy_institution_code');
*/

  String getCodeDetailName(String my_code_name, String my_code_detail) {
    int index_code = int.parse(my_code_detail);
    String code_detail_name =
        codeData["codes"][my_code_name][index_code]["code_detail_name"];
    return code_detail_name;
  }

  List<CodeDetailData> getCodeDetailList(String my_code_name) {
    List<dynamic> code_detail_list = codeData["codes"][my_code_name];
    List<CodeDetailData> result = [];

    for (var detail in code_detail_list) {
      CodeDetailData codeDetail = CodeDetailData(
        detailName: detail["code_detail_name"],
        code: detail["code_detail"],
        codeName: my_code_name,
      );
      result.add(codeDetail);
    }
    return result;
  }
}

final getMobileCodeService = getMobileCodeFunctions();

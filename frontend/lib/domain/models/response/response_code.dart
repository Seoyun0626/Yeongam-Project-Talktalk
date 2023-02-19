// import 'dart:convert';

// ResponseCode responseCodeFromJson(String str) =>
//     ResponseCode.fromJson(json.decode(str));

// String responseCodeToJson(ResponseCode data) => json.encode(data.toJson());

// class ResponseCode {
//   bool resp;
//   String message;
//   List<codeType> codes;

//   ResponseCode(
//       {required this.resp, required this.message, required this.codes});

//   factory ResponseCode.fromJson(Map<String, dynamic> json) => ResponseCode(
//       resp: json['resp'],
//       message: json['message'],
//       codes:
//           List<codeType>.from(json["codes"].map((x) => codeType.fromJson(x))));

//   Map<String, dynamic> toJson() => {
//         "resp": resp,
//         "message": message,
//         "codes": List<dynamic>.from(codes.map((x) => x.toJson()))
//       };
// }

// class codeType {
//   String code;
//   String code_name;
//   String code_english_name;
//   String code_desc;
//   String code_use_yn;

//   codeType(
//       {required this.code,
//       required this.code_name,
//       required this.code_english_name,
//       required this.code_desc,
//       required this.code_use_yn});

//   factory codeType.fromJson(Map<String, dynamic> json) => codeType(
//       code: json["code"],
//       code_name: json["code_name"],
//       code_english_name: json["code_english_name"],
//       code_desc: json["code_desc"],
//       code_use_yn: json["code_use_yn"]);

//   Map<String, dynamic> toJson() => {
//         'code': code,
//         'code_name': code_name,
//         'code_english_name': code_english_name,
//         'code_desc': code_desc,
//         'code_use_yn': code_use_yn
//       };
// }

import 'dart:convert';

ResponsePolicy responsePolicyFromJson(String str) =>
    ResponsePolicy.fromJson(json.decode(str));

String responsePolicyToJson(ResponsePolicy data) => json.encode(data.toJson());

class ResponsePolicy {
  bool resp;
  String message;
  List<Policy> policies;

  ResponsePolicy({
    required this.resp,
    required this.message,
    required this.policies,
  });

  factory ResponsePolicy.fromJson(Map<String, dynamic> json) => ResponsePolicy(
      resp: json["resp"],
      message: json["message"],
      policies:
          List<Policy>.from(json["policies"].map((x) => Policy.fromJson(x))));

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "policies": List<dynamic>.from(policies.map((x) => x.toJson())),
      };
}

class Policy {
  String policy_supervision; // 주최측
  String policy_name; // 정책 이름
  String application_start_date; // 모집 시작 날짜
  String application_end_date; // 모집 마감 날짜
  // String policy_target,
  String img; // 정책 대표 이미지

  Policy({
    required this.policy_supervision,
    required this.policy_name,
    required this.application_start_date,
    required this.application_end_date,
    // required this.policy_target,
    required this.img,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
      policy_supervision: json["policy_supervision"],
      policy_name: json["policy_name"],
      application_start_date: json["application_start_date"],
      application_end_date: json["application_end_date"],
      // policy_target: json["policy_target"],
      img: json["img"]);

  Map<String, dynamic> toJson() => {
        "policy_supervision": policy_supervision,
        "policy_name": policy_name,
        "application_start_date": application_start_date,
        "application_end_date": application_end_date,
        // "policy_target" : policy_target,
        "img:": img
      };
}

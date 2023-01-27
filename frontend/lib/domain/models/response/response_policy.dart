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
  String policy_name;
  String img;

  Policy({
    required this.policy_supervision,
    required this.policy_name,
    required this.img,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
      policy_supervision: json["policy_supervision"],
      policy_name: json["policy_name"],
      img: json["img"]);

  Map<String, dynamic> toJson() => {
        "policy_supervision": policy_supervision,
        "policy_name": policy_name,
        "img:": img
      };
}

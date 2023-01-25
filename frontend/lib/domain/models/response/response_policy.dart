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
            List<Policy>.from(json["policies"].map((x) => Policy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "policies": List<dynamic>.from(policies.map((x) => x.toJson())),
      };
}

class Policy {
  String policy_organizer; // 주최측
  String policy_name;
  String images;

  Policy({
    required this.policy_organizer,
    required this.policy_name,
    required this.images,
  });

  factory Policy.fromJson(Map<String, dynamic> json) => Policy(
      policy_organizer: json["policy_organizer"],
      policy_name: json["policy_name"],
      images: json["images"]);

  Map<String, dynamic> toJson() => {
        "policy_organizer": policy_organizer,
        "policy_name": policy_name,
        "images:": images
      };
}

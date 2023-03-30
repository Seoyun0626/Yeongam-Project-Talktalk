import 'dart:convert';

ResponsePolicyByUser responsePolicyByUserFromJson(String str) =>
    ResponsePolicyByUser.fromJson(json.decode(str));

String responsePolicyByUserToJson(ResponsePolicyByUser data) =>
    json.encode(data.toJson());

class ResponsePolicyByUser {
  ResponsePolicyByUser({
    required this.resp,
    required this.message,
    required this.policyUser,
  });

  bool resp;
  String message;
  List<PolicyUser> policyUser;

  factory ResponsePolicyByUser.fromJson(Map<String, dynamic> json) =>
      ResponsePolicyByUser(
        resp: json["resp"],
        message: json["message"],
        policyUser: List<PolicyUser>.from(
            json["policyUser"].map((x) => PolicyUser.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "policyUser": List<dynamic>.from(policyUser.map((x) => x.toJson())),
      };
}

class PolicyUser {
  PolicyUser({
    required this.postUid,
    required this.isComment,
    required this.typePrivacy,
    required this.createdAt,
    required this.personUid,
    required this.username,
    required this.avatar,
    required this.images,
    required this.countComment,
    required this.countLikes,
    required this.isLike,
  });

  String postUid;
  int isComment;
  String typePrivacy;
  DateTime createdAt;
  String personUid;
  String username;
  String avatar;
  String images;
  int countComment;
  int countLikes;
  int isLike;

  factory PolicyUser.fromJson(Map<String, dynamic> json) => PolicyUser(
        postUid: json["post_uid"],
        isComment: json["is_comment"],
        typePrivacy: json["type_privacy"],
        createdAt: DateTime.parse(json["created_at"]),
        personUid: json["person_uid"],
        username: json["username"],
        avatar: json["avatar"],
        images: json["images"],
        countComment: json["count_comment"],
        countLikes: json["count_likes"],
        isLike: json["is_like"],
      );

  Map<String, dynamic> toJson() => {
        "post_uid": postUid,
        "is_comment": isComment,
        "type_privacy": typePrivacy,
        "created_at": createdAt.toIso8601String(),
        "person_uid": personUid,
        "username": username,
        "avatar": avatar,
        "images": images,
        "count_comment": countComment,
        "count_likes": countLikes,
        "is_like": isLike,
      };
}

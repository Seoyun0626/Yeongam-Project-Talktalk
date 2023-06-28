import 'dart:convert';

ResponseEvent responseEventFromJson(String str) =>
    ResponseEvent.fromJson(json.decode(str));

String responseEventToJson(ResponseEvent data) => json.encode(data.toJson());

class ResponseEvent {
  bool resp;
  String message;
  String figCount;

  ResponseEvent({
    required this.resp,
    required this.message,
    required this.figCount, // 이벤트 별 지급하는 무화과 개수
  });

  factory ResponseEvent.fromJson(Map<String, dynamic> json) => ResponseEvent(
        resp: json["resp"],
        message: json["message"],
        figCount: json["figCount"],
      );

  Map<String, dynamic> toJson() => {
        "resp": resp,
        "message": message,
        "figCount": figCount,
      };
}

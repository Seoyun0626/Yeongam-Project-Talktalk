// import 'dart:convert';

// InvitationResponse responseLoginFromJson(String str) =>
//     InvitationResponse.fromJson(json.decode(str));

// String responseLoginToJson(InvitationResponse data) =>
//     json.encode(data.toJson());

// class InvitationResponse {
//   bool resp;
//   String message;
//   String inviter; //초대 한 사람
//   String invitee; //초대 받은 사람

//   InvitationResponse({
//     required this.resp,
//     required this.message,
//     required this.inviter,
//     required this.invitee,
//   });

//   factory InvitationResponse.fromJson(Map<String, dynamic> json) =>
//       InvitationResponse(
//           resp: json["resp"],
//           message: json["message"],
//           inviter: json["inviter"],
//           invitee: json["invitee"]);

//   Map<String, dynamic> toJson() => {
//         "resp": resp,
//         "message": message,
//         "inviter": inviter,
//         "invitee": invitee,
//       };
// }

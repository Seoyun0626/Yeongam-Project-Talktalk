import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/models/response/default_response.dart';

import 'package:teentalktalk/domain/models/response/response_event.dart';
import 'package:teentalktalk/data/env/env.dart';

class EventServices {
  // 무화과 지급 - 이벤트 참여
  Future<DefaultResponse> giveFig(String eid) async {
    print('giveFig');
    final token = await secureStorage.readToken();

    final resp = await http.post(
        Uri.parse('${Environment.urlApi}/event/give-fig/$eid'),
        headers: {'Accept': 'application/json', 'xxx-token': token!},
        body: {'eid': eid});
    // print(resp.body);
    return DefaultResponse.fromJson(jsonDecode(resp.body));
  }

  // 출석체크 기록 가져오기
  Future<List<DateTime>> getAttendance() async {
    final token = await secureStorage.readToken();

    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/event/get-attendance'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});

    final decodedJson = jsonDecode(resp.body);
    final attendanceLogJson = decodedJson['attendaceLog'] as List<dynamic>;
    final List<DateTime> attendanceLog = attendanceLogJson
        .map((log) => DateTime.parse(log['attendance_date'].toString()))
        .toList();
    // print(attendanceLog);
    return attendanceLog;
  }

  // 이벤트 참여 완료 확인

  // 사용자 무화과 내역 가져오기(지급, 사용)
  Future<ResponseEvent> getFigHistoryByUser() async {
    final token = await secureStorage.readToken();

    // print('getFigHistoryByUser');
    final resp = await http.get(
        Uri.parse('${Environment.urlApi}/event/get-fig-history-by-user'),
        headers: {'Accept': 'application/json', 'xxx-token': token!});
    print(resp.body);

    return ResponseEvent.fromJson(jsonDecode(resp.body));
  }
}

final eventService = EventServices();

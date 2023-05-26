import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EventCtroller extends GetxController {
  var week = ["일", "월", "화", "수", "목", "금", "토"];

  static DateTime now = DateTime.now();
  Rx<DateTime> now2 = DateTime.now().obs;

  RxInt year = 0.obs;
  RxInt month = 0.obs;
  RxList days = [].obs;

  // tb_attendance_logs에서 받아오기
  //
  RxList temp_days = [4, 6, 7].obs;

  @override
  void onInit() {
    super.onInit();
    setFirst(now.year, now.month);
  }

  setFirst(int setYear, int setMonth) {
    year.value = setYear;
    month.value = setMonth;
    insertDays(year.value, month.value);
  }

  // 일자 계산
  insertDays(int year, int month) {
    days.clear();

    /*
      이번달 채우기
      => 이번달의 마지막날을 구해 1일부터 마지막 날까지 추기
    */
    int lastDay = DateTime(year, month + 1, 0).day;
    for (var i = 1; i <= lastDay; i++) {
      days.add({
        "year": year,
        "month": month,
        "day": i,
        "inMonth": true,
        "picked": false.obs,
      });
    }

    /*
      이번달 1일의 요일 : DateTime(year, month, 1).weekday
      => 7이면(일요일) 상관x
      => 아니면 비어있는 요일만큼 지난달 채우기
    */
    if (DateTime(year, month, 1).weekday != 7) {
      var temp = [];
      int prevLastDay = DateTime(year, month, 0).day;
      for (var i = DateTime(year, month, 1).weekday - 1; i >= 0; i--) {
        temp.add({
          "year": year,
          "month": month - 1,
          "day": prevLastDay - i,
          "inMonth": false,
          "picked": false.obs,
        });
      }
      days = [...temp, ...days].obs;
    }

    /*
      6줄을 유지하기 위해 남은 날 채우기
      => 6*7 = 42. 42개까지
    */
    var temp = [];
    for (var i = 1; i <= 42 - days.length; i++) {
      temp.add({
        "year": year,
        "month": month + 1,
        "day": i,
        "inMonth": false,
        "picked": false.obs,
      });
    }

    days = [...days, ...temp].obs;
  }
}

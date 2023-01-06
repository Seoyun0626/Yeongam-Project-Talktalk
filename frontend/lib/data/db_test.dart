//전체 코드
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login/domain/network.dart';

class MyView extends StatefulWidget {
  @override
  State<MyView> createState() => _MyViewState();
}

class _MyViewState extends State<MyView> {
  //사용할 변수 미리 선언
  late String userName = '';
  late String userId = '';

  @override
  void initState() {
    super.initState();
    //state 진입시 api 데이터 파싱.
    getTestData();
  }

  getTestData() async {
    //url을 받아 데이터를 파싱하는 network 메소드 사용.
    //mysql db에서 유저 데이터를 받아오는 express api 호출
    Network network = Network('http://localhost:3000/get');

    var jsonData = await network.getJsonData();
    userName = await jsonData[1]['name'];
    userId = await jsonData[1]['userid'];
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            children: [
              Text(userName),
              Text(userId),
            ],
          ),
        ),
      ),
    );
  }
}

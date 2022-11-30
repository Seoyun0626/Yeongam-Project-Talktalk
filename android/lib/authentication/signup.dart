import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:yeongam_mobile/api/api.dart';
import 'package:yeongam_mobile/model/user.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  var formKey = GlobalKey<FormState>();

  var userNameController = TextEditingController();
  var userIDController = TextEditingController();
  var passwordController = TextEditingController();
  var emailController = TextEditingController();

  checkUSerID() async {
    try {
      var response = await http.post(
        Uri.parse(API.validateID),
        body: {
          'user_id': userIDController.text.trim()
        }
      );

      // flutter 통한 서버 통신 성공 여부
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);

        if (responseBody['existID'] == true) {
          Fluttertoast.showToast(
            msg: "이미 존재하는 아이디입니다.",
          );
        } else {
          saveInfo();
        }
      }
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  saveInfo() async{
    User userModel = User(
      1, //user+_no
      userNameController.text.trim(),
      userIDController.text.trim(),
      passwordController.text.trim(),
      emailController.text.trim(),
    );

    try{
      var res = await http.post(
        Uri.parse(API.signup),
        body : userModel.toJson()
      );

      if(res.statusCode == 200){
        var resSignup = jsonDecode(res.body);
        if(resSignup['success']==true){
          Fluttertoast.showToast(msg: '회원가입이 완료되었습니다.');
          setState(() {
            userNameController.clear();
            userIDController.clear();
            emailController.clear();
            passwordController.clear();
          });
        } else{
          Fluttertoast.showToast(msg: '회원가입에 실패하였습니다. 다시 시도해주세요.');
        }
      }
    } catch(e){
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.people_alt_rounded,
                  color: Colors.lightBlue,
                  size: 100,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  '회원가입',
                  // style: GoogleFonts.bebasNeue(fontSize: 36.0),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  '환영합니다!',
                  // style: GoogleFonts.bebasNeue(fontSize: 28),
                ),
                const SizedBox(
                  height: 50,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: userNameController,
                              validator: (val) =>
                              val == "" ? "이름을 입력해주세요" : null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: '이름'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: userIDController,
                              validator: (val) =>
                              val == "" ? "아이디를 입력해주세요" : null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: '아이디'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(12)),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: passwordController,
                              validator: (val) =>
                              val == "" ? "비밀번호를 입력해주세요" : null,
                              obscureText: true,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: '비밀번호'),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: TextFormField(
                              controller: emailController,
                              validator: (val) =>
                              val == "" ? "이메일을 입력해주세요" : null,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: '이메일'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    if(formKey.currentState!.validate()){
                      checkUSerID();
                    }
                  },
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12)),
                        child: const Center(
                          child: Text(
                            '회원가입',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('이미 가입하셨나요?'),
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: const Text(
                        ' 로그인 페이지로 돌아가기',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
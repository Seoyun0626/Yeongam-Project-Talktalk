import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import '../../../data/db_test.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('청소년톡talk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          // leading: IconButton(
          //   icon: Image.asset("images\aco.png", width: 50, height: 50),
          //   onPressed: () =>
          //       Navigator.push(context, routeSlide(page: const LoginPage())),
          // ),
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.perm_identity),
          //     // onPressed: () => Navigator.push(
          //     //     context, routeSlide(page: const LoginPage())),
          //     onPressed: () {

          //     },
          //   )
          // ],
          backgroundColor: ThemeColors.primary,
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50.0),
                const TextCustom(
                    text: 'MainPage',
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 28,
                    color: Color.fromARGB(255, 93, 73, 98)),
                const SizedBox(height: 30.0),
                BtnNaru(
                  text: '로그아웃',
                  colorText: Colors.black,
                  width: size.width,
                  onPressed: () {
                    authBloc.add(OnLogOutEvent());
                    userBloc.add(OnLogOutUser());
                    Navigator.pushAndRemoveUntil(context,
                        routeSlide(page: const MyPage()), (_) => false);
                  },
                ),
                const SizedBox(height: 30.0),
                // BtnNaru(
                //   text: '마이페이지',
                //   backgroundColor: ThemeColors.secondary,
                //   colorText: Colors.white,
                //   width: size.width,
                //   onPressed: () =>
                //       Navigator.push(context, routeSlide(page: MyView())),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/user/my_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import '../../../data/db_test.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: const Text('청소년톡talk',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              )),
          leading: InkWell(
            onTap: () =>
                Navigator.push(context, routeSlide(page: const LoginPage())),
            child: Image.asset('images/aco.png', height: 70),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.perm_identity),
              onPressed: () =>
                  Navigator.push(context, routeSlide(page: const LoginPage())),
            )
          ],
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
                        routeSlide(page: const HomePage()), (_) => false);
                    // if (State is LogOut) {
                    //   Navigator.pushAndRemoveUntil(context,
                    //       routeSlide(page: const LoginPage()), (_) => false);
                    // } else if (State is SuccessAuthentication) {
                    //   userBloc.add(OnGetUserAuthenticationEvent());
                    //   Navigator.pushAndRemoveUntil(context,
                    //       routeSlide(page: const MyPage()), (_) => false);
                    // }
                  },
                ),
                const SizedBox(height: 30.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

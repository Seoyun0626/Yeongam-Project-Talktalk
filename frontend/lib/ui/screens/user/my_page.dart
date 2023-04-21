import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/domain/services/user_services.dart';
import 'package:login/ui/helpers/modal_checkLogin.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/screens/user/privacy_setting_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text('마이 톡톡',
                  style: TextStyle(
                    color: ThemeColors.basic,
                    fontFamily: 'CookieRun',
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                  )),
              leading: InkWell(
                // onTap: () => Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const LoginPage(),
                //     )),
                child: Image.asset('images/aco.png', height: 70),
              ),
              backgroundColor: ThemeColors.primary,
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 30.0),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        const _UserName(),
                        BtnNaru(
                          text: '로그아웃',
                          colorText: Colors.black,
                          width: size.width,
                          onPressed: () {
                            authBloc.add(OnLogOutEvent());
                            userBloc.add(OnLogOutUser());
                            Navigator.pushAndRemoveUntil(
                              context,
                              routeFade(page: const HomePage()),
                              (_) => false,
                            );
                          },
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            bottomNavigationBar: const BottomNavigation(index: 5)));
  }
}

// 사용자 이름
class _UserName extends StatelessWidget {
  const _UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        if (state is LogOut) {
          // modalCheckLogin().showBottomDialog(context);
          return InkWell(
              child: Row(
                children: const [
                  TextCustom(
                    text: '로그인해주세요',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                  Icon(Icons.arrow_forward_ios_rounded)
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  routeSlide(page: const LoginPage()),
                ); //(_) => false);
              });
        } else {
          return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
            if (state.user?.user_name != null) {
              return InkWell(
                  child: Row(
                    children: [
                      TextCustom(
                        text: state.user!.user_name != ''
                            ? state.user!.user_name
                            : '사용자',
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacySettingPage(),
                        ));
                  });
            } else {
              return Container();
            }
          });
        }
      },
    );
  }
}

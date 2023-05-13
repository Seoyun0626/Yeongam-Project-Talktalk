import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/intro/checking_login_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/screens/user/privacy_setting_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
// class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final userBloc = BlocProvider.of<UserBloc>(context);
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text('마이 톡톡',
                  style: TextStyle(
                    color: ThemeColors.primary,
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
              backgroundColor: Colors.white, //ThemeColors.primary,
              centerTitle: false,
              elevation: 0.0,
              actions: <Widget>[
                IconButton(
                  icon: const Icon(
                    Icons.settings_outlined,
                    color: ThemeColors.primary,
                    size: 30,
                  ), // 장바구니 아이콘 생성
                  onPressed: () {
                    // 아이콘 버튼 실행
                  },
                ),
              ],
            ),
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: <Widget>[
                        Container(
                            padding: const EdgeInsets.fromLTRB(25, 40, 25, 25),
                            color: ThemeColors
                                .third, //Color.fromARGB(255, 226, 241, 200),
                            child: Column(
                              children: const [
                                _LogInOutUserName(),
                                // Row(
                                //   mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //   children: const [
                                //     _UserName(),
                                //     _LogInOut(),
                                //   ],
                                // ),
                                SizedBox(
                                  height: 30,
                                ),
                                _MyFig(),
                              ],
                            )),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: _YeongamWebsite(),
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

class _LogInOutUserName extends StatefulWidget {
  const _LogInOutUserName({
    Key? key,
  }) : super(key: key);
  @override
  State<_LogInOutUserName> createState() => _LogInOutUserNameState();
}

class _LogInOutUserNameState extends State<_LogInOutUserName> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        if (state is LogOut) {
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
              Navigator.push(context, routeSlide(page: const LoginPage()));
            },
          );
        } else {
          String username = userBloc.state.user?.user_name ?? '사용자 이름';
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Row(
                  children: [
                    TextCustom(
                      text: username,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
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
                },
              ),
              const SizedBox(width: 10),
              InkWell(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: ThemeColors.primary,
                      width: 2,
                    ),
                  ),
                  child: const TextCustom(
                    text: '로그아웃',
                    color: Colors.black,
                    fontSize: 13,
                  ),
                ),
                onTap: () {
                  authBloc.add(OnLogOutEvent());
                  userBloc.add(OnLogOutUser());
                  Navigator.pushAndRemoveUntil(
                    context,
                    routeFade(page: const HomePage()),
                    (_) => false,
                  );
                },
              ),
            ],
          );
        }
      },
    );
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
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const LoginPage(),
                //     ),
                //     (_) => false);
                Navigator.push(context, routeSlide(page: const LoginPage()));
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
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
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

// 로그인/로그아웃 버튼
class _LogInOut extends StatelessWidget {
  const _LogInOut({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
      if (state is LogOut) {
        return InkWell(
          child: Container(
            // height: 50,
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ThemeColors.primary,
                width: 2,
              ),
            ),
            child: const TextCustom(
              text: '로그인',
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          onTap: () {
            // Navigator.pushAndRemoveUntil(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const LoginPage(),
            //     ),
            //     (_) => false);
            Navigator.push(context, routeSlide(page: const LoginPage()));
          },
        );
      } else {
        return InkWell(
          child: Container(
            // height: 50,
            padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: ThemeColors.primary,
                width: 2,
              ),
            ),
            child: const TextCustom(
              text: '로그아웃',
              color: Colors.black,
              fontSize: 13,
            ),
          ),
          onTap: () {
            authBloc.add(OnLogOutEvent());
            userBloc.add(OnLogOutUser());
            Navigator.pushAndRemoveUntil(
              context,
              routeFade(page: const CheckingLoginPage()),
              (_) => false,
            );
          },
        );
      }
    });
  }
}

// 무화과 개수
class _MyFig extends StatelessWidget {
  const _MyFig({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return Center(
        child: InkWell(
      onTap: () {},
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextCustom(
                text: '나의 무화과',
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (_, state) {
                      if (state is LogOut) {
                        return const TextCustom(
                          text: '-',
                          fontSize: 40,
                          color: ThemeColors.basic,
                          fontWeight: FontWeight.bold,
                        );
                      } else {
                        return TextCustom(
                          text: userBloc.state.user?.fig ?? '',
                          fontSize: 40,
                          color: ThemeColors.basic,
                          fontWeight: FontWeight.bold,
                        );
                      }
                    },
                  ),

                  const Icon(
                    Icons.apple,
                    size: 50,
                    // color: Colors.purple[400],
                  )
                  // SvgPicture.asset(
                  //   'images/Fig.svg',
                  // )
                ],
              )
            ],
          )),
    ));
  }
}

class _YeongamWebsite extends StatelessWidget {
  const _YeongamWebsite({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          launchUrl(Uri.parse('https://www.yeongam.go.kr/'));
        },
        child: Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20),

              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.5),
              //     spreadRadius: 1,
              //     blurRadius: 5,
              //     offset: const Offset(0, 3),
              //   ),
              // ],
            ),
            child: Row(
              children: [
                Image.asset('images/namsaengs.png'),
                const SizedBox(
                  width: 10,
                ),
                const TextCustom(
                  text: '영암군 소식이 궁금하다면?',
                  fontSize: 16,
                )
              ],
            )));
  }
}

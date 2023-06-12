import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:teentalktalk/ui/screens/event/event_page.dart';
import 'package:teentalktalk/ui/screens/intro/checking_login_page.dart';
import 'package:teentalktalk/ui/screens/login/login_page.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/screens/settings/settings_page.dart';
import 'package:teentalktalk/ui/screens/event/fig_market_page.dart';
import 'package:teentalktalk/ui/screens/user/my_fig_history_page.dart';
import 'package:teentalktalk/ui/screens/user/privacy_setting_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
// class MyPage extends StatelessWidget {
  // final viewModel = MainViewModel(KakaoLogin()); // 카카오 로그인

  @override
  Widget build(BuildContext context) {
    // final userBloc = BlocProvider.of<UserBloc>(context);
    // final authBloc = BlocProvider.of<AuthBloc>(context);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              titleSpacing: 0,
              title: const Text('마이 톡talk',
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
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsPage(),
                        ));
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
                                SizedBox(
                                  height: 30,
                                ),
                                _MyFig(),
                              ],
                            )),
                        Padding(
                          padding: EdgeInsets.all(15.h),
                          child: Column(children: [
                            const _YeongamWebsite(),
                            SizedBox(
                              height: 15.h,
                            ),
                            const _FigMarket(),
                            SizedBox(
                              height: 15.h,
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.all(5),
                              leading: Image.asset(
                                'images/Fig2.png',
                                width: 35.w,
                                height: 35.h,
                              ),

                              // SvgPicture.asset(
                              //   'images/Fig.svg',
                              //   width: 35.w,
                              //   height: 35.h,
                              // ),
                              title: TextCustom(
                                text: "미션 성공하고",
                                fontSize: 10.sp,
                              ),
                              subtitle: TextCustom(
                                text: "무화과 따러가기",
                                fontSize: 20.sp,
                              ),
                              trailing: const Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: ThemeColors.basic),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const EventPage(),
                                    ));
                              },
                            ),
                            ListTile(
                              contentPadding: const EdgeInsets.all(5),
                              leading: Image.asset(
                                'images/aco5.png',
                                width: 40.w,
                                height: 40.h,
                              ),
                              title: TextCustom(
                                text: "개발자와 소통하기",
                                fontSize: 20.sp,
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: ThemeColors.basic,
                              ),
                              onTap: () {},
                            ),
                          ]),
                        ),
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
                    routeFade(page: const CheckingLoginPage()),
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
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   routeFade(page: const CheckingLoginPage()),
            //   (_) => false,
            // );
            // Navigator.pushNamedAndRemoveUntil(
            //   context,
            //   CheckingLoginPage.routeName,
            //   (_) => false,

            // );

            Navigator.of(context).pushNamedAndRemoveUntil(
              CheckingLoginPage.routeName,
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
    final authBloc = BlocProvider.of<AuthBloc>(context);

    return Center(
        child: InkWell(
      onTap: () {
        if (authBloc.state is LogOut) {
          // 로그인 상태 아닐 경우
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => MyFigHistoryPage(),
          //     ));
        } else {
          // 로그인 상태일 경우 MyFigListPage 이동
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyFigHistoryPage(),
              ));
        }
      },
      child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.r),
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
                        final figCount = userBloc.state.user?.fig ?? '';

                        return TextCustom(
                          text: figCount,
                          fontSize: 40,
                          color: ThemeColors.basic,
                          fontWeight: FontWeight.bold,
                        );
                      }
                    },

                    // 무화과 개수가 업데이트될 때마다 OnUpdateFigCountEvent 이벤트 호출
                    // userBloc을 통해 tb_user의 fig 열을 업데이트
                    // userBloc.add(OnUpdateFigCountEvent(figCount)),
                    // userBloc: userBloc,
                  ),

                  // const Icon(
                  //   Icons.apple,
                  //   size: 50,
                  //   // color: Colors.purple[400],
                  // )
                  // SvgPicture.asset(
                  //   'images/Fig.svg',
                  // )
                  Image.asset(
                    'images/Fig2.png',
                    height: 40.h,
                  ),
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
    final yeongamUrl = Uri.parse('https://www.yeongam.go.kr/');
    return InkWell(
        onTap: () {
          launchUrl(
            yeongamUrl,
            mode: LaunchMode.externalApplication,
          );
          // launchUrl(Uri.parse('https://www.yeongam.go.kr/'));
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

class _FigMarket extends StatelessWidget {
  const _FigMarket({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10.h),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
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
          Container(
            margin: EdgeInsets.only(top: 5.h, left: 10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/my_page_market.svg',
                      height: 25.h,
                      width: 25.w,
                    ),
                    SizedBox(
                      width: 4.w,
                    ),
                    const TextCustom(
                      text: "무화과 잡화점",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(5.h),
                  child: const TextCustom(
                    text: "내가 모은 무화과로 쇼핑해요!",
                    fontSize: 15,
                    color: ThemeColors.basic,
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Padding(
                padding: EdgeInsets.all(10.h),
                child: SvgPicture.asset(
                  'images/my_page_shopping_cart.svg',
                  width: 60.w,
                  height: 60.h,
                )),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            child: Align(
              alignment: Alignment.center,
              child: BtnNaru(
                text: "쇼핑하러 가기",
                colorText: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                width: 120.w,
                height: 30.h,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FigMarketPage(),
                      ));
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

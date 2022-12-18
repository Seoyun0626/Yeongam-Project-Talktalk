import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/register/start_register.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import '../../helpers/animation_route.dart';


class StartLoginPage extends StatelessWidget {

  const StartLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
                children: [
                  Container(
                    padding : const EdgeInsets.symmetric(horizontal:20),
                    height : 55,
                    width : size.width,
                    child : Row(
                      // children: [
                      //   Image.asset('assets/img/yeongam_logo.jpeg', height: 30),
                      // ],
                    ),
                  ),

                  const TextCustom(
                    text: '반갑습니다!',
                    letterSpacing: 2.0,
                    color: ThemeColors.secondary,
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                  const TextCustom(
                    text: '앱 이름입니다.',
                    letterSpacing: 2.0,
                    color: ThemeColors.primary,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                  ),

                  const SizedBox(height: 10.0,),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: TextCustom(
                      text: ('청소년(부모) 복지 정책 정보 제공 플랫폼'),
                      textAlign : TextAlign.center,
                      maxLines: 2,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 100.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      height: 50,
                      width: size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:ThemeColors.secondary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                        ),
                        child: const TextCustom(text: '로그인', color: Colors.white, fontSize: 20),
                        onPressed: () => Navigator.push(context, routeSlide(page: const LoginPage())),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: SizedBox(
                      height: 50,
                      width: size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:Colors.amber,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0))
                        ),
                        child: const TextCustom(text: '카카오톡 로그인', color: Colors.black, fontSize: 20),
                        onPressed: () => Navigator.push(context, routeSlide(page: const LoginPage())),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Container(
                      height: 50,
                      width: size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(color: ThemeColors.secondary, width: 1.5)
                      ),
                      child: TextButton(
                        child: const TextCustom(text: '회원가입', color: ThemeColors.secondary, fontSize: 20),
                        onPressed: () => Navigator.push(context, routeSlide(page: const StartRegisterPage())),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),


                ])
        )
    );
  }
}
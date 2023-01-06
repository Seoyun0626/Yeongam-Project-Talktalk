// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:login/ui/helpers/helpers.dart';
// import 'package:login/ui/screens/login/login_page.dart';
// import 'package:login/ui/screens/register//info_first.dart';
// import 'package:login/ui/themes/theme_colors.dart';
// import 'package:login/ui/widgets/widgets.dart';

// import '../../helpers/animation_route.dart';

// class userTypePage extends StatelessWidget {
//   const userTypePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           title: const Text('회원가입',
//               style: TextStyle(color: Colors.black, fontSize: 20)),
//           backgroundColor: ThemeColors.primary,
//           centerTitle: false,
//           elevation: 0.0,
//         ),
//         body: SafeArea(
//             child: Column(children: [
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             height: 50,
//             width: size.width,
//             child: Row(
//                 // children: [
//                 //   Image.asset('assets/img/yeongam_logo.jpeg', height: 30),
//                 // ],
//                 ),
//           ),

//           // const TextCustom(
//           //   text: '',
//           //   letterSpacing: 2.0,
//           //   color: ThemeColors.primary,
//           //   fontWeight: FontWeight.w100,
//           //   fontSize: 30,
//           //   textAlign: TextAlign.left,
//           // ),
//           const TextCustom(
//             text: '회원가입',
//             letterSpacing: 2.0,
//             color: Colors.black,
//             fontWeight: FontWeight.w900,
//             fontSize: 30,
//           ),

//           const SizedBox(
//             height: 25.0,
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: TextCustom(
//               text: ('회원 유형에 따라 가입 절차가 다르니'),
//               // textAlign : TextAlign.center,
//               maxLines: 2,
//               fontSize: 17,
//             ),
//           ),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: TextCustom(
//               text: ('본인에 해당하는 회원 유형을 선택해주세요.'),
//               // textAlign : TextAlign.center,
//               maxLines: 2,
//               fontSize: 17,
//             ),
//           ),
//           const SizedBox(height: 50.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: SizedBox(
//               height: 50,
//               width: size.width,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                     backgroundColor: ThemeColors.secondary,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0))),
//                 child: const TextCustom(
//                     text: '청소년', color: Colors.white, fontSize: 20),
//                 onPressed: () => Navigator.push(
//                     context, routeSlide(page: const RegisterPage())),
//               ),
//             ),
//           ),

//           const SizedBox(height: 30.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: SizedBox(
//               height: 50,
//               width: size.width,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                     backgroundColor: Colors.blue[100],
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0))),
//                 child: const TextCustom(
//                     text: '청소년 부모', color: Colors.black, fontSize: 20),
//                 onPressed: () => Navigator.push(
//                     context, routeSlide(page: const RegisterPage())),
//               ),
//             ),
//           ),

//           const SizedBox(height: 30.0),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0),
//             child: SizedBox(
//               height: 50,
//               width: size.width,
//               child: TextButton(
//                 style: TextButton.styleFrom(
//                     backgroundColor: Colors.amber[100],
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12.0))),
//                 child: const TextCustom(
//                     text: '부모', color: Colors.black, fontSize: 20),
//                 onPressed: () => Navigator.push(
//                     context, routeSlide(page: const RegisterPage())),
//               ),
//             ),
//           ),
//         ])));
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/register//terms_agree.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import 'package:login/ui/helpers/animation_route.dart';

class userTypePage extends StatelessWidget {
  const userTypePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
            child: Column(children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: size.width,
            child: Row(
                // children: [
                //   Image.asset('assets/img/yeongam_logo.jpeg', height: 30),
                // ],
                ),
          ),

          // const TextCustom(
          //   text: '앱 이름',
          //   letterSpacing: 2.0,
          //   color: ThemeColors.primary,
          //   fontWeight: FontWeight.w100,
          //   fontSize: 30,
          //   textAlign: TextAlign.left,
          // ),
          const TextCustom(
            text: '회원가입',
            letterSpacing: 2.0,
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 30,
          ),

          const SizedBox(
            height: 25.0,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextCustom(
              text: ('회원 유형에 따라 가입 절차가 다르니'),
              // textAlign : TextAlign.center,
              maxLines: 2,
              fontSize: 17,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextCustom(
              text: ('본인에 해당하는 회원 유형을 선택해주세요.'),
              // textAlign : TextAlign.center,
              maxLines: 2,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SizedBox(
              height: 60,
              width: size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: ThemeColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const TextCustom(
                        text: '청소년', color: Colors.black, fontSize: 20),
                    const TextCustom(
                        text: '24세 이하', color: Colors.black, fontSize: 15),
                  ],
                ),
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const termsAgreePage())),
              ),
            ),
          ),

          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SizedBox(
              height: 60,
              width: size.width,
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: ThemeColors.secondary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const TextCustom(
                        text: '청소년부모', color: Colors.white, fontSize: 20),
                    const TextCustom(
                        text: '24세 이하의 부모', color: Colors.white, fontSize: 15),
                  ],
                ),
                onPressed: () => Navigator.push(
                    context, routeSlide(page: const termsAgreePage())),
              ),
            ),
          ),

          const SizedBox(height: 30.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: SizedBox(
                height: 60,
                width: size.width,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: ThemeColors.third,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const TextCustom(
                          text: '학부모', color: Colors.white, fontSize: 20),
                      const TextCustom(
                          text: '재학 중인 자녀를 둔 일반 학부모',
                          color: Colors.white,
                          fontSize: 15),
                    ],
                  ),
                  onPressed: () => Navigator.push(
                      context, routeSlide(page: const termsAgreePage())),
                )),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
          //   child: SizedBox(
          //     height: 50,
          //     width: size.width,
          //     child: TextButton(
          //       style: TextButton.styleFrom(
          //           backgroundColor: Colors.amber[100],
          //           shape: RoundedRectangleBorder(
          //               borderRadius: BorderRadius.circular(12.0))),
          //       child: const TextCustom(
          //           text: '부모', color: Colors.black, fontSize: 20),
          //       onPressed: () => Navigator.push(
          //           context, routeSlide(page: const RegisterPage())),
          //     ),
          //   ),
          // ),
        ])));
  }
}

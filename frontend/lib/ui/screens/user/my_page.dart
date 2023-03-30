import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/domain/services/user_services.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

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

    return BlocListener<UserBloc, UserState>(
      listener: ((context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, '로딩 중');
        }
        if (state is SuccessUserState) {
          modalSuccess(context, '이미지 업데이트',
              onPressed: () => Navigator.pop(context));
        }
        if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      }),
      child: Scaffold(
          appBar: AppBar(
            title: const Text('마이 페이지',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                )),
            leading: IconButton(
                icon: const Icon(Icons
                    .arrow_back_ios), //Image.asset("images\aco.png", width: 50, height: 50),
                onPressed: () => Navigator.pop(context)
                // Navigator.push(context, routeSlide(page: const LoginPage())),
                ),
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
          body: ListView(
            children: const [
              SizedBox(
                height: 10.0,
              ),
              _UserName(),
            ],
          ),
          bottomNavigationBar: const BottomNavigation(index: 5)),
    );
  }
}

//     MaterialApp(
//       home: Scaffold(
//           appBar: AppBar(
//             title: const Text('마이 페이지',
//                 style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w700,
//                 )),
//             leading: IconButton(
//                 icon: const Icon(Icons
//                     .arrow_back_ios), //Image.asset("images\aco.png", width: 50, height: 50),
//                 onPressed: () => Navigator.pop(context)
//                 // Navigator.push(context, routeSlide(page: const LoginPage())),
//                 ),
//             // actions: [
//             //   IconButton(
//             //     icon: const Icon(Icons.perm_identity),
//             //     // onPressed: () => Navigator.push(
//             //     //     context, routeSlide(page: const LoginPage())),
//             //     onPressed: () {

//             //     },
//             //   )
//             // ],
//             backgroundColor: ThemeColors.primary,
//             centerTitle: false,
//             elevation: 0.0,
//           ),
//           body: SafeArea(
//             child: Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 50.0),
//                   const TextCustom(
//                       text: 'MyPage',
//                       letterSpacing: 1.5,
//                       fontWeight: FontWeight.w500,
//                       fontSize: 28,
//                       color: Color.fromARGB(255, 93, 73, 98)),
//                   const SizedBox(height: 30.0),
//                   const _UserName(),
//                   const SizedBox(height: 30.0),
//                   BtnNaru(
//                     text: '로그아웃',
//                     colorText: Colors.black,
//                     width: size.width,
//                     onPressed: () {
//                       authBloc.add(OnLogOutEvent());
//                       userBloc.add(OnLogOutUser());
//                       // Navigator.pop(context);
//                       Navigator.pushAndRemoveUntil(context,
//                           routeFade(page: const HomePage()), (_) => false);
//                     },
//                   ),
//                   const SizedBox(height: 30.0),
//                   // BtnNaru(
//                   //   text: '마이페이지',
//                   //   backgroundColor: ThemeColors.secondary,
//                   //   colorText: Colors.white,
//                   //   width: size.width,
//                   //   onPressed: () =>
//                   //       Navigator.push(context, routeSlide(page: MyView())),
//                   // ),
//                 ],
//               ),
//             ),
//           ),
//           bottomNavigationBar: const BottomNavigation(index: 5)),
//     );
//   }
// }

// 사용자 이름
class _UserName extends StatelessWidget {
  const _UserName({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      BlocBuilder<UserBloc, UserState>(
          builder: (_, state) => (state.user?.name != null)
              ? TextCustom(
                  text: state.user?.name != '' ? state.user!.name : '사용자')
              : const CircularProgressIndicator()),
    ]);
  }
}

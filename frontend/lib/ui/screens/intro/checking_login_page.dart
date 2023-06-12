import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/helpers/get_mobile_code_data.dart';
import 'package:teentalktalk/ui/screens/home/home_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import '../../helpers/animation_route.dart';

class CheckingLoginPage extends StatefulWidget {
  static const routeName = '/checking_login_page';
  const CheckingLoginPage({Key? key}) : super(key: key);

  @override
  State<CheckingLoginPage> createState() => _CheckingLoginPageState();
}

class _CheckingLoginPageState extends State<CheckingLoginPage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    getMobileCodeService.getCodeData();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // print(state);

        if (state is LogOut) {
          print(state);
          Navigator.pushAndRemoveUntil(
              context, routeFade(page: const HomePage()), (_) => false);
        } else if (state is SuccessAuthentication) {
          print(state);
          userBloc.add(OnGetUserAuthenticationEvent());
          Navigator.pushAndRemoveUntil(
              context, routeFade(page: const HomePage()), (_) => false);
        }
      },
      child: Scaffold(
          body: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Colors.red,
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      colors: [
                        ThemeColors.secondary,
                        ThemeColors.primary,
                        Colors.white
                      ])),
              child: Container())),

      // SizedBox(
      //   height: MediaQuery.of(context).size.height,
      //   width: MediaQuery.of(context).size.width,
      //   child: Image.asset(
      //     'images/Splash.jpg',
      //     fit: BoxFit.fill,
      //   ),
      // child: SvgPicture.asset(
      //   'images/Splash.svg',
      //   fit: BoxFit.fill,
      // )

      // decoration: const BoxDecoration(
      //   color: Colors.red,
      //   gradient: LinearGradient(begin: Alignment.bottomCenter, colors: [
      //     ThemeColors.secondary,
      //     ThemeColors.primary,
      //     Colors.white
      //   ]),
      // ),
      // Center(
      //   child: SizedBox(
      //     height: 200,
      //     width: 150,

      // child: Column(
      //   children: [
      //     AnimatedBuilder(
      //         animation: _animationController,
      //         builder: (_, child) => Transform.scale(
      //               scale: _scaleAnimation.value,
      //               // child: Image.asset('assets/img/yeongam_logo.jpeg')
      //             )),
      //     const SizedBox(height: 10.0),
      //     const TextCustom(text: '확인중...', color: Colors.black)
      //   ],
      // ),
      // ),
    );
  }
}

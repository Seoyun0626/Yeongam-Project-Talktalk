import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:login/domain/models/response/response_user.dart';
import 'package:login/domain/services/policy_services.dart';
import 'package:login/domain/services/user_services.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class PrivacySettingPage extends StatefulWidget {
  const PrivacySettingPage({Key? key}) : super(key: key);

  @override
  State<PrivacySettingPage> createState() => _PrivacySettingPageState();
}

class _PrivacySettingPageState extends State<PrivacySettingPage> {
  @override
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
          Navigator.pop(context);
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
            titleSpacing: 0,
            title: const Text('개인정보설정',
                style: TextStyle(
                  color: ThemeColors.basic,
                  fontFamily: 'CookieRun',
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                )),
            // leading: InkWell(
            //   // onTap: () => Navigator.push(
            //   //     context,
            //   //     MaterialPageRoute(
            //   //       builder: (context) => const LoginPage(),
            //   //     )),
            //   child: Image.asset('images/aco.png', height: 70),
            // ),
            backgroundColor: ThemeColors.primary,
            centerTitle: false,
            elevation: 0.0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 30.0,
                ),
                Expanded(
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                      const _UserName(),
                    ]))
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavigation(index: 5)),
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
    return Column(children: [
      BlocBuilder<UserBloc, UserState>(
          // builder: (
          //   FutureBuilder<ResponseUser>(
          //     future: userService.getUserById(),
          //     builder: (_, snapshot){

          //     },)),

          builder: (_, state) => (state.user?.user_name != null)
              ? TextCustom(
                  text: state.user!.user_name != ''
                      ? state.user!.user_name
                      : '로그인해주세요',
                  fontSize: 22,
                  fontWeight: FontWeight.w500)
              : const CircularProgressIndicator(
                  color: ThemeColors.primary,
                )),
    ]);
  }
}

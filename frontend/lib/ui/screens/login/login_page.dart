import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/login/find_pw_page.dart';
import 'package:login/ui/screens/login/find_id_page.dart';
import 'package:login/ui/screens/login/find_pw_page.dart';
import 'package:login/ui/screens/register/start_register.dart';
import 'package:login/ui/screens/login/verify_email_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController idController;
  late TextEditingController passwordController;
  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    idController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    idController.clear();
    idController.dispose();
    passwordController.clear();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoadingAuthentication) {
          modalLoading(context, '확인 중...');
        } else if (state is FailureAuthentication) {
          // print('login-page');
          // print(context);
          // print(state);
          // print('login-page');
          // modalWarning(context, '로그인 실패');

          Navigator.pop(context);
          modalWarning(context, '다시 로그인해주세요');

          if (state.error == '메일을 확인해주세요') {
            Navigator.push(
                context,
                routeSlide(
                    page:
                        VerifyEmailPage(user_email: idController.text.trim())));
          }

          errorMessageSnack(context, state.error);
        } else if (state is SuccessAuthentication) {
          print(state);
          userBloc.add(OnGetUserAuthenticationEvent());
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context, routeSlide(page: const HomePage()), (_) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.0),
                    const TextCustom(
                        text: '청소년톡talk',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.black),
                    const SizedBox(height: 10.0),
                    const TextCustom(
                      text: '로그인',
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.w400,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 50.0), // 아이디
                    TextFieldNaru(
                      controller: idController,
                      hintText: '아이디 입력',
                      // keyboardType: TextInputType.emailAddress,
                      // validator: validatedEmail,
                    ),
                    const SizedBox(height: 10.0), // 비밀번호
                    TextFieldNaru(
                      controller: passwordController,
                      hintText: '비밀번호 입력',
                      isPassword: true,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 40.0),
                    BtnNaru(
                      text: '로그인',
                      width: size.width,
                      colorText: Colors.black,
                      onPressed: () {
                        if (_keyForm.currentState!.validate()) {
                          authBloc.add(OnLoginEvent(idController.text.trim(),
                              passwordController.text.trim()));
                        }
                      },
                    ),
                    const SizedBox(height: 40.0),

                    SizedBox(
                      height: 50,
                      width: size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(247, 225, 17, 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0))),
                        child: const TextCustom(
                            text: '카카오톡으로 로그인하기',
                            color: Colors.black,
                            fontSize: 20),
                        onPressed: () => Navigator.push(
                            context, routeSlide(page: const LoginPage())),
                      ),
                    ),

                    const SizedBox(height: 60.0), // 비밀번호 찾기

                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                              onTap: () => Navigator.push(context,
                                  routeSlide(page: const FindIDPage())),
                              child: const TextCustom(text: '아이디 찾기')),
                          InkWell(
                              onTap: () => Navigator.push(context,
                                  routeSlide(page: const FindPasswordPage())),
                              child: const TextCustom(text: '비밀번호 찾기')),
                          InkWell(
                              onTap: () => Navigator.push(context,
                                  routeSlide(page: const StartRegisterPage())),
                              child: const TextCustom(text: '회원가입'))
                        ]),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

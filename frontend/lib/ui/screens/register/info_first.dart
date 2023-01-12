import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/verify_email_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/home/home_page.dart';
import 'package:login/ui/screens/register/info_parents.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class RegisterPage1 extends StatefulWidget {
  const RegisterPage1({Key? key}) : super(key: key);

  @override
  State<RegisterPage1> createState() => _RegisterPageState1();
}

class _RegisterPageState1 extends State<RegisterPage1> {
  late TextEditingController userIDController;
  late TextEditingController userPWController;
  late TextEditingController userAgainPWController;
  late TextEditingController userEmailController;
  late TextEditingController userNameController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    userAgainPWController = TextEditingController();
    userEmailController = TextEditingController();
    userNameController = TextEditingController();
  }

  @override
  void dispose() {
    userIDController.dispose();
    userPWController.dispose();
    userAgainPWController.dispose();
    userEmailController.dispose();
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, '로드 중');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, '회원가입이 완료되었습니다',
              onPressed: () =>
                  Navigator.push(context, routeSlide(page: const HomePage())));
          // Navigator.push(
          //     context,
          //     routeSlide(
          //         page: VerifyEmailPage(
          //             user_email: userEmailController.text.trim()))));
        } else if (state is FailureUserState) {
          Navigator.pop(context);
          errorMessageSnack(context, state.error);
        }
      },
      child: Scaffold(
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
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(
                        text: '회원가입',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.black),
                    const SizedBox(height: 50.0),
                    const TextCustom(
                      text: '아이디를 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200.0,
                          child: TextFieldNaru(
                            controller: userIDController,
                            hintText: '아이디',
                            validator: RequiredValidator(errorText: ' '),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: BtnNaru(
                            text: '중복확인',
                            fontSize: 17,
                            width: 103,
                            colorText: Colors.black,
                            onPressed: () => Navigator.pop(context), //수정필요
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '비밀번호를 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFieldNaru(
                      controller: userPWController,
                      hintText: '8자리 이상 입력',
                      isPassword: true,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 10.0),
                    TextFieldNaru(
                      controller: userAgainPWController,
                      hintText: '비밀번호 확인',
                      isPassword: true,
                      validator: againpasswordValidator,
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '이름을 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFieldNaru(
                      controller: userNameController,
                      hintText: '이름',
                      validator: RequiredValidator(errorText: ' '),
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '이메일을 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFieldNaru(
                      controller: userEmailController,
                      hintText: '이메일',
                      keyboardType: TextInputType.emailAddress,
                      validator: validatedEmail,
                    ),
                    const SizedBox(height: 60.0),
                    BtnNaru(
                        text: '다음',
                        width: size.width,
                        colorText: Colors.black,
                        // onPressed: () => {
                        //   Navigator.push(
                        //       context, routeSlide(page: const RegisterPage2()))
                        // },

                        // kth - register(signup) test
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(OnRegisterUserEvent(
                              userIDController.text.trim(),
                              userNameController.text.trim(),
                              userEmailController.text.trim(),
                              userPWController.text.trim(),
                              userAgainPWController.text.trim(),
                              '0',
                              '0',
                              '0',
                              '0',
                            ));
                          }
                        }),
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

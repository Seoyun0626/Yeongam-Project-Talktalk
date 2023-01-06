import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
// import 'package:login/ui/screens/login/verify_email_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController userIDController;
  late TextEditingController userPWController;
  late TextEditingController userEmailController;
  late TextEditingController userNameController;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    userEmailController = TextEditingController();
    userNameController = TextEditingController();
  }

  @override
  void dispose() {
    userIDController.dispose();
    userPWController.dispose();
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
                  Navigator.push(context, routeSlide(page: const LoginPage()))
              // VerifyEmailPage(user_email: userEmailController.text.trim())))
              );
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
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(
                        text: '안녕하세요!',
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                        fontSize: 28,
                        color: ThemeColors.secondary),
                    const SizedBox(height: 10.0),
                    const TextCustom(
                      text: '회원가입',
                      fontSize: 17,
                      letterSpacing: 1.0,
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldNaru(
                      controller: userIDController,
                      hintText: '아이디',
                      validator: RequiredValidator(errorText: '아이디는 필수 항목입니다'),
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldNaru(
                      controller: userNameController,
                      hintText: '이름',
                      validator: RequiredValidator(errorText: '이름은 필수 항목입니다.'),
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldNaru(
                      controller: userEmailController,
                      hintText: '이메일',
                      keyboardType: TextInputType.emailAddress,
                      validator: validatedEmail,
                    ),
                    const SizedBox(height: 40.0),
                    TextFieldNaru(
                      controller: userPWController,
                      hintText: '비밀번호',
                      isPassword: true,
                      validator: passwordValidator,
                    ),
                    const SizedBox(height: 60.0),
                    const TextCustom(
                      text: '회원가입 시 서비스 약관 및 개인 정보 보호 정책에 동의하게 됩니다.',
                      fontSize: 15,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 20.0),
                    BtnNaru(
                        text: '회원가입',
                        width: size.width,
                        colorText: Colors.black,
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(OnRegisterUserEvent(
                                userIDController.text.trim(),
                                userPWController.text.trim(),
                                userEmailController.text.trim(),
                                userNameController.text.trim()));
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

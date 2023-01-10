import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
// import 'package:login/ui/screens/login/verify_email_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

class RegisterPage2 extends StatefulWidget {
  const RegisterPage2({Key? key}) : super(key: key);

  @override
  State<RegisterPage2> createState() => _RegisterPageState2();
}

class NumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex <= 3) {
        if (nonZeroIndex % 3 == 0 && nonZeroIndex != text.length) {
          buffer.write('-'); // Add double spaces.
        }
      } else {
        if (nonZeroIndex % 7 == 0 &&
            nonZeroIndex != text.length &&
            nonZeroIndex > 4) {
          buffer.write('-');
        }
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: TextSelection.collapsed(offset: string.length));
  }
}

class _RegisterPageState2 extends State<RegisterPage2> {
  late TextEditingController userIDController;
  late TextEditingController userPWController;
  late TextEditingController userAgainPWController;
  late TextEditingController userEmailController;
  late TextEditingController userNameController;
  String result = '';
  bool isElement = true;
  bool isMiddle = false;
  bool isHigh = false;
  bool isOutside = false;
  late List<bool> isSelected;

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    userAgainPWController = TextEditingController();
    userEmailController = TextEditingController();
    userNameController = TextEditingController();
    isSelected = [isElement, isMiddle, isHigh, isOutside];
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

    //토글버튼 선택 시 (수정해야함)
    void toggleSelect(value) {
      if (value == 0) {
        isElement = true;
        isMiddle = false;
      } else {
        isElement = false;
        isMiddle = true;
      }
      setState(() {
        isSelected = [isElement, isMiddle];
      });
    }

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
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 40.0),
            child: SingleChildScrollView(
              child: Form(
                key: _keyForm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextCustom(
                        text: '회원가입2 필수x',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.black),
                    const SizedBox(height: 50.0),
                    const TextCustom(
                      text: '전화번호를 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 15,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, //숫자만!
                        NumberFormatter(), // 자동하이픈
                        LengthLimitingTextInputFormatter(
                            13) //13자리만 입력받도록 하이픈 2개+숫자 11개
                      ],
                      // ignore: prefer_const_constructors
                      decoration: InputDecoration(
                        // ignore: prefer_const_constructors
                        icon: Icon(
                          Icons.phone_iphone,
                          color: ThemeColors.primary,
                        ),
                        hintText: "010-xxxx-xxxx",
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: ThemeColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    const TextCustom(
                      text: '나이 선택',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    ToggleButtons(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('미터법', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child:
                                Text('파운드법', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child:
                                Text('파운드법', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child:
                                Text('파운드법', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child:
                                Text('파운드법', style: TextStyle(fontSize: 18))),
                      ],
                      isSelected: isSelected,
                      onPressed: toggleSelect,
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '성별을 선택해주세요.',
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
                      text: '거주지를 선택해주세요.',
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
                      text: '완료',
                      width: size.width,
                      colorText: Colors.black,
                      onPressed: () => {
                        Navigator.push(
                            context, routeSlide(page: const RegisterPage2()))
                      },
                    ),
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

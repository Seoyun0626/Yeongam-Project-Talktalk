import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/verify_email_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';

import 'info_first.dart';

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
  bool isMan = true;
  bool isWoman = false;

  final List<String> _valueList1 = [
    '영암읍',
    '삼호읍',
    '덕진면',
    '금정면',
    '신북면',
    '시종면',
    '도포면',
    '군서면',
    '서호면',
    '학산면',
    '미암면'
  ];
  String _selectedValue1 = '영암읍';

  late List<bool> _selections1 = List.generate(4, (index) => false); //재학여부구분
  late List<bool> isSelected; //성별구분
  late List<bool> _selections2 = List.generate(6, (index) => false); //나이구분

  final _keyForm = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    userIDController = TextEditingController();
    userPWController = TextEditingController();
    userAgainPWController = TextEditingController();
    userEmailController = TextEditingController();
    userNameController = TextEditingController();
    isSelected = [isMan, isWoman];
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
        isMan = true;
        isWoman = false;
      } else {
        isMan = false;
        isWoman = true;
      }
      setState(() {
        isSelected = [isMan, isWoman];
      });
    }

    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState) {
          modalLoading(context, '로드 중');
        } else if (state is SuccessUserState) {
          Navigator.pop(context);
          modalSuccess(context, '회원가입이 완료되었습니다',
              onPressed: () => Navigator.pushAndRemoveUntil(
                  context, routeSlide(page: const LoginPage()), (_) => false)
              // Navigator.push(
              //     context,
              //     routeSlide(
              //         page: VerifyEmailPage(
              //             user_email: userEmailController.text.trim())))
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
                        text: '회원가입',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                        color: Colors.black),
                    const SizedBox(height: 5.0),
                    const TextCustom(
                        text: '필수가 아닌 항목입니다.',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
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
                      text: '재학 여부를 선택해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 5.0),
                    const TextCustom(
                      text: '청소년, 청소년부모만 해당',
                      fontSize: 13,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    ToggleButtons(
                      selectedColor: ThemeColors.primary,
                      selectedBorderColor: ThemeColors.primary,
                      fillColor: ThemeColors.primary.withOpacity(0.08),
                      splashColor: ThemeColors.primary.withOpacity(0.12),
                      hoverColor: ThemeColors.primary.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(4.0),
                      constraints:
                          BoxConstraints(minWidth: 59, minHeight: 40.0),
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('초', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('중', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('고', style: TextStyle(fontSize: 18))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Text('기타(학교밖)',
                                style: TextStyle(fontSize: 18))),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          _selections1[index] = !_selections1[index];
                        });
                      },
                      isSelected: _selections1,
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '나이를 선택해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    ToggleButtons(
                      selectedColor: ThemeColors.primary,
                      selectedBorderColor: ThemeColors.primary,
                      fillColor: ThemeColors.primary.withOpacity(0.08),
                      splashColor: ThemeColors.primary.withOpacity(0.12),
                      hoverColor: ThemeColors.primary.withOpacity(0.04),
                      borderRadius: BorderRadius.circular(4.0),
                      constraints: BoxConstraints(minHeight: 40.0),
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text('10대', style: TextStyle(fontSize: 12))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text('20대', style: TextStyle(fontSize: 13))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text('30대', style: TextStyle(fontSize: 13))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text('40대', style: TextStyle(fontSize: 13))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text('50대', style: TextStyle(fontSize: 13))),
                        Padding(
                            padding: EdgeInsets.symmetric(horizontal: 11),
                            child: Text('60대', style: TextStyle(fontSize: 13))),
                      ],
                      onPressed: (int index) {
                        setState(() {
                          _selections2[index] = !_selections2[index];
                        });
                      },
                      isSelected: _selections2,
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '성별을 선택해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      children: [
                        ToggleButtons(
                          selectedColor: ThemeColors.primary,
                          selectedBorderColor: ThemeColors.primary,
                          fillColor: ThemeColors.primary.withOpacity(0.08),
                          splashColor: ThemeColors.primary.withOpacity(0.12),
                          hoverColor: ThemeColors.primary.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(4.0),
                          constraints:
                              BoxConstraints(minWidth: 154, minHeight: 40.0),
                          children: [
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child:
                                    Text('남자', style: TextStyle(fontSize: 18))),
                            Padding(
                                padding: EdgeInsets.symmetric(horizontal: 16),
                                child:
                                    Text('여자', style: TextStyle(fontSize: 18))),
                          ],
                          isSelected: isSelected,
                          onPressed: toggleSelect,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    const TextCustom(
                      text: '거주지를 선택해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const TextCustom(
                          text: '영암군    ',
                          fontSize: 17,
                          letterSpacing: 1.0,
                          maxLines: 2,
                        ),
                        DropdownButton(
                          focusColor: ThemeColors.primary,
                          borderRadius: BorderRadius.circular(4.0),
                          style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                          ),
                          value: _selectedValue1,
                          items: _valueList1.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedValue1 = value!;
                            });
                          },
                          elevation: 4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 60.0),
                    BtnNaru(
                      text: '다음',
                      width: size.width,
                      colorText: Colors.black,
                      onPressed: () => {
                        Navigator.push(
                            context, routeSlide(page: const RegisterPage1()))
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

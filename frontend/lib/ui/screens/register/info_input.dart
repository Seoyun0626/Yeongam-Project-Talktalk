import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login/domain/blocs/blocs.dart';
import 'package:login/ui/helpers/helpers.dart';
import 'package:login/ui/screens/login/verify_email_page.dart';
import 'package:login/ui/screens/login/login_page.dart';
import 'package:login/ui/screens/register/user_type.dart';
import 'package:login/ui/themes/theme_colors.dart';
import 'package:login/ui/widgets/widgets.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'info_first.dart';

class InfoInputPage extends StatefulWidget {
  const InfoInputPage(this.userTypeCode, {Key? key}) : super(key: key);
  final int userTypeCode;

  @override
  State<InfoInputPage> createState() => _InfoInputPageState();
}

class _InfoInputPageState extends State<InfoInputPage> {
  late TextEditingController userIDController;
  late TextEditingController userPWController;
  late TextEditingController userAgainPWController;
  late TextEditingController userEmailController;
  late TextEditingController userNameController;
  late int userTypeCode; // 사용자 유형
  late int userRole = 1;
  late int youthAge = 0; // 청소년/청소년부모 나이
  late int parentsAge = 0; // 부모 나이
  late int sex; // 성별
  late int emd = 0; // 영암군 읍면동 주소

  final List<String> _emdList = [
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
    final userTypeCode = widget.userTypeCode;

    const youthAgeList = ['초', '중', '고', '대', '학교밖', '선택X'];
    const parentsAgeList = ['10대', '20대', '30대', '40대', '50대', '60대', '선택X'];
    const sexList = ['남자', '여자', '선택X'];
    // print('user type code - $userTypeCode');
    final size = MediaQuery.of(context).size;
    final userBloc = BlocProvider.of<UserBloc>(context);

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
                const EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
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
                            validator:
                                RequiredValidator(errorText: '아이디를 입력해주세요'),
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
                      validator: RequiredValidator(errorText: '이름을 입력해주세요.'),
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
                    const TextCustom(
                        text: '추가정보',
                        letterSpacing: 2.0,
                        fontWeight: FontWeight.w700,
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
                    // 전화번호
                    const TextCustom(
                      text: '전화번호를 입력해주세요.',
                      fontSize: 17,
                      letterSpacing: 1.0,
                      maxLines: 2,
                    ),
                    const SizedBox(height: 1.0),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      maxLength: 13,
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

                    // 재학여부(청소년 0, 청소년부모 1) / 나이(부모 2)
                    // AgeToggleButton(userTypeCode), // 토글버튼 클래스
                    if (userTypeCode == 0 || userTypeCode == 1) ...[
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
                      ToggleSwitch(
                          minWidth:
                              (MediaQuery.of(context).size.width - 87) / 6,
                          minHeight: 50.0,
                          fontSize: 13,
                          initialLabelIndex: 0,
                          activeBgColor: const [
                            Color.fromARGB(40, 204, 221, 90)
                          ],
                          activeFgColor: ThemeColors.darkGreen,
                          inactiveBgColor: Colors.white,
                          borderColor: const [
                            Color.fromARGB(255, 184, 183, 183)
                          ],
                          borderWidth: 0.45,
                          activeBorders: [
                            Border.all(
                              color: ThemeColors.primary,
                              width: 1,
                            )
                          ],
                          dividerColor:
                              const Color.fromARGB(255, 184, 183, 183),
                          totalSwitches: 6,
                          labels: youthAgeList,
                          animate: true,
                          animationDuration: 200,
                          cornerRadius: 7,
                          onToggle: (index) {
                            print('school - switched to : $index');
                            youthAge = index!;
                            parentsAge = 6; // 선택안함
                          }),
                    ] else if (userTypeCode == 2) ...[
                      const TextCustom(
                        text: '나이를 선택해주세요.',
                        fontSize: 17,
                        letterSpacing: 1.0,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 10.0),
                      ToggleSwitch(
                        minWidth: (MediaQuery.of(context).size.width - 87) / 7,
                        minHeight: 50.0,
                        fontSize: 12,
                        initialLabelIndex: 0,
                        activeBgColor: const [Color.fromARGB(40, 204, 221, 90)],
                        activeFgColor: ThemeColors.darkGreen,
                        inactiveBgColor: Colors.white,
                        borderColor: const [Color.fromARGB(255, 184, 183, 183)],
                        borderWidth: 0.45,
                        activeBorders: [
                          Border.all(
                            color: ThemeColors.primary,
                            width: 1,
                          )
                        ],
                        dividerColor: const Color.fromARGB(255, 184, 183, 183),
                        totalSwitches: 7,
                        labels: parentsAgeList,
                        animate: true,
                        animationDuration: 200,
                        cornerRadius: 7,
                        onToggle: (index) {
                          print('age - switched to : $index');
                          parentsAge = index!;
                          youthAge = 6; // 선택안함
                        },
                      ),
                    ],

                    const SizedBox(height: 40.0),

                    // 성별
                    // const SexToggleButton(),
                    ToggleSwitch(
                      minWidth: (MediaQuery.of(context).size.width - 87) / 3,
                      minHeight: 50.0,
                      fontSize: 15,
                      initialLabelIndex: 0,
                      activeBgColor: const [Color.fromARGB(40, 204, 221, 90)],
                      activeFgColor: ThemeColors.darkGreen,
                      inactiveBgColor: Colors.white,
                      borderColor: const [Color.fromARGB(255, 184, 183, 183)],
                      borderWidth: 0.45,
                      activeBorders: [
                        Border.all(
                          color: ThemeColors.primary,
                          width: 1,
                        )
                      ],
                      dividerColor: const Color.fromARGB(255, 184, 183, 183),
                      totalSwitches: 3,
                      labels: sexList,
                      animate: true,
                      animationDuration: 200,
                      cornerRadius: 7,
                      onToggle: (index) {
                        print('sex - switched to : $index');
                        sex = index!;
                      },
                    ),

                    const SizedBox(height: 40.0),
                    // 거주지
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
                          // ignore: unnecessary_null_comparison
                          value: _emdList[emd],
                          items: _emdList.map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              emd = _emdList.indexOf(value!);
                              // _selectedEMD =
                              //     _emdList.indexOf(value!).toString(); //value!;
                              // print('emd $_selectedEMD');
                              // emd = _selectedEMD; //_selectedEMD;
                            });
                          },
                          elevation: 4,
                        ),
                      ],
                    ),
                    const SizedBox(height: 60.0),
                    BtnNaru(
                        text: '완료',
                        width: size.width,
                        colorText: Colors.black,
                        // onPressed: () => Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const RegisterPage1(),
                        //     )),
                        onPressed: () {
                          if (_keyForm.currentState!.validate()) {
                            userBloc.add(OnRegisterUserEvent(
                                userIDController.text.trim(),
                                userNameController.text.trim(),
                                userEmailController.text.trim(),
                                userPWController.text.trim(),
                                userAgainPWController.text.trim(),
                                userRole.toString(), // user_role - 사용자
                                userTypeCode.toString(), // user_type
                                youthAge.toString(), // youthAge_code
                                parentsAge.toString(), // parentsAge_code
                                emd.toString(), //emd_class_code // 자료형 해결해야 함
                                sex.toString() // sex_class_code
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

// 핸드폰 번호 입력
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

// 나이 선택 토글 버튼
// const List<Widget> youthAgeList = <Widget>[
//   Text('초'),
//   Text('중'),
//   Text('고'),
//   Text('대'),
//   Text('기타'),
// ];
// const List<Widget> parentsAgeList = <Widget>[
//   Text('10대'),
//   Text('20대'),
//   Text('30대'),
//   Text('40대'),
//   Text('50대'),
//   Text('60대'),
// ];

// class AgeToggleButton extends StatefulWidget {
//   final int typeCode;
//   const AgeToggleButton(this.typeCode, {Key? key}) : super(key: key);

//   @override
//   State<AgeToggleButton> createState() => _AgeToggleButtonState();
// }

// class _AgeToggleButtonState extends State<AgeToggleButton> {
//   final List<bool> _selectedYouthAge = <bool>[true, false, false, false, false];
//   final List<bool> _selectedParentsAge = <bool>[
//     true,
//     false,
//     false,
//     false,
//     false,
//     false
//   ];

//   @override
//   Widget build(BuildContext context) {
//     final int code = widget.typeCode;
//     print(code);
//     final size = MediaQuery.of(context).size;
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       if (code == 0 || code == 1) ...[
//         const TextCustom(
//           text: '재학 여부를 선택해주세요.',
//           fontSize: 17,
//           letterSpacing: 1.0,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 5.0),
//         const TextCustom(
//           text: '청소년, 청소년부모만 해당',
//           fontSize: 13,
//           letterSpacing: 1.0,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 10.0),
//         ToggleButtons(
//           onPressed: (int index) {
//             setState(() {
//               // The button that is tapped is set to true, and the others to false.
//               for (int i = 0; i < _selectedYouthAge.length; i++) {
//                 _selectedYouthAge[i] = i == index;
//               }
//               print('Age $_selectedYouthAge');
//             });
//           },
//           borderRadius: const BorderRadius.all(Radius.circular(8)),
//           selectedColor: ThemeColors.darkGreen,
//           selectedBorderColor: ThemeColors.primary,
//           fillColor: ThemeColors.primary.withOpacity(0.08),
//           splashColor: ThemeColors.primary.withOpacity(0.12),
//           hoverColor: ThemeColors.primary.withOpacity(0.04),
//           color: ThemeColors.basic,
//           constraints: const BoxConstraints(
//             minHeight: 40.0,
//             minWidth: (330 - 108) / 5,
//           ),
//           isSelected: _selectedYouthAge,
//           children: youthAgeList,
//         )
//       ] else if (code == 2) ...[
//         const TextCustom(
//           text: '나이를 선택해주세요.',
//           fontSize: 17,
//           letterSpacing: 1.0,
//           maxLines: 2,
//         ),
//         const SizedBox(height: 10.0),
//         ToggleButtons(
//             onPressed: (int index) {
//               setState(() {
//                 // The button that is tapped is set to true, and the others to false.
//                 for (int i = 0; i < _selectedParentsAge.length; i++) {
//                   _selectedParentsAge[i] = i == index;
//                 }
//                 print('Age $_selectedParentsAge');
//               });
//             },
//             borderRadius: const BorderRadius.all(Radius.circular(8)),
//             selectedColor: ThemeColors.darkGreen,
//             selectedBorderColor: ThemeColors.primary,
//             fillColor: ThemeColors.primary.withOpacity(0.08),
//             splashColor: ThemeColors.primary.withOpacity(0.12),
//             hoverColor: ThemeColors.primary.withOpacity(0.04),
//             color: ThemeColors.basic,
//             constraints: const BoxConstraints(
//               minHeight: 40.0,
//               minWidth: 40.0,
//             ),
//             isSelected: _selectedParentsAge,
//             children: parentsAgeList)
//       ],
//     ]);
//   }
// }

// // 성별 선택 토글 버튼
// // const List<Widget> sexList = <Widget>[
// //   Text('남'),
// //   Text('여'),
// // ];

// // class SexToggleButton extends StatefulWidget {
// //   const SexToggleButton({Key? key}) : super(key: key);

// //   @override
// //   State<SexToggleButton> createState() => _SexToggleButtonState();
// // }

// // class _SexToggleButtonState extends State<SexToggleButton> {
//   final List<bool> _selectedSex = <bool>[true, false];
//   late int sex;

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//       const TextCustom(
//         text: '성별을 선택해주세요.',
//         fontSize: 17,
//         letterSpacing: 1.0,
//         maxLines: 2,
//       ),
//       const SizedBox(height: 10.0),
//       ToggleSwitch(
//         minWidth: (MediaQuery.of(context).size.width - 87) / 2,
//         minHeight: 50.0,
//         fontSize: 15,
//         initialLabelIndex: 0,
//         activeBgColor: const [Color.fromARGB(40, 204, 221, 90)],
//         activeFgColor: ThemeColors.darkGreen,
//         inactiveBgColor: Colors.white,
//         borderColor: const [Color.fromARGB(255, 184, 183, 183)],
//         borderWidth: 0.45,
//         activeBorders: [
//           Border.all(
//             color: ThemeColors.primary,
//             width: 1,
//           )
//         ],
//         dividerColor: const Color.fromARGB(255, 184, 183, 183),
//         totalSwitches: 2,
//         labels: const ['남자', '여자'],
//         animate: true,
//         animationDuration: 200,
//         cornerRadius: 7,
//         onToggle: (index) {
//           print('sex - switched to : $index');
//           sex = index!;
//         },
//       ),
//       // ToggleButtons(
//       //     onPressed: (int index) {
//       //       setState(() {
//       //         // The button that is tapped is set to true, and the others to false.
//       //         for (int i = 0; i < _selectedSex.length; i++) {
//       //           _selectedSex[i] = i == index;
//       //         }
//       //         print('Age $_selectedSex');
//       //       });
//       //     },
//       //     borderRadius: const BorderRadius.all(Radius.circular(8)),
//       //     selectedColor: ThemeColors.darkGreen,
//       //     selectedBorderColor: ThemeColors.primary,
//       //     fillColor: ThemeColors.primary.withOpacity(0.08),
//       //     splashColor: ThemeColors.primary.withOpacity(0.12),
//       //     hoverColor: ThemeColors.primary.withOpacity(0.04),
//       //     color: ThemeColors.basic,
//       //     constraints: const BoxConstraints(
//       //       minHeight: 40.0,
//       //       minWidth: 80,
//       //     ),
//       //     isSelected: _selectedSex,
//       //     children: sexList)
//     ]);
//   }
// }

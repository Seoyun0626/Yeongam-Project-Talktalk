import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:teentalktalk/domain/services/event_services.dart';
import 'package:teentalktalk/ui/helpers/helpers.dart';
import 'package:teentalktalk/domain/blocs/blocs.dart';
import 'package:teentalktalk/ui/helpers/modals/modal_getFig.dart';
import 'package:teentalktalk/ui/screens/user/myTalkTalk_page.dart';
import 'package:teentalktalk/ui/themes/theme_colors.dart';
import 'package:teentalktalk/ui/widgets/widgets.dart';

class InviteCodePage extends StatefulWidget {
  const InviteCodePage({Key? key}) : super(key: key);

  @override
  State<InviteCodePage> createState() => _InviteCodePageState();
}

class _InviteCodePageState extends State<InviteCodePage> {
  late TextEditingController inviteCodeController;
  final _keyForm = GlobalKey<FormState>();
  // String? initialEmail;

  @override
  void initState() {
    super.initState();
    inviteCodeController = TextEditingController();
  }

  @override
  void dispose() {
    // inviteCodeController.clear();
    inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final userBloc = BlocProvider.of<UserBloc>(context);

    return BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          // print(state);

          if (state is LoadingEditUserState) {
            modalLoading(context, '확인 중...');
          }
          if (state is FailureUserState) {
            Navigator.pop(context);
            errorMessageSnack(context, state.error);
          }
          if (state is SuccessUserState) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyTalkTalkPage(),
                ),
                (_) => false);
            modalGetFig(context, '7');
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            // title: const TextCustom(
            //   text: '초대 코드 입력',
            //   color: Colors.black,
            //   fontSize: 20,
            //   fontWeight: FontWeight.w600,
            // ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: ThemeColors.primary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
              child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 40.0),
                  child: Form(
                    key: _keyForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '청소년 톡talk',
                              style: TextStyle(
                                  color: ThemeColors.primary,
                                  fontFamily: 'CookieRun',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500),
                            ),
                            TextCustom(
                              text: '에 초대받았다면',
                              color: ThemeColors.basic,
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextCustom(
                          text: '초대 코드를 입력해주세요',
                          fontWeight: FontWeight.w600,
                          fontSize: 24.sp,
                          color: Colors.black,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextCustom(
                          text: '가입 후 24시간 내까지 입력할 수 있어요',
                          color: ThemeColors.basic,
                          fontSize: 15.sp,
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        TextField(
                          controller: inviteCodeController,
                          obscureText: false,
                          cursorColor: ThemeColors.primary,
                          cursorHeight: 20.h,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontFamily: 'NanumSquareRound',
                              fontWeight: FontWeight.bold),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: ThemeColors.primary),
                                  borderRadius: BorderRadius.circular(20)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              labelText: '초대 코드 입력',
                              labelStyle: TextStyle(
                                  fontSize: 14.sp,
                                  fontFamily: 'NanumSquareRound',
                                  color: ThemeColors.primary)),
                        ),
                        // TextFieldNaru(
                        //   controller: inviteCodeController,
                        //   validator: validatedEmail,
                        //   hintText: '초대코드를 입력해주세요',
                        //   fontSize: 12.sp,
                        // ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: BtnNaru(
                              text: '입력',
                              width: size.width,
                              fontWeight: FontWeight.bold,
                              height: 50,
                              onPressed: () {
                                if (_keyForm.currentState!.validate()) {
                                  userBloc.add(OnEnterInviteCodeEvent(
                                      inviteCodeController.text.trim()));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))),
        ));
  }
}

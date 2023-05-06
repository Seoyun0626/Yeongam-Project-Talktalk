import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: const TextCustom(
              text: '개인 정보 설정',
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
                color: ThemeColors.primary,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                    child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                      //사용자 이름
                      Container(
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.all(20),
                        color: ThemeColors.third,
                        height: 200,
                        child: Center(
                            child: Container(child: const _UserProfile())),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              // [기본 정보]
                              TextCustom(
                                text: '기본 정보',
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              _UserInfo(),

                              // [추가 정보]
                              SizedBox(
                                height: 40,
                              ),
                              TextCustom(
                                text: '추가 정보',
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              _UserExtraInfo(),
                            ]),
                      )
                    ]))
              ],
            ),
          ),
          bottomNavigationBar: const BottomNavigation(index: 5)),
    );
  }
}

// 사용자 프로필
class _UserProfile extends StatelessWidget {
  const _UserProfile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (_, state) => (state.user?.user_name != null)
            ? TextCustom(
                text: state.user!.user_name,
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              )
            : const CircularProgressIndicator(
                color: ThemeColors.primary,
              ));
  }
}

class _UserInfo extends StatelessWidget {
  const _UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이름
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextCustom(
                    text: '이름',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: '아이디',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: '비밀번호',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: '이메일 주소',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              // 값
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: state.user!.user_name,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: state.user!.userid,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const _UserInfoEditButton(),
                  // TextCustom(
                  //   text: '********',
                  //   fontSize: 20,
                  //   color: Colors.black,
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: state.user!.user_email,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _UserExtraInfo extends StatelessWidget {
  const _UserExtraInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (_, state) {
      late String ageCode = '';
      late String ageCodeName = '';
      final String userTypeCode = state.user!.user_type;

      if (userTypeCode == '0' || userTypeCode == '1') {
        ageCode = state.user!.youthAge_code;
        ageCodeName = "youthAge_code";
      } else if (userTypeCode == '2') {
        ageCode = state.user!.parentsAge_code;
        ageCodeName = "parentsAge_code";
      }

      //사용자 유형
      final String userType =
          getMobileCodeService.getCodeDetailName("user_type", userTypeCode);
      //사용자 나이
      final String userAge = getMobileCodeService.getCodeDetailName(
          ageCodeName, state.user!.youthAge_code);
      //사용자 성별
      final String userSex = getMobileCodeService.getCodeDetailName(
          "sex_class_code", state.user!.sex_class_code);
      //사용자 거주지
      final String userEmd = getMobileCodeService.getCodeDetailName(
          "emd_class_code", state.user!.emd_class_code);

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 이름
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 제목
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextCustom(
                    text: '사용자 유형',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: '나이',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: '성별',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: '거주지',
                    fontSize: 20,
                    color: ThemeColors.basic,
                  ),
                ],
              ),
              const SizedBox(
                width: 30,
              ),
              // 값
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextCustom(
                    text: userType,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: userAge,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: userSex,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextCustom(
                    text: userEmd,
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _UserInfoEditButton extends StatelessWidget {
  const _UserInfoEditButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        // height: 50,
        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(245, 245, 245, 1),
          borderRadius: BorderRadius.circular(20),
          // border: Border.all(
          //   color: ThemeColors.primary,
          //   width: 2,
          // ),
        ),
        child: const TextCustom(
          text: '변경하기',
          color: ThemeColors.primary,
          fontSize: 20,
        ),
      ),
      onTap: () {},
    );
  }
}

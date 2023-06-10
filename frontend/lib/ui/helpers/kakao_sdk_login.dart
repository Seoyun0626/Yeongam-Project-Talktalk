import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:login/domain/blocs/auth/auth_bloc.dart';

class KakaoLoginService {
  // 로그인
  // 카카오톡 설치 여부
  // O -> 카카오톡 로그인
  // X -> 카카오계정으로 로그인
  Future<bool> kakaoLogin() async {
    bool talkInstalled = await isKakaoTalkInstalled();
    // print(talkInstalled);
// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (talkInstalled) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
          return true;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }

  Future<void> kakaoLogout() async {
    try {
      await UserApi.instance.unlink();
      print('연결 끊기 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('연결 끊기 실패 $error');
    }
  }

  Future<void> kakaoPrintUserInfo() async {
    try {
      User user = await UserApi.instance.me();

      final String user_id = user.id.toString();
      final String user_name = user.kakaoAccount?.profile?.nickname ?? '';
      final String user_email = user.kakaoAccount?.email ?? '';

      print('사용자 정보 요청 성공'
          '\n회원번호: $user_id'
          '\n닉네임: $user_name'
          '\n이메일: $user_email');
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
    }
  }

  Future<Map<String, String>> kakaoGetUserInfo() async {
    try {
      User user = await UserApi.instance.me();
      final String user_id = user.id.toString();
      final String user_name = user.kakaoAccount?.profile?.nickname ?? '';
      final String user_email = user.kakaoAccount?.email ?? '';

      print('사용자 정보 요청 성공'
          '\n회원번호: $user_id'
          '\n닉네임: $user_name'
          '\n이메일: $user_email');

      return {
        'user_id': user_id,
        'user_name': user_name,
        'user_email': user_email,
      };
    } catch (error) {
      print('사용자 정보 요청 실패 $error');
      return {};
    }
  }

  // Future<void> kakaoUserRegisterInfo(context) async {
  //   final authBloc = BlocProvider.of<AuthBloc>(context);

  //   try {
  //     User user = await UserApi.instance.me();

  //     final String user_id = user.id.toString();
  //     final String user_name = user.kakaoAccount?.profile?.nickname ?? '';
  //     final String user_email = user.kakaoAccount?.email ?? '';
  //     const String user_role = '1';
  //     const String user_type = '0'; // 선택안함
  //     const String _inviteCode = '';
  //     const String _youthAge = '5';
  //     const String _parentsAge = '6';
  //     const String _emd = '0';
  //     const String _sex = '2';

  //     authBloc.add(OnRegisterKakaoUserEvent(
  //         user_id,
  //         user_name,
  //         user_email,
  //         user_role,
  //         user_type,
  //         _inviteCode,
  //         _youthAge,
  //         _parentsAge,
  //         _emd,
  //         _sex));
  //     print('사용자 정보 요청 성공'
  //         '\n회원번호: ${user_id}'
  //         '\n닉네임: ${user_name}'
  //         '\n이메일: ${user_email}');
  //   } catch (error) {
  //     print('사용자 정보 요청 실패 $error');
  //   }
  // }
}

final KakaoLoginServices = KakaoLoginService();

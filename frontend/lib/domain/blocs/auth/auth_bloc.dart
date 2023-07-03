import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:teentalktalk/data/storage/secure_storage.dart';
import 'package:teentalktalk/domain/services/auth_services.dart';
import 'package:teentalktalk/ui/helpers/kakao_sdk_login.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthState()) {
    on<OnLoginEvent>(_onLogin);
    on<OnKakaoLoginEvent>(_onKakaoLogin);
    on<OnCheckingLoginEvent>(_onCheckingLogin);
    on<OnLogOutEvent>(_onLogOut);
  }

  Future<void> _onLogin(
    OnLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // print("_onLogin");
      emit(LoadingAuthentication());
      // print("auth_bloc loadingAuthentication");
      // print(event.userid);
      // print(event.userpw);

      final data = await authServices.login(event.userid, event.userpw);
      // print('_onLogin data.resp');
      print(data.resp);
      await Future.delayed(const Duration(milliseconds: 350));

      if (data.resp) {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenToken(data.token!);
        // print('_onLogin SuccessAuthentication');
        emit(SuccessAuthentication());
      } else {
        // print('_onLogin FailureAuthentication');
        // print(data.resp);
        emit(FailureAuthentication(data.message));
        // emit(FailureAuthentication());
      }
    } catch (e) {
      emit(FailureAuthentication(e.toString()));
      // emit(FailureAuthentication());
    }
  }

  Future<void> _onKakaoLogin(
      OnKakaoLoginEvent event, Emitter<AuthState> emit) async {
<<<<<<< HEAD
    print(event.user_id);
    print(event.user_email);
    final data = await authServices.kakaoLogin(event.user_id, event.user_email);
    // print('_onLogin data.resp');
    print(data.resp);
    emit(SuccessAuthentication());
=======
    try {
      emit(LoadingAuthentication());
      print("_onKakaoLogin");

      final data =
          await authServices.kakaoLogin(event.userid, event.user_email);

      print(data.resp);
      await Future.delayed(const Duration(milliseconds: 350));

      if (data.resp) {
        await secureStorage.deleteSecureStorage();
        await secureStorage.persistenToken(data.token!);
        emit(SuccessAuthentication());
      } else {
        emit(FailureAuthentication(data.message));
      }
    } catch (e) {
      emit(FailureAuthentication(e.toString()));
    }
>>>>>>> KTH
  }

  Future<void> _onCheckingLogin(
    OnCheckingLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      // print("_onCheckingLogin");
      await Future.delayed(const Duration(milliseconds: 850));

      if (await secureStorage.readToken() != null) {
        final data = await authServices.renewLogin();

        if (data.resp) {
          await secureStorage.persistenToken(data.token!);

          emit(SuccessAuthentication());
        } else {
          await secureStorage.deleteSecureStorage();
          emit(LogOut());
        }
      } else {
        await secureStorage.deleteSecureStorage();
        emit(LogOut());
      }
    } catch (e) {
      await secureStorage.deleteSecureStorage();
      emit(LogOut());
    }
  }

  Future<void> _onLogOut(OnLogOutEvent event, Emitter<AuthState> emit) async {
    // print("_onLogOut");
    await secureStorage.deleteSecureStorage();
    emit(LogOut());
  }
}

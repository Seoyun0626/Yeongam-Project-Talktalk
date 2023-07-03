part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnLoginEvent extends AuthEvent {
  final String userid;
  final String userpw;

  OnLoginEvent(this.userid, this.userpw);
}

class OnKakaoLoginEvent extends AuthEvent {
<<<<<<< HEAD
  final String user_id;
  final String user_email;
  OnKakaoLoginEvent(this.user_id, this.user_email);
=======
  final String userid;
  final String user_email;
  OnKakaoLoginEvent(this.userid, this.user_email);
>>>>>>> KTH
}

class OnCheckingLoginEvent extends AuthEvent {}

class OnLogOutEvent extends AuthEvent {}

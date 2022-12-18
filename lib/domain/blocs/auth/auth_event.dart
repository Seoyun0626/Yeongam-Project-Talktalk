part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class OnLoginEvent extends AuthEvent {
  final String user_id;
  final String user_pw;

  OnLoginEvent(this.user_id, this.user_pw);
}

class OnCheckingLoginEvent extends AuthEvent {}

class OnLogOutEvent extends AuthEvent {}
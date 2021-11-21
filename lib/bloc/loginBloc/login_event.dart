part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class CheckCredentialsEvent extends LoginEvent {
  final String email;
  final String password;
  CheckCredentialsEvent(this.email, this.password);
}

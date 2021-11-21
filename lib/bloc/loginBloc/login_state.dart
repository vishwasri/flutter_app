// ignore_for_file: must_be_immutable, annotate_overrides

part of 'login_bloc.dart';

@immutable
abstract class LoginState {
  String? successMessage;
  String? errorMessage;
}

class LoginInitial extends LoginState {}

class LoginFinalState extends LoginState {
  final User? user;
  final String? successMessage;
  final String? errorMessage;
  LoginFinalState({this.user, this.errorMessage, this.successMessage});
}

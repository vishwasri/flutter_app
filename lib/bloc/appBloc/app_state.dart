part of 'app_bloc.dart';

@immutable
abstract class AppState {
  final User? user;
  const AppState({this.user});
}

class UserLoggedOutState extends AppState {}

class UserLoggedInState extends AppState {
  @override
  final User user;
  const UserLoggedInState(this.user);
}

class NoConnectionState extends AppState {}

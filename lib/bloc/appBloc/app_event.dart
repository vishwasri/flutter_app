part of 'app_bloc.dart';

@immutable
abstract class AppEvent {}

class UserValidateEvent extends AppEvent {}

class SetUserEvent extends AppEvent {
  final User user;
  SetUserEvent(this.user);
}

class ClearUserEvent extends AppEvent {}

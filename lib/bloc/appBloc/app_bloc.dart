import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yukon/model/user.dart';
import 'package:yukon/service/user_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final userService = UserService();
  AppBloc() : super(UserLoggedOutState());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is UserValidateEvent) {
      log(event.toString());
      User? _user = await userService.validateToken('123');
      if (_user != null) {
        yield UserLoggedInState(_user);
      } else {
        yield UserLoggedOutState();
      }
    }
  }
}

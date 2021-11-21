import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:yukon/model/user.dart';
import 'package:yukon/service/user_service.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final userService = UserService();
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is CheckCredentialsEvent) {
      User? _user = await userService.login(event.email, event.password);
      if (_user == null) {
        yield LoginFinalState(errorMessage: 'Invalid credentials');
      } else {
        yield LoginFinalState(user: _user, successMessage: 'Success');
      }
    }
  }
}

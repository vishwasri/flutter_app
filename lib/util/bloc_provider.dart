import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukon/bloc/appBloc/app_bloc.dart';
import 'package:yukon/bloc/homeBloc/home_bloc.dart';
import 'package:yukon/bloc/loginBloc/login_bloc.dart';

class MyBlocProvider {
  static List<BlocProvider> allBlocs() {
    return [
      BlocProvider<AppBloc>(
        create: (BuildContext context) => AppBloc(),
      ),
      BlocProvider<LoginBloc>(
        create: (BuildContext context) => LoginBloc(),
      ),
      BlocProvider<HomeBloc>(
        create: (BuildContext context) => HomeBloc(),
      ),
    ];
  }
}

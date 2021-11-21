import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yukon/bloc/appBloc/app_bloc.dart';

import 'login_screen.dart';

class OnboardScreen extends StatefulWidget {
  static const routeName = '/';
  const OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  @override
  void initState() {
    context.read<AppBloc>().add(UserValidateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppBloc, AppState>(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white,
        child: Center(
          child: Image.asset('asset/commerce-bank-logo-2x.png'),
        ),
      ),
      listener: (context, state) {
        log('state changed');
        log(state.toString());
        if (state is UserLoggedOutState) {
          Navigator.pushNamed(context, LoginScreen.routeName);
        }
        // if (state is UserLoggedInState) {
        //   Navigator.pushNamed(context, HomeScreen.routeName);
        // }
      },
    );
  }
}

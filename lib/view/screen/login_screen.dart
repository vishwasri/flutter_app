// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:yukon/bloc/loginBloc/login_bloc.dart';
import 'package:yukon/util/constant.dart';
import 'package:yukon/util/my_toast.dart';
import 'package:yukon/util/text_style.dart';
import 'package:yukon/view/screen/home_screen.dart';
import 'package:yukon/view/widget/my_bordered_text_field.dart';
import 'package:yukon/view/widget/my_button.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocConsumer<LoginBloc, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.only(
                  left: HORIZONTAL_PAGE_PADDING,
                  right: HORIZONTAL_PAGE_PADDING,
                  top: VERTICAL_PAGE_PADDING,
                ),
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Text(
                          'Login',
                          style: TS_TITLE,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: FormBuilder(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              BorderedTextField(
                                controller: _emailController,
                                labelText: 'Email',
                                name: 'email',
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: 'Required')
                                ]),
                              ),
                              const SizedBox(height: 10),
                              BorderedTextField(
                                controller: _passwordController,
                                labelText: 'Password',
                                name: 'password',
                                obscureText: true,
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context,
                                      errorText: 'Required')
                                ]),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              MyButton(
                                label: 'Login',
                                onTap: () {
                                  if (_formKey.currentState!
                                      .saveAndValidate()) {
                                    log(_formKey.currentState!.value['email']);
                                    log(_formKey
                                        .currentState!.value['password']);
                                  }
                                  context.read<LoginBloc>().add(
                                      CheckCredentialsEvent(
                                          _formKey.currentState!.value['email'],
                                          _formKey.currentState!
                                              .value['password']));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          listener: (context, state) async {
            log('state changed');
            if (state is LoginFinalState) {
              if (state.errorMessage != null) {
                MyToast.showErrorToast(state.errorMessage!);
              }
              if (state.successMessage != null) {
                MyToast.showErrorToast(state.successMessage!);
              }
              if (state.user != null) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              }
            }
          },
        ),
      ),
    );
  }
}

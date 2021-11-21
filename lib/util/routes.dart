import 'package:flutter/material.dart';
import 'package:yukon/view/screen/home_screen.dart';
import 'package:yukon/view/screen/login_screen.dart';
import 'package:yukon/view/screen/onboard_screen.dart';

class MyRoutes {
  static Map<String, Widget Function(BuildContext)> allRoutes() {
    return {
      LoginScreen.routeName: (context) => const LoginScreen(),
      HomeScreen.routeName: (context) => const HomeScreen(),
      OnboardScreen.routeName: (context) => const OnboardScreen(),
    };
  }

  static String initialRoute() => OnboardScreen.routeName;
}

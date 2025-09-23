// lib/pages/login_or_register.dart
import 'package:flutter/material.dart';
import 'package:pokegame/pages/login_page.dart';
import 'package:pokegame/pages/register_page.dart';

class LoginOrRegisterPage extends StatefulWidget {
  const LoginOrRegisterPage({super.key});

  @override
  State<LoginOrRegisterPage> createState() => _LoginOrRegisterPageState();
}

class _LoginOrRegisterPageState extends State<LoginOrRegisterPage> {
  bool showLogin = true;

  void togglePage() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(onRegisterTap: togglePage);
    } else {
      return RegisterPage(onLoginTap: togglePage);
    }
  }
}

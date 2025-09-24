import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokegame/pages/login_page.dart';
import 'package:pokegame/pages/register_page.dart';
import 'package:pokegame/pages/home_page.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Si el usuario YA está logueado lo manda a HomePage
    if (user != null) {
      return const HomePage();
    }

    // Si no, muestro login o register según toggle
    return showLogin
        ? LoginPage(onRegisterTap: togglePages)
        : RegisterPage(onLoginTap: togglePages);
  }
}

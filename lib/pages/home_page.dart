import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokegame/components/select_button.dart';
import 'package:pokegame/pages/about_page.dart';
import 'package:pokegame/pages/guess_type_page.dart';
import 'package:pokegame/pages/pokedle_page.dart';
import 'package:pokegame/pages/ranking_page.dart';
import 'package:pokegame/services/auth/auth_gate.dart';
import 'package:pokegame/services/auth/auth_service.dart';
import 'package:pokegame/themes/palette.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void goTo(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24, left: 12, right: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🔹 Logo
              Image.network(
                "https://i.imgur.com/UazX9hl.png",
                height: 160,
              ),
              const SizedBox(height: 32),

              // 🔹 Título
              Text("Menú de selección", style: textTheme.headlineLarge),
              const SizedBox(height: 32),

              // 🔹 Botones de navegación con imágenes
              SelectButton(
                imageUrl: "https://i.imgur.com/McnUoQF.png",
                onTap: () => goTo(context, const PokedlePage()),
              ),
              SelectButton(
                imageUrl: "https://i.imgur.com/A0aovrS.png",
                onTap: () => goTo(context, const GuessTypePage()),
              ),
              SelectButton(
                imageUrl: "https://i.imgur.com/2whFy5P.png",
                onTap: () => goTo(context, const AboutPage()),
              ),
              SelectButton(
                imageUrl: "https://i.imgur.com/tovxSqj.png",
                onTap: () => goTo(context, const RankingPage()),
              ),
              const SizedBox(height: 24),

              // 🔹 Login / Logout condicional
              if (user == null)
                TextButton(
                  onPressed: () => goTo(context, const AuthGate()),
                  child: const Text(
                    "Iniciar Sesión",
                    style: TextStyle(color: AppColors.accentGreen),
                  ),
                )
              else
                TextButton(
                  onPressed: () async {
                    await AuthService().signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const HomePage()),
                      (route) => false,
                    );
                  },
                  child: const Text(
                    "Cerrar Sesión",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}



import 'package:flutter/material.dart';
import '../components/profile_card.dart';
import '../themes/palette.dart';

class GameResultPage extends StatelessWidget {
  final int previousScore;
  final int gainedScore;

  const GameResultPage({
    super.key,
    required this.previousScore,
    required this.gainedScore,
  });

  @override
  Widget build(BuildContext context) {
    final int totalScore = previousScore + gainedScore;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [AppColors.purpleDark, AppColors.primaryPurple],
            center: Alignment(0, -0.4),
            radius: 1.2,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Texto principal con animación
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      gainedScore > 0 ? "¡Has Ganado!" : "😮 Oops...",
                      key: ValueKey(gainedScore > 0),
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.yellowAccent,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ProfileCard con sombra y escala sutil
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOutBack,
                    tween: Tween<double>(begin: 0.8, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: ProfileCard(
                          previousScore: previousScore,
                          gainedScore: gainedScore,
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 40),

                  // Score destacado
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.accentGreen,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Text(
                      "Tu puntaje total: $totalScore",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white,
                      ),
                    ),
                  ),

                  const SizedBox(height: 60),

                  // Botón volver
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yellowAccent,
                      foregroundColor: AppColors.black,
                      shadowColor: AppColors.shadow,
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 18,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).popUntil((route) => route.isFirst);
                    },
                    child: const Text(
                      "Volver al inicio",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

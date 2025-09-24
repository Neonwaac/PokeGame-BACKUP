import 'package:flutter/material.dart';
import 'package:pokegame/components/header_back.dart';
import 'package:pokegame/themes/palette.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const logoUrl = "https://i.imgur.com/UazX9hl.png";

    return Scaffold(
      backgroundColor: AppColors.primaryPurple,
      appBar: HeaderBack(title: "¿Cómo jugar?"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo centrado con sombra
            Center(
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Image.network(logoUrl, height: 120, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(height: 24),

            // Texto introductorio
            Text(
              "¡Bienvenido a Pokegames! ✨",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.yellowAccent,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Pon a prueba tu memoria, tu rapidez y tus conocimientos del mundo Pokémon con nuestros mini-juegos.",
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.boneWhite),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            Divider(color: AppColors.purpleLight),
            const SizedBox(height: 20),

            // Explicación de los juegos
            _GameCard(
              title: "Guess the Type",
              description:
                  "El reto es adivinar los tipos de cada Pokémon. ¿Será Fuego, Planta, Acero? Si aciertas, ganas puntos y avanzas; si fallas… ¡aprendes algo nuevo!",
              color: Colors.deepPurple,
              icon: Icons.extension,
            ),
            const SizedBox(height: 20),
            _GameCard(
              title: "Guess the Pokémon",
              description:
                  "La clásica silueta misteriosa… ¿Quién es ese Pokémon? Elige entre varias opciones y demuestra cuánto sabes de la Pokédex.",
              color: Colors.redAccent,
              icon: Icons.catching_pokemon,
            ),

            const SizedBox(height: 30),
            Divider(color: AppColors.purpleLight),
            const SizedBox(height: 20),

            // Cierre
            Text(
              "¿Listo para jugar? 🌟",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.accentGreen,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _GameCard extends StatelessWidget {
  final String title;
  final String description;
  final Color color;
  final IconData icon;

  const _GameCard({
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.purpleTransparent,
      elevation: 6,
      shadowColor: AppColors.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.shadow,
              radius: 30,
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.boneWhite,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

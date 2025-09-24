import 'package:flutter/material.dart';
import 'package:pokegame/components/header_back.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const logoUrl = "https://i.imgur.com/UazX9hl.png";

    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
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
                      color: colors.shadow,
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
              style: textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              "Pon a prueba tu memoria, tu rapidez y tus conocimientos del mundo Pokémon con nuestros mini-juegos.",
              style: textTheme.bodyMedium?.copyWith(
                color: colors.primary,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 30),
            Divider(color: colors.primary),
            const SizedBox(height: 20),

            // Explicación de los juegos
            _GameCard(
              title: "Guess the Type",
              description:
                  "El reto es adivinar los tipos de cada Pokémon. ¿Será Fuego, Planta, Acero? Si aciertas, ganas puntos y avanzas; si fallas… ¡aprendes algo nuevo!",
              icon: Icons.extension,
            ),
            const SizedBox(height: 20),
            _GameCard(
              title: "Guess the Pokémon",
              description:
                  "La clásica silueta misteriosa… ¿Quién es ese Pokémon? Elige entre varias opciones y demuestra cuánto sabes de la Pokédex.",
              icon: Icons.catching_pokemon,
            ),

            const SizedBox(height: 30),
            Divider(color: colors.primary),
            const SizedBox(height: 20),

            // Cierre
            Text(
              "¿Listo para jugar? 🌟",
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: colors.primary,
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
  final IconData icon;

  const _GameCard({
    required this.title,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      color: colors.surface,
      elevation: 6,
      shadowColor: colors.shadow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: colors.primary,
              radius: 30,
              child: Icon(icon, size: 32, color: colors.onPrimary),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colors.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface,
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


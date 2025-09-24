import 'package:flutter/material.dart';
import '../models/score.dart';
import 'dart:math';

class ScoreTile extends StatelessWidget {
  final Score score;
  final int rank;

  const ScoreTile({super.key, required this.score, required this.rank});

  String _getRandomPokemonImage() {
    final randomId = Random().nextInt(151) + 1;
    return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$randomId.png";
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colors.surface,
            colors.secondary,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: colors.primary,
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: colors.surface,
          backgroundImage: NetworkImage(_getRandomPokemonImage()),
        ),
        title: Text(
          score.email ?? "Jugador",
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontFamily: 'PixelifySans',
                fontWeight: FontWeight.w600,
                color: colors.primary,
              ),
        ),
        subtitle: Text(
          "Puntos: ${score.score}",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontFamily: 'PixelifySans',
                color: colors.onSurface,
              ),
        ),
        trailing: Text(
          "#$rank",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontFamily: 'PixelifySans',
                fontWeight: FontWeight.bold,
                color: colors.primary,
              ),
        ),
      ),
    );
  }
}




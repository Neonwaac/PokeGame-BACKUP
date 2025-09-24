import 'package:flutter/material.dart';
import '../models/score.dart';
import '../themes/palette.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purpleAccent.shade100,
            AppColors.accentGreen.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primaryPurple, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryPurple.withOpacity(0.3),
            offset: const Offset(3, 3),
            blurRadius: 6,
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: AppColors.white,
          backgroundImage: NetworkImage(_getRandomPokemonImage()),
        ),
        title: Text(
          score.email ?? "Jugador",
          style: const TextStyle(
            fontFamily: 'PixelifySans',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryPurple,
          ),
        ),
        subtitle: Text(
          "Puntos: ${score.score}",
          style: const TextStyle(
            fontFamily: 'PixelifySans',
            fontSize: 14,
            color: AppColors.black,
          ),
        ),
        trailing: Text(
          "#$rank",
          style: const TextStyle(
            fontFamily: 'PixelifySans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: AppColors.primaryPurple,
          ),
        ),
      ),
    );
  }
}



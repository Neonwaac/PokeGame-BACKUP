import 'package:flutter/material.dart';
import 'package:pokegame/themes/palette.dart';

enum LetterState { empty, correct, present, absent }

class LetterBox extends StatelessWidget {
  final String letter;
  final LetterState state;
  final double size;

  const LetterBox({
    super.key,
    required this.letter,
    required this.state,
    this.size = 44.0,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color textColor = AppColors.white;

    switch (state) {
      case LetterState.correct:
        bg = AppColors.accentGreen;
        break;
      case LetterState.present:
        bg = const Color(0xFFFFC107);
        textColor = AppColors.primaryPurple;
        break;
      case LetterState.absent:
        bg = const Color(0xFFEF5350);
        break;
      case LetterState.empty:
      default:
        bg = Colors.purpleAccent.shade100;
        textColor = AppColors.primaryPurple;
        break;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primaryPurple, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.purpleTransparent,
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Text(
        (letter.isEmpty) ? '' : letter.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontSize: size * 0.42,
          fontWeight: FontWeight.bold,
          fontFamily: 'PixelifySans',
        ),
      ),
    );
  }
}
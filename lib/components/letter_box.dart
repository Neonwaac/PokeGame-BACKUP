import 'package:flutter/material.dart';

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
    final colors = Theme.of(context).colorScheme;

    Color bg;
    Color textColor = colors.onPrimary;

    switch (state) {
      case LetterState.correct:
        bg = colors.secondary;
        textColor = colors.onSecondary;
        break;
      case LetterState.present:
        bg = colors.tertiary;
        textColor = colors.onTertiary;
        break;
      case LetterState.absent:
        bg = colors.error;
        textColor = colors.onError;
        break;
      case LetterState.empty:
      default:
        bg = colors.surface;
        textColor = colors.onSurfaceVariant;
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
        border: Border.all(color: colors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: colors.primary,
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

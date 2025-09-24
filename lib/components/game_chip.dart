import 'package:flutter/material.dart';

class GameChip extends StatelessWidget {
  final String imageUrl;
  final bool isSelected;
  final bool isCorrect;
  final VoidCallback onTap;

  const GameChip({
    super.key,
    required this.imageUrl,
    required this.onTap,
    this.isSelected = false,
    this.isCorrect = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    Color borderColor = colors.outline;

    if (isSelected && isCorrect) {
      borderColor = colors.secondary;
    } else if (isSelected && !isCorrect) {
      borderColor = colors.error;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: borderColor, width: 3),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: borderColor.withOpacity(0.6),
                blurRadius: 10,
                spreadRadius: 2,
              ),
          ],
        ),
        child: CircleAvatar(
          radius: 22,
          backgroundColor: colors.surface,
          backgroundImage: NetworkImage(imageUrl),
        ),
      ),
    );
  }
}


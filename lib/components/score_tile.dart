import 'package:flutter/material.dart';

class ScoreTile extends StatelessWidget {
  final String playerName;
  final int score;
  final int position;

  const ScoreTile({
    super.key,
    required this.playerName,
    required this.score,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Theme.of(context).colorScheme.secondary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$position. $playerName",
              style: Theme.of(context).textTheme.bodyLarge),
          Text("$score pts",
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                fontFamily: 'PixelifySans',
              )),
        ],
      ),
    );
  }
}

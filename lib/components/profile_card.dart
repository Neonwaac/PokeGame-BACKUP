import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final int previousScore;
  final int gainedScore;
  const ProfileCard({
    super.key,
    required this.previousScore,
    required this.gainedScore,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.previousScore + widget.gainedScore;
    final colors = Theme.of(context).colorScheme;

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        color: colors.surfaceVariant,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: colors.primary,
            width: 2,
          ),
        ),
        elevation: 6,
        shadowColor: colors.primary,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: colors.secondary,
                child: Icon(Icons.person, size: 40, color: colors.onSecondary),
              ),
              const SizedBox(height: 12),
              Text(
                "Tu puntos totales: ${widget.previousScore}",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: colors.primary,
                      fontFamily: 'PixelifySans',
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                "Puntos ganados: ${widget.gainedScore > 0 ? "+${widget.gainedScore}" : widget.gainedScore}",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: colors.secondary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PixelifySans',
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                "Total: $total",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PixelifySans',
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



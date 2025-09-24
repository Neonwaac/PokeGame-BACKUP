// lib/components/profile_card.dart
import 'package:flutter/material.dart';
import '../themes/palette.dart';

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

    return ScaleTransition(
      scale: _scaleAnimation,
      child: Card(
        color: AppColors.pinkAccent,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(
            color: AppColors.primaryPurple,
            width: 2,
          ),
        ),
        elevation: 6,
        shadowColor: AppColors.primaryPurple,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 36,
                backgroundColor: AppColors.accentGreen,
                child: const Icon(Icons.person, size: 40, color: AppColors.white),
              ),
              const SizedBox(height: 12),
              Text(
                "Tu puntos totales: ${widget.previousScore}",
                style: const TextStyle(
                  color: AppColors.primaryPurple,
                  fontSize: 16,
                  fontFamily: 'PixelifySans',
                ),
              ),
              const SizedBox(height: 6),
              Text(
                "Puntos ganados: ${widget.gainedScore > 0 ? "+${widget.gainedScore}" : widget.gainedScore}",
                style: const TextStyle(
                  color: AppColors.accentGreen,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'PixelifySans',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Total: $total",
                style: const TextStyle(
                  color: AppColors.primaryPurple,
                  fontSize: 20,
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


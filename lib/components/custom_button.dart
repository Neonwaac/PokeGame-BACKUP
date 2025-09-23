import 'package:flutter/material.dart';
import 'package:pokegame/themes/palette.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.accentGreen,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: AppColors.primaryPurple,
              fontSize: 18,
              fontWeight: FontWeight.bold,
              fontFamily: 'PixelifySans',
            ),
          ),
        ),
      ),
    );
  }
}

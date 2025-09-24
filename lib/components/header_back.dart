import 'package:flutter/material.dart';
import 'package:pokegame/themes/palette.dart';

class HeaderBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HeaderBack({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.primaryPurple,
          fontFamily: 'PixelifySans',
          fontWeight: FontWeight.bold,
          fontSize: 22,
          letterSpacing: 1.5,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primaryPurple),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: AppColors.accentGreen,
      elevation: 6,
      shadowColor: AppColors.purpleTransparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}


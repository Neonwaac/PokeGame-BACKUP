import 'package:flutter/material.dart';
import 'package:pokegame/themes/palette.dart';

class SelectButton extends StatelessWidget {
  final String imageUrl;
  final void Function()? onTap;

  const SelectButton({
    super.key,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      
      child: Container(
        width: 320,
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(                begin: Alignment.topLeft,
                end: Alignment.bottomRight,colors:[Colors.deepPurple,const Color.fromARGB(255, 121, 89, 212), AppColors.accentGreen]),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: AspectRatio(
            aspectRatio: 1600 / 400,
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
        ),
      ),
    );
  }
}

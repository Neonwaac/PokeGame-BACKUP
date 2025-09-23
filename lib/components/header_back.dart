import 'package:flutter/material.dart';

class HeaderBack extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HeaderBack({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title,
          style: Theme.of(context).textTheme.headlineLarge),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back,
            color: Theme.of(context).colorScheme.secondary),
        onPressed: () => Navigator.pop(context),
      ),
      backgroundColor: Theme.of(context).colorScheme.primary,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

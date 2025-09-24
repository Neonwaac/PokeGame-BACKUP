import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pokegame/components/select_button.dart';
import 'package:pokegame/pages/about_page.dart';
import 'package:pokegame/pages/guess_type_page.dart';
import 'package:pokegame/pages/pokedle_page.dart';
import 'package:pokegame/pages/ranking_page.dart';
import 'package:pokegame/services/auth/auth_gate.dart';
import 'package:pokegame/services/auth/auth_service.dart';
import 'package:pokegame/services/game/score_service.dart';
import 'package:pokegame/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideAnimations = List.generate(
      4,
      (index) => Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(
            0.1 * index,
            0.6 + 0.1 * index,
            curve: Curves.easeOut,
          ),
        ),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final user = FirebaseAuth.instance.currentUser;
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorScheme.onPrimary,
        actions: [
          Row(
            children: [
              Icon(
                themeProvider.isDarkMode
                    ? Icons.dark_mode
                    : Icons.light_mode,
                color: colorScheme.onSecondary,
              ),
              Switch(
                value: themeProvider.isDarkMode,
                onChanged: (value) {
                  themeProvider.toggleTheme(value);
                },
                activeThumbColor: colorScheme.onSecondary,
                inactiveThumbColor: colorScheme.onPrimary,
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // 🔹 Logo
                Image.network("https://i.imgur.com/UazX9hl.png", height: 160),
                const SizedBox(height: 32),

                // 🔹 Título
                Text(
                  "Menú de selección",
                  style: textTheme.headlineLarge?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 32),

                // 🔹 Botones con animación
                SlideTransition(
                  position: _slideAnimations[0],
                  child: SelectButton(
                    imageUrl: "https://i.imgur.com/McnUoQF.png",
                    onTap: () => goTo(context, const PokedlePage()),
                  ),
                ),
                SlideTransition(
                  position: _slideAnimations[1],
                  child: SelectButton(
                    imageUrl: "https://i.imgur.com/A0aovrS.png",
                    onTap: () => goTo(context, const GuessTypePage()),
                  ),
                ),
                SlideTransition(
                  position: _slideAnimations[2],
                  child: SelectButton(
                    imageUrl: "https://i.imgur.com/2whFy5P.png",
                    onTap: () => goTo(context, const AboutPage()),
                  ),
                ),
                SlideTransition(
                  position: _slideAnimations[3],
                  child: SelectButton(
                    imageUrl: "https://i.imgur.com/tovxSqj.png",
                    onTap: () => goTo(context, const RankingPage()),
                  ),
                ),

                const SizedBox(height: 10),

                // 🔹 Login / Logout condicional
                if (user == null)
                  TextButton(
                    onPressed: () => goTo(context, const AuthGate()),
                    child: Text(
                      "Iniciar Sesión",
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                else ...[
                  Container(
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        colors: [
                          colorScheme.surface,
                          colorScheme.primary,

                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.shadow,
                          blurRadius: 6,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        Text(
                          user.email ?? "Usuario",
                          style: textTheme.bodyLarge?.copyWith(
                            color: colorScheme.onPrimary, 
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FutureBuilder<int>(
                          future: ScoreService().getUserScore(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator(
                                strokeWidth: 2,
                                color: colorScheme.onPrimary,
                              );
                            }
                            final score = snapshot.data ?? 0;
                            return Text(
                              "Puntuación total: $score",
                              style: textTheme.bodyLarge?.copyWith(
                                color: colorScheme.onPrimary,
                                fontSize: 16,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colorScheme.error,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 14,
                      ),
                    ),
                    onPressed: () async {
                      await AuthService().signOut();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomePage()),
                        (route) => false,
                      );
                    },
                    child: Text(
                      "Cerrar Sesión",
                      style: textTheme.bodyLarge?.copyWith(
                        color: colorScheme.onError,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
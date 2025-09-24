import 'package:flutter/material.dart';
import 'package:pokegame/services/auth/auth_service.dart';
import 'package:pokegame/themes/palette.dart';
import '../components/custom_textfield.dart';
import '../components/custom_button.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback? onRegisterTap;
  const LoginPage({super.key, required this.onRegisterTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  bool isLoading = false;

  void login() async {
    setState(() => isLoading = true);
    try {
      await authService.signIn(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (mounted) Navigator.pop(context); // ✅ vuelve al AuthGate
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.errorRed,
          content: Text(
            e.toString(),
            style: const TextStyle(color: AppColors.white),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryPurple, AppColors.accentBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              color: AppColors.purpleTransparent,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              margin: const EdgeInsets.all(24),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Logo animado
                    AnimatedScale(
                      scale: 1,
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.elasticOut,
                      child: Image.network(
                        "https://i.imgur.com/UazX9hl.png",
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 24),

                    Text("Inicia Sesión",
                        style: textTheme.headlineSmall?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 24),

                    CustomTextField(
                      hintText: "Correo",
                      obscureText: false,
                      controller: emailController,
                      prefixIcon: Icons.email,
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      hintText: "Contraseña",
                      obscureText: true,
                      controller: passwordController,
                      prefixIcon: Icons.lock,
                    ),
                    const SizedBox(height: 24),

                    isLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.accentGreen)
                        : CustomButton(text: "Iniciar Sesión", onTap: login),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: widget.onRegisterTap,
                      child: const Text.rich(
                        TextSpan(
                          text: "¿No tienes cuenta? ",
                          style: TextStyle(color: AppColors.accentGreen),
                          children: [
                            TextSpan(
                              text: "Regístrate",
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

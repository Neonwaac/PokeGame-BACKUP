import 'package:flutter/material.dart';
import 'package:pokegame/services/auth/auth_service.dart';
import 'package:pokegame/themes/palette.dart';
import '../components/custom_textfield.dart';
import '../components/custom_button.dart';

class RegisterPage extends StatefulWidget {
  final VoidCallback onLoginTap;
  const RegisterPage({super.key, required this.onLoginTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authService = AuthService();
  bool isLoading = false;

  void register() async {
    setState(() => isLoading = true);
    try {
      await authService.signUp(
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
            colors: [AppColors.primaryPurple, AppColors.accentGreen],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
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

                    Text("Regístrate",
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
                        : CustomButton(text: "Registrarse", onTap: register),

                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: widget.onLoginTap,
                      child: const Text.rich(
                        TextSpan(
                          text: "¿Ya tienes cuenta? ",
                          style: TextStyle(color: AppColors.accentGreen),
                          children: [
                            TextSpan(
                              text: "Inicia sesión",
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

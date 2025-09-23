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

  void register() async {
    try {
      await authService.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
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
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.accentGreen,
        title: const Text(
          "Registrarse",
          style: TextStyle(color: AppColors.primaryPurple),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryPurple),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🔹 Logo vacío
                Image.network("https://i.imgur.com/UazX9hl.png", height: 180),
                const SizedBox(height: 32),

                // 🔹 Título
                Text("Regístrate", style: textTheme.headlineLarge),
                const SizedBox(height: 24),

                // 🔹 Campo Email
                CustomTextField(
                  hintText: "Correo",
                  obscureText: false,
                  controller: emailController,
                  prefixIcon: Icons.email,
                ),
                const SizedBox(height: 16),

                // 🔹 Campo Password
                CustomTextField(
                  hintText: "Contraseña",
                  obscureText: true,
                  controller: passwordController,
                  prefixIcon: Icons.lock,
                ),
                const SizedBox(height: 24),

                // 🔹 Botón Registro
                CustomButton(text: "Registrarse", onTap: register),
                const SizedBox(height: 16),

                // 🔹 Cambiar a Login
                TextButton(
                  onPressed: widget.onLoginTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿Ya tienes cuenta? ",
                        style: TextStyle(color: AppColors.accentGreen),
                      ),
                      const Text(
                        "Inicia sesión",
                        style: TextStyle(
                          color: Colors.pink,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

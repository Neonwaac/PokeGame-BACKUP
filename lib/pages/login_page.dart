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

  void login() async {
    try {
      await authService.signIn(
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
        title: const Text("Iniciar Sesión", style: TextStyle(color: AppColors.primaryPurple),),
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
                Text("Inicia Sesión", style: textTheme.headlineLarge),
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

                // 🔹 Botón Login
                CustomButton(text: "Iniciar Sesión", onTap: login),
                const SizedBox(height: 16),

                // 🔹 Cambiar a Registro
                TextButton(
                  onPressed: widget.onRegisterTap,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "¿No tienes cuenta? ",
                        style: TextStyle(color: AppColors.accentGreen),
                      ),
                      const Text(
                        "Regístrate",
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

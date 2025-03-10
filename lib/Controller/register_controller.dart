import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/register_model.dart';

class RegisterController {
  final RegisterModel _model = RegisterModel();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? selectedRole;
  bool isLoading = false;
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  void togglePasswordVisibility(Function updateState) {
    updateState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void toggleConfirmPasswordVisibility(Function updateState) {
    updateState(() {
      isConfirmPasswordVisible = !isConfirmPasswordVisible;
    });
  }

  Future<void> register(BuildContext context, Function updateState) async {
    updateState(() => isLoading = true);

    // Validación del rol antes de registrar
    if (selectedRole == null || selectedRole!.isEmpty) {
      updateState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Debe seleccionar un rol')),
      );
      return;
    }

    String? errorMessage = await _model.registerUser(
      fullName: fullNameController.text,
      email: emailController.text,
      password: passwordController.text,
      confirmPassword: confirmPasswordController.text,
      role: selectedRole!,
    );

    updateState(() => isLoading = false);

    if (errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMessage)));
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('Registro Exitoso 🎉'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Usuario registrado con éxito.'),
              SizedBox(height: 8),
              Text('📧 Correo: ${emailController.text}', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('🔑 Contraseña: ${passwordController.text}', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                fullNameController.clear();
                emailController.clear();
                passwordController.clear();
                confirmPasswordController.clear();
                updateState(() => selectedRole = null);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }
}

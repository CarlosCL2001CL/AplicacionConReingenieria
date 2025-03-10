


import 'package:flutter/material.dart';
import 'package:flutter_application_1/Model/login_model.dart';

import '../View/home_page.dart';

class LoginController {
  final LoginModel _model = LoginModel();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  void login(BuildContext context, Function updateState) {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingrese su usuario y contraseña')),
      );
      return;
    }

    updateState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      updateState(() {
        isLoading = false;
      });

      if (_model.authenticate(usernameController.text, passwordController.text)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Credenciales incorrectas")),
        );
      }
    });
  }

  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
  }
}

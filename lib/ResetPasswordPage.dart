import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<void> _sendPasswordResetEmail() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingrese su correo electrónico')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Se ha enviado un correo para restablecer la contraseña.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recuperar Contraseña'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Ingrese su correo electrónico y le enviaremos un enlace para restablecer su contraseña.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Correo electrónico',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
  onPressed: _sendPasswordResetEmail,
  child: Text(
    'Enviar',
    style: TextStyle(
      color: Colors.white, // Cambiar el color del texto a blanco
    ),
  ),
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.blueAccent, // Color de fondo del botón
    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 80),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
),

          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
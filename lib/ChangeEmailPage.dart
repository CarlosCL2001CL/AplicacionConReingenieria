import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangeEmailPage extends StatefulWidget {
  @override
  _ChangeEmailPageState createState() => _ChangeEmailPageState();
}

class _ChangeEmailPageState extends State<ChangeEmailPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _changeEmail() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        User? user = FirebaseAuth.instance.currentUser;
        String newEmail = _newEmailController.text.trim();
        String password = _passwordController.text.trim();

        // Reautenticación del usuario con la contraseña actual
        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: password,
        );

        await user.reauthenticateWithCredential(credential);

        // Utilizar el método recomendado verifyBeforeUpdateEmail
        await user.verifyBeforeUpdateEmail(newEmail);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Se ha enviado un correo de verificación al nuevo correo.')),
        );

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        String message;
        switch (e.code) {
          case 'requires-recent-login':
            message = 'Necesitas volver a iniciar sesión para cambiar tu correo electrónico.';
            break;
          case 'invalid-email':
            message = 'El correo electrónico proporcionado no es válido.';
            break;
          case 'email-already-in-use':
            message = 'El correo electrónico ya está en uso por otra cuenta.';
            break;
          case 'wrong-password':
            message = 'La contraseña actual es incorrecta.';
            break;
          default:
            message = 'Error al actualizar el correo electrónico: ${e.message}';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _newEmailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cambiar Correo Electrónico'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _newEmailController,
                        decoration: InputDecoration(
                          labelText: 'Nuevo Correo Electrónico',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa un correo electrónico.';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Por favor, ingresa un correo electrónico válido.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: 'Contraseña Actual',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, ingresa tu contraseña actual.';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _changeEmail,
                        child: Text('Actualizar Correo'),
                      ),
                    ],
                  ),
                ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/register_controller.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController _controller = RegisterController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 20),
                  _buildInputField('Nombre completo', Icons.person, _controller.fullNameController),
                  SizedBox(height: 12),
                  _buildInputField('Correo electrónico', Icons.email, _controller.emailController, isEmail: true),
                  SizedBox(height: 12),
                  _buildPasswordField('Contraseña', _controller.passwordController, true),
                  SizedBox(height: 12),
                  _buildPasswordField('Confirmar contraseña', _controller.confirmPasswordController, false),
                  SizedBox(height: 12),
                  _buildDropdown(),
                  SizedBox(height: 20),
                  _controller.isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: () => _controller.register(context, setState),
                          child: Text('Registrar'),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField(String label, IconData icon, TextEditingController controller, {bool isEmail = false}) {
    return TextField(
      controller: controller,
      keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.blueAccent),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !_controller.isPasswordVisible : !_controller.isConfirmPasswordVisible,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.lock, color: Colors.blueAccent),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        suffixIcon: IconButton(
          icon: Icon(
            isPassword
                ? (_controller.isPasswordVisible ? Icons.visibility : Icons.visibility_off)
                : (_controller.isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
            color: Colors.blueAccent,
          ),
          onPressed: () {
            isPassword ? _controller.togglePasswordVisibility(setState) : _controller.toggleConfirmPasswordVisibility(setState);
          },
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: _controller.selectedRole,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
      hint: Text('Seleccionar rol'),
      items: ['Psicología', 'Terapia']
          .map((role) => DropdownMenuItem(value: role, child: Text(role)))
          .toList(),
      onChanged: (value) => setState(() => _controller.selectedRole = value),
    );
  }
}
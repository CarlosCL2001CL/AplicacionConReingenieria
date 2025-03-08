import 'package:cloud_firestore/cloud_firestore.dart'; // Asegúrate de importar Firestore
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _fullNameController = TextEditingController(); // Controlador para el nombre completo
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Firestore instance

  String? _selectedRole; // Para almacenar el rol seleccionado
  bool _isLoading = false; // Para mostrar un indicador de carga
  bool _isPasswordVisible = false; // Para controlar la visibilidad de la contraseña
  bool _isConfirmPasswordVisible = false; // Para controlar la visibilidad de la confirmación de la contraseña

  // Función para validar la contraseña
  String? _validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'La contraseña es requerida';
    }
    if (password.length < 12) {
      return 'La contraseña debe tener al menos 12 caracteres';
    }
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(password)) {
      return 'La contraseña debe contener al menos una letra minúscula';
    }
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(password)) {
      return 'La contraseña debe contener al menos una letra mayúscula';
    }
    if (!RegExp(r'^(?=.*[0-9])').hasMatch(password)) {
      return 'La contraseña debe contener al menos un número';
    }
    if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password)) {
      return 'La contraseña debe contener al menos un carácter especial';
    }
    return null;
  }

  Future<void> _register() async {
    if (_fullNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, complete todos los campos')),
      );
      return;
    }

    if (_fullNameController.text.length < 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('El nombre completo debe tener al menos 10 caracteres')),
      );
      return;
    }

    if (!_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingrese un correo electrónico válido')),
      );
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    String? passwordError = _validatePassword(_passwordController.text);
    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(passwordError)),
      );
      return;
    }

    if (_selectedRole == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, seleccione un rol')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Iniciar indicador de carga
    });

    try {
      // Crear usuario en Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Actualiza el perfil del usuario con el nombre completo
      await userCredential.user!.updateProfile(displayName: _fullNameController.text);
      await userCredential.user!.reload(); // Recargar para aplicar los cambios

      // Almacenar la información del usuario en Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'full_name': _fullNameController.text,
        'email': _emailController.text,
        'role': _selectedRole,
        'uid': userCredential.user!.uid,
      });

      // Mostrar mensaje de éxito con showDialog
      showDialog(
        context: context,
        barrierDismissible: false, // Evita que se cierre tocando fuera
        builder: (context) {
          return AlertDialog(
            title: Text('Registro Exitoso 🎉'),
            content: Text(
              'Correo: ${_emailController.text}\n'
              'Contraseña: ${_passwordController.text}',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Cerrar el diálogo

                  // Limpiar los campos después de cerrar el diálogo
                  _fullNameController.clear();
                  _emailController.clear();
                  _passwordController.clear();
                  _confirmPasswordController.clear();

                  setState(() {
                    _selectedRole = null; // Restablecer el rol seleccionado
                  });
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'email-already-in-use':
          errorMessage = 'El correo ya está en uso.';
          break;
        case 'invalid-email':
          errorMessage = 'El correo electrónico no tiene un formato válido.';
          break;
        case 'weak-password':
          errorMessage = 'La contraseña es muy débil.';
          break;
        default:
          errorMessage = 'Ocurrió un error inesperado (${e.code}). Intente nuevamente.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );

      print('Error de autenticación: ${e.code}');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error inesperado: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false; // Detener indicador de carga
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Imagen del ícono en la parte superior
                    Container(
                      padding: EdgeInsets.all(8),
                    ),
                    // (Imagen y texto del encabezado se mantienen iguales)

                    // Campo para el nombre completo
                    TextField(
                      controller: _fullNameController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person, color: Colors.blueAccent),
                        labelText: 'Nombre completo',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Campo de correo electrónico
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline, color: Colors.blueAccent),
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),

                    // Campo de contraseña
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Campo de confirmación de contraseña
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: !_isConfirmPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_outline, color: Colors.blueAccent),
                        labelText: 'Confirmar contraseña',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Menú desplegable para seleccionar el rol
                    DropdownButtonFormField<String>(
                      value: _selectedRole,
                      hint: Text('Seleccionar rol'),
                      items: ['Psicología', 'Terapia']
                          .map((role) => DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedRole = value;
                        });
                      },
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              padding: EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                            ),
                            child: Text(
                              'Registrar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Home.dart'; // Asegúrate de que este archivo exista
import 'RegisterPage.dart'; // Importa el archivo de registro

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false; // Para mostrar un indicador de carga

  Future<void> _login() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Por favor, ingrese su correo y contraseña')),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Iniciar indicador de carga
    });

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        // Obtener el rol del usuario desde Firestore
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        if (userDoc.exists) {
          String userRol = userDoc['role']; // Asegúrate de que el campo 'rol' esté en el documento de Firestore

          // Navegar a la página principal pasando el rol del usuario
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(userRol: userRol), // Pasa el rol a la página principal
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('El usuario no tiene un rol asignado.')),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'El correo electrónico no tiene un formato válido.';
          break;
        case 'user-disabled':
          errorMessage = 'El usuario ha sido deshabilitado.';
          break;
        case 'user-not-found':
          errorMessage = 'No se encontró un usuario con ese correo electrónico.';
          break;
        case 'wrong-password':
          errorMessage = 'Contraseña incorrecta.';
          break;
        default:
          errorMessage = 'Ocurrió un error inesperado (${e.code}). Intente nuevamente.';
      }

      // Mostrar mensaje de error en el UI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
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
              SizedBox(height: 200),

              // Caja con la imagen y campos de usuario/contraseña
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
                      offset: Offset(0, 3), // Cambia la posición de la sombra
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Imagen del ícono en la parte superior
                    Container(
                      padding: EdgeInsets.all(8),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/imagenes/san-miguel.png', // Imagen del ángel
                          width: 70,
                          height: 100,
                        ),
                        SizedBox(width: 10), // Espacio entre la imagen y el texto
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Fundación de niños especiales',
                                style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                '"SAN MIGUEL" FUNESAMI',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 5),
                              Text(
                                'Gestión de Historias clínicas',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 92, 60, 60),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),

                    // Campo de correo electrónico
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline,
                            color: Colors.blueAccent),
                        labelText: 'Correo electrónico',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),

                    // Campo de contraseña
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.lock_outline, color: Colors.blueAccent),
                        labelText: 'Contraseña',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueAccent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.blueAccent, width: 2),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent, // Color del botón
                              padding: EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 80),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Ingresar',
                              style: TextStyle(
                                  color: Colors.white), // Color del texto
                            ),
                          ),
                    SizedBox(height: 10),

                    // Enlace a la página de registro
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()), // Asegúrate de que RegisterPage esté definido
                        );
                      },
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                          decoration: TextDecoration.none, // Sin subrayado
                          color: Colors.blueAccent,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

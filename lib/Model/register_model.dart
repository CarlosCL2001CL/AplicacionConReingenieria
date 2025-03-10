import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterModel {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Validación de contraseña
  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) return 'La contraseña es requerida';
    if (password.length < 12) return 'La contraseña debe tener al menos 12 caracteres';
    if (!RegExp(r'^(?=.*[a-z])').hasMatch(password)) return 'La contraseña debe contener al menos una minúscula';
    if (!RegExp(r'^(?=.*[A-Z])').hasMatch(password)) return 'La contraseña debe contener al menos una mayúscula';
    if (!RegExp(r'^(?=.*[0-9])').hasMatch(password)) return 'La contraseña debe contener al menos un número';
    if (!RegExp(r'^(?=.*[!@#$%^&*(),.?":{}|<>])').hasMatch(password)) return 'La contraseña debe contener un carácter especial';
    return null;
  }

  // Registro de usuario
  Future<String?> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required String role,
  }) async {
    if (fullName.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      return 'Por favor, complete todos los campos';
    }
    if (fullName.length < 10) return 'El nombre completo debe tener al menos 10 caracteres';
    if (!email.contains('@')) return 'Ingrese un correo válido';
    if (password != confirmPassword) return 'Las contraseñas no coinciden';

    String? passwordError = validatePassword(password);
    if (passwordError != null) return passwordError;

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await userCredential.user!.updateProfile(displayName: fullName);
      await userCredential.user!.reload();

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'full_name': fullName,
        'email': email,
        'role': role,
        'uid': userCredential.user!.uid,
      });

      return null; // Registro exitoso
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return 'El correo ya está en uso';
      if (e.code == 'invalid-email') return 'Correo inválido';
      if (e.code == 'weak-password') return 'La contraseña es muy débil';
      return 'Error inesperado (${e.code})';
    } catch (e) {
      return 'Error inesperado: ${e.toString()}';
    }
  }
}

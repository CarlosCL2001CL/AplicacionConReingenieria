import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getUsersStream() {
    return _firestore.collection('users').snapshots();
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }
}

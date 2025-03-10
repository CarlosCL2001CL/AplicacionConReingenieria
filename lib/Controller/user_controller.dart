


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Model/user_model.dart';

class UserController {
  final UserModel _model = UserModel();
  String searchQuery = "";

  Stream<QuerySnapshot> getUsers() {
    return _model.getUsersStream();
  }

  List<QueryDocumentSnapshot> filterUsers(List<QueryDocumentSnapshot> users) {
    return users.where((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      String email = data?["email"]?.toString().toLowerCase() ?? "";
      return email.contains(searchQuery);
    }).toList();
  }

  Future<void> deleteUser(String uid) async {
    await _model.deleteUser(uid);
  }

  void updateSearchQuery(String query) {
    searchQuery = query.toLowerCase();
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EditUsers extends StatefulWidget {
  @override
  _EditUsersState createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = "";
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: "Buscar por correo",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                final users = snapshot.data!.docs.where((doc) {
                  Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
                  String email = data != null && data.containsKey("email") ? data["email"] : "";
                  return email.toLowerCase().contains(searchQuery);
                }).toList();

                return ListView.separated(
                  itemCount: users.length,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    Map<String, dynamic>? data = users[index].data() as Map<String, dynamic>?;
                    String uid = users[index].id;
                    String email = data != null && data.containsKey("email") ? data["email"] : "Sin email";
                    String full_name = data != null && data.containsKey("full_name") ? data["full_name"] : "Sin nombre";
                    String role = data != null && data.containsKey("role") ? data["role"] : "Sin rol";

                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(full_name, style: TextStyle(fontWeight: FontWeight.bold)),
                          Text(email, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      subtitle: Text(role),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteUser(uid),
                      ),                       
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteUser(String uid) async {
    try {
      await _firestore.collection('users').doc(uid).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Usuario eliminado correctamente.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al eliminar el usuario')),
      );
    }
  }
}
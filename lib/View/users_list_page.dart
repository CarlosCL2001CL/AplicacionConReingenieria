import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/Controller/user_controller.dart';

class EditUsers extends StatefulWidget {
  @override
  _EditUsersState createState() => _EditUsersState();
}

class _EditUsersState extends State<EditUsers> {
  final UserController _controller = UserController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Aplica padding general a la pantalla
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: "Buscar por correo",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _controller.updateSearchQuery(value);
                });
              },
            ),
            SizedBox(height: 10), // Espacio entre el campo de búsqueda y la lista
            Expanded(
              child: StreamBuilder(
                stream: _controller.getUsers(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  final users = _controller.filterUsers(snapshot.data!.docs);

                  return ListView.separated(
                    itemCount: users.length,
                    separatorBuilder: (context, index) => Divider(),
                    itemBuilder: (context, index) {
                      var data = users[index].data() as Map<String, dynamic>;
                      String uid = users[index].id;
                      String email = data["email"] ?? "Sin email";
                      String fullName = data["full_name"] ?? "Sin nombre";
                      String role = data["role"] ?? "Sin rol";

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0), // Espacio entre elementos de la lista
                        child: ListTile(
                          title: Text(fullName, style: TextStyle(fontWeight: FontWeight.bold)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(email, style: TextStyle(color: Colors.grey)),
                              Text('Rol: $role'),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              await _controller.deleteUser(uid);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Usuario eliminado correctamente')),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

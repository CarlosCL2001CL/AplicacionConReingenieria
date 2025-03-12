import 'package:flutter/material.dart';

import 'LoginPage.dart';
import 'RegisterPage.dart';
import 'UsersListPage.dart';


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Tres pestañas
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: const Color.fromARGB(255, 0, 0, 0)),
          bottom: TabBar(
            indicatorColor: Color.fromARGB(213, 56, 123, 232),
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Home'),
              Tab(icon: Icon(Icons.app_registration), text: 'Registro'),
              Tab(icon: Icon(Icons.app_registration), text: 'Listado'),
            ],
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.logout, color: const Color.fromARGB(255, 0, 0, 0), size: 30),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            InicioTabState(),
            RegisterPage(),
            EditUsers(),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class InicioTabState extends StatelessWidget {
  String fullName = 'ADMIN';

  InicioTabState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Center(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Fundación ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    '"UNA MIRADA FELIZ"',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Bienvenida con el nombre del usuario
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Bienvenido/a ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    fullName,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),            

              // Imagen del ángel
              Image.asset(
                'assets/imagenes/san-miguel.png', // Ruta de la imagen
                width: 350,
                height: 350,
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // Pie de página con el crédito de desarrollo
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              '© Desarrollado por ',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
              ),
            ),
            Text(
              'Carlos Eduardo López Candelejo',
              style: TextStyle(
                fontSize: 13,
                color: Colors.blueAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

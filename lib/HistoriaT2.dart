import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necesario para formatear la fecha

class HistoriaT2 extends StatefulWidget {
  const HistoriaT2({super.key});

  @override
  _HistoriaState createState() => _HistoriaState();
}

class _HistoriaState extends State<HistoriaT2> {
  // Variables para la fecha de nacimiento, la edad y la fecha de evaluación
  DateTime? _selectedDate;
  DateTime? _evaluationDate; // Nueva variable para la fecha de evaluación
  int _age = 0;

  // Función para mostrar el calendario y seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(), // Fecha inicial
      firstDate: DateTime(1900), // Fecha mínima
      lastDate: DateTime.now(), // Fecha máxima
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _age = _calculateAge(_selectedDate!);
      });
    }
  }

  // Función para seleccionar la fecha de evaluación
  Future<void> _selectEvaluationDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _evaluationDate) {
      setState(() {
        _evaluationDate = picked;
      });
    }
  }

  // Función para calcular la edad a partir de la fecha seleccionada
  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historia Clínica Psicológica',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(224, 68, 137, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con imagen y texto
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/imagenes/san-miguel.png',
                    width: 117,
                    height: 125,
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'FUNDACIÓN DE NIÑOS ESPECIALES',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '“SAN MIGUEL” FUNESAMI',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Acuerdo Ministerial 078-08',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'HISTORIA CLÍNICA PSICOLÓGICA',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Align(
                        alignment: Alignment.center, // Esto centra el texto
                        child: Text(
                          'HISTORIA CLINICA DE NIÑOS',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(
                                255, 255, 0, 0), // Cambia el color aquí
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Sección 1: Datos Personales
            const Text(
              '1.- DATOS PERSONALES:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombres y Apellidos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Fecha de nacimiento y cálculo automático de la edad
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Fecha de Nacimiento',
                        border: OutlineInputBorder(),
                      ),
                      child: Text(
                        _selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
                            : 'Seleccione una fecha',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    enabled: false,
                    controller: TextEditingController(
                      text: _age.toString(),
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Edad',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Campo de Curso Escolar Actual
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Curso Escolar Actual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Campo de Institución
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Institución',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Nombres de los padres
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Papá',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la Mamá',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // Dirección
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Teléfono
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Remisión
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Remisión',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Fecha de Evaluación
            InkWell(
              onTap: () => _selectEvaluationDate(context),
              child: InputDecorator(
                decoration: const InputDecoration(
                  labelText: 'Fecha de Evaluación',
                  border: OutlineInputBorder(),
                ),
                child: Text(
                  _evaluationDate != null
                      ? DateFormat('dd/MM/yyyy').format(_evaluationDate!)
                      : 'Seleccione una fecha',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 10),
            // Campo Final de Cobertura
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Final de Cobertura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Observaciones.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Responsable',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

// Sección 2: Motivo de Consulta
            const Text(
              '2.- MOTIVO DE CONSULTA:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa el motivo de la consulta',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sección 3: Desencadenantes
            const Text(
              '3.- DESENCADENANTES DE MOTIVO DE CONSULTA:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa los desencadenantes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sección 4: Antecedentes Familiares
            const Text(
              '4.- ANTECEDENTES FAMILIARES:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Datos de embarazo y parto.',
                border: OutlineInputBorder(),
              ),
            ),
              const SizedBox(height: 5),
            TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Desarrollo Psicomotor.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Desarrollo del lenguaje.',
                border: OutlineInputBorder(),
              ),
            ),
              const SizedBox(height: 5),
            TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Desarrollo Intelectual.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            TextFormField(
              maxLines: 1,
              decoration: const InputDecoration(
                labelText: 'Desarrollo Socio-Afectivo.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sección 5: Antecedentes y estrructura Familiares
            const Text(
              '5.- ANTECEDENTES Y ESTRUCTURA FAMILIAR:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa los antecedentes y  estructura familiar.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sección 6: Pruebas aplicadas
            const Text(
              '6.- PRUEBAS APLICADAS:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa las pruebas aplicadas.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sección 7: Impresion diagnostica
            const Text(
              '7.- IMPRESIÓN DIAGNÓSTICA:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa la impresión diagnóstica.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Sección 8: areas de intervencion
            const Text(
              '8.- ÁREAS DE INTERVENCIÓN:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa las areas de intervención.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Botón ENVIAR
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Lógica para ENVIAR el formulario
                },
                child: const Text('ENVIAR'),
              ),
            ),

            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoriaAdult extends StatefulWidget {
  const HistoriaAdult({super.key});

  @override
  _HistoriaAdultState createState() => _HistoriaAdultState();
}

class _HistoriaAdultState extends State<HistoriaAdult> {
  DateTime? _selectedDate;
  DateTime? _evaluationDate;
  int _age = 0;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _cursoController = TextEditingController();
  final TextEditingController _institucionController = TextEditingController();
  final TextEditingController _nombrePapaController = TextEditingController();
  final TextEditingController _nombreMamaController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _remisionController = TextEditingController();
  final TextEditingController _coberturaController = TextEditingController();
  final TextEditingController _observacionesController = TextEditingController();
  final TextEditingController _responsableController = TextEditingController();
  final TextEditingController _motivoConsultaController = TextEditingController();
  final TextEditingController _desencadenantesController = TextEditingController();
  final TextEditingController _antecedentesGController = TextEditingController();
 

  final TextEditingController _estructuraFamiliarController = TextEditingController();
  final TextEditingController _pruebasController = TextEditingController();
  final TextEditingController _impresionDiagnosticaController = TextEditingController();
  final TextEditingController _areasIntervencionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _age = _calculateAge(_selectedDate!);
      });
    }
  }

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

  int _calculateAge(DateTime birthDate) {
    DateTime today = DateTime.now();
    int age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return age;
  }

  Future<void> _submitForm() async {
    // Verificación de que todos los campos estén llenos
    if (_nombreController.text.isEmpty ||
        _cursoController.text.isEmpty ||
        _institucionController.text.isEmpty ||
        _nombrePapaController.text.isEmpty ||
        _nombreMamaController.text.isEmpty ||
        _direccionController.text.isEmpty ||
        _telefonoController.text.isEmpty ||
        _remisionController.text.isEmpty ||
        _coberturaController.text.isEmpty ||
        _observacionesController.text.isEmpty ||
        _responsableController.text.isEmpty ||
        _motivoConsultaController.text.isEmpty ||
        _desencadenantesController.text.isEmpty || 
        _antecedentesGController.text.isEmpty ||       
        _estructuraFamiliarController.text.isEmpty ||
        _pruebasController.text.isEmpty ||
        _impresionDiagnosticaController.text.isEmpty ||
        _areasIntervencionController.text.isEmpty ||
        _selectedDate == null ||
        _evaluationDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Verifique que todos los campos estén llenos antes de enviar el formulario'),
        ),
      );
      return;
    }

    // Validación para el campo de teléfono (solo números)
    if (!RegExp(r'^[0-9]+$').hasMatch(_telefonoController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('En el campo de teléfono solo se permiten números'),
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('HistoriaAdult').add({
        'nombres': _nombreController.text,
        'fechaNacimiento': _selectedDate!.toIso8601String(),
        'edad': _age,
        'curso': _cursoController.text,
        'institucion': _institucionController.text,
        'nombrePapa': _nombrePapaController.text,
        'nombreMama': _nombreMamaController.text,
        'direccion': _direccionController.text,
        'telefono': _telefonoController.text,
        'remision': _remisionController.text,
        'fechaEvaluacion': _evaluationDate!.toIso8601String(),
        'cobertura': _coberturaController.text,
        'observaciones': _observacionesController.text,
        'responsable': _responsableController.text,
        'motivoConsulta': _motivoConsultaController.text,
        'desencadenantes': _desencadenantesController.text, 
        'antecedenteG': _antecedentesGController.text,       
        'estructuraFamiliar': _estructuraFamiliarController.text,
        'pruebas': _pruebasController.text,
        'impresionDiagnostica': _impresionDiagnosticaController.text,
        'areasIntervencion': _areasIntervencionController.text,
        'fechaCreacion': DateTime.now().toIso8601String(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Formulario enviado con éxito')),
      );

      // Limpiar el formulario y resetear los campos
      _nombreController.clear();
      _cursoController.clear();
      _institucionController.clear();
      _nombrePapaController.clear();
      _nombreMamaController.clear();
      _direccionController.clear();
      _telefonoController.clear();
      _remisionController.clear();
      _coberturaController.clear();
      _observacionesController.clear();
      _responsableController.clear();
      _motivoConsultaController.clear();
      _desencadenantesController.clear();   
      _antecedentesGController.clear();   
      _estructuraFamiliarController.clear();
      _pruebasController.clear();
      _impresionDiagnosticaController.clear();
      _areasIntervencionController.clear();
      setState(() {
        _selectedDate = null;
        _evaluationDate = null;
        _age = 0;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al enviar el formulario: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(        
        
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
                        alignment: Alignment.center, 
                        child: Text(
                          'HISTORIA CLINICA DE ADULTOS',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 255, 0, 0),
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
              controller: _nombreController,
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
              controller: _cursoController,
              decoration: const InputDecoration(
                labelText: 'Curso Escolar Actual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Campo de Institución
            TextFormField(
              controller: _institucionController,
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
                     controller: _nombrePapaController,
                    decoration: const InputDecoration(
                      labelText: 'Nombre del Papá',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    controller: _nombreMamaController,
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
              controller: _direccionController,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Teléfono
            TextFormField(
              controller: _telefonoController,
              decoration: const InputDecoration(
                labelText: 'Teléfono',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Remisión
            TextFormField(
              controller: _remisionController,
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
              controller: _coberturaController,
              decoration: const InputDecoration(
                labelText: 'Final de Cobertura',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _observacionesController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Observaciones.',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _responsableController,
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
              controller: _motivoConsultaController,
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
              controller: _desencadenantesController,
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
              controller: _antecedentesGController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa los antecedentes',
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
              controller: _estructuraFamiliarController,
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
              controller: _pruebasController,
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
              controller: _impresionDiagnosticaController,
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
              controller: _areasIntervencionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Describa las areas de intervención.',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            // Botón para enviar el formulario
            // Center(
            //   child: ElevatedButton(
            //     onPressed: _submitForm,
            //     child: const Text('Enviar'),
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitForm,
        child: const Icon(Icons.save),
      ),
    );
  }
}
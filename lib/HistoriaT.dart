import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // Para manejar la selección de fechas
import 'SearchHistoriaPage.dart';

class HistoriaT extends StatefulWidget {
  @override
  _HistoriaTState createState() => _HistoriaTState();
}

class _HistoriaTState extends State<HistoriaT> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {};
  // List to hold information about family members
  List<Map<String, dynamic>> familyMembers = [];

  // Method to add a new family member entry
  void _addFamilyMember() {
    setState(() {
      familyMembers.add({'familiar': '', 'edad': '', 'observaciones': ''});
    });
  }

  final List<Map<String, dynamic>> _formFields = [
    {'name': 'nombre', 'label': 'Nombre completo'},
    {'name': 'evaluador', 'label': 'Evaluador'},
    {'name': 'escolaridad', 'label': 'Escolaridad'},
    {'name': 'institucion', 'label': 'Nombre de la Institución'},
    {'name': 'domicilio', 'label': 'Domicilio'},
    {'name': 'email', 'label': 'Email'},
    {'name': 'telefono', 'label': 'Teléfono'},
    {'name': 'entrevistador', 'label': 'Entrevistado por'},
    {'name': 'remitido', 'label': 'Remitido por'},
    {'name': 'motivoC', 'label': 'Motivo de consulta', 'multiline': true},
    {
      'name': 'caracteProbl',
      'label':
          '¿Desde cuando inicia y cuales son los síntomas? Frecuencia y manejo.',
      'multiline': true
    },
    {
      'name': 'historiaEsco',
      'label': 'Escribir institucion, éxito y fracaso.',
      'multiline': true
    },
    {'name': 'lugarAtencion', 'label': 'Lugar de atención'},
    {'name': 'tiempo', 'label': 'Tiempo'},
    {'name': 'Peso', 'label': 'Peso'},
    {'name': 'Talla', 'label': 'Talla'},
    {'name': 'perimetroCefali', 'label': 'Perímetro cefálico'},
    {'name': 'apgar', 'label': 'Apgar'},
    {'name': 'Observaciones', 'label': 'Observaciones', 'multiline': true},
    {
      'name': 'intensionComunica',
      'label': 'Intensión comunicativa Hispitalizaciones',
      'multiline': true
    },
    {'name': 'traumatismo', 'label': 'traumatismo', 'multiline': true},
    {
      'name': 'infecciones',
      'label': 'Infecciones, alergias, otitis, farin.....',
      'multiline': true
    },
    {
      'name': 'reaccionPecu',
      'label': 'Reacciones peculiares vacunas',
      'multiline': true
    },
    {
      'name': 'desnutricion',
      'label': 'Desnutrición/Obesidad',
      'multiline': true
    },
    {'name': 'cirugias', 'label': 'Cirugías', 'multiline': true},
    {
      'name': 'convulsiones',
      'label': 'Convulsiones fabriles o Epilepsia....',
      'multiline': true
    },
    {'name': 'medicacion', 'label': 'Medicación', 'multiline': true},
    {'name': 'sindormes', 'label': 'Sindromes', 'multiline': true},
    {'name': 'Observaciones2', 'label': 'Observacionessss', 'multiline': true},
    {'name': 'eeTacRm', 'label': 'EE, TAC, RM....', 'multiline': true},
    {
      'name': 'aptitudIntereEscolar',
      'label': 'Describa...........',
      'multiline': true
    },
    {
      'name': 'rendiGeneescolar',
      'label': 'Describa...........',
      'multiline': true
    },
    {
      'name': 'quienViveCasa',
      'label': 'Describa quein vive en casa',
      'multiline': true
    },
  ];

  DateTime? _fechaEntrevista;
  DateTime? _fechaNacimiento;
  String? _sexoSeleccionado;
  int _edad = 0;
  String? _tipoInstitucion;
  String? _selectedValueLloro; // Para almacenar el valor de "Lloro al nacer"
  String? _selectedValueSufrimiento;
  String? _selectedValuePalmarplantar;
  String? _selectedValueMoro;
  String? _selectedValuePrension;
  String? _selectedValueDebusqueda;
  String? _selectedValueBabinski;
  String? _selectedValuePinzadigital;
  String? _selectedValueGarabateo;
  String? _selectedValueSostenerobjetos;

  //VARIABLES DE TEA
  String? _selectedValueProblemasenAlimentacion;
  String? _selectedValueGarabateoT;
  String? _selectedValueTicsmotores;
  String? _selectedValueTicsvocales;
  String? _selectedValueConductasproblematicas;
  String? _selectedValueSonrisasocial;
  String? _selectedValueMovimientosestereotipados;
  String? _selectedValueManipulapermanentementeunobjeto;
  String? _selectedValueBalanceos;
  String? _selectedValueJuegorepetitivo;
  String? _selectedValueTendenciaarutinas;
  String? _selectedValueCaminasinsentido;
  String? _selectedValueProblemasdesueno;
  String? _selectedValueReiteratemasfavoritos;
  String? _selectedValueCaminaenpuntitas;
  String? _selectedValueIrritabilidad;
  String? _selectedValueManipulapermanentementealgo;
  String? _selectedValueIniciaymantieneconversacion;
  String? _selectedValueEcolalia;
  String? _selectedValueConocimientodealguntema;
  String? _selectedValueLenguajeliteral;
  String? _selectedValueMiraalosojos;
  String? _selectedValueOtrossistemasdecomunicacion;
  String? _selectedValueSelectivoenlacomida;
  String? _selectedValueIntensioncomunicativa;
  String? _selectedValueInteresrestringido;
  String? _selectedValueAngustiasincausa;
  String? _selectedValuePreferenciaporalgunalimento;
  String? _selectedValueSonidosextranos;
  String? _selectedValueHablacomoadulto;
  String? _selectedValueFrioparahablar;
  String? _selectedValuePensamientoobsesivo;
  String? _selectedValueCambiodecaracterextremo;
  String? _selectedValueIngenuo;
  String? _selectedValueTorpezamotriz;
  String? _selectedValueFrioemocional;
  String? _selectedValuePocosamigos;
  String? _selectedValueJuegoimaginativo;

  bool deseadoPlanificado = false;
  bool automedicacion = false;
  bool depresion = false;
  bool estres = false;
  bool ansiedad = false;
  bool traumatismos = false;
  bool radiaciones = false;
  bool medicina = false;
  bool riesgosAborto = false;
  bool maltratoFisico = false;
  bool maltratoPsicologico = false;
  bool consumoDrogas = false;
  bool consumoAlcohol = false;
  bool consumoTabaco = false;
  bool hipertension = false;
  bool dietaBalanceada = false;
  bool pretermino = false;
  bool aTermino = false;
  bool postTermino = false;

  // Aquí defines los checkboxes
  Map<String, bool> checkboxValues = {
    'deseadoPlanificado': false,
    'automedicacion': false,
    'depresion': false,
    'estres': false,
    'ansiedad': false,
    'traumatismos': false,
    'radiaciones': false,
    'medicina': false,
    'riesgosAborto': false,
    'maltratoFisico': false,
    'maltratoPsicologico': false,
    'consumoDrogas': false,
    'consumoAlcohol': false,
    'consumoTabaco': false,
    'hipertension': false,
    'dietaBalanceada': false,
    'pretermino': false,
    'aTermino': false,
    'postTermino': false,
    'normal': false,
    'forceps': false,
    'cesarea': false,
    'breve': false,
    'normalP': false,
    'prolongado': false,
    'cefalico': false,
    'podalico': false,
    'transverso': false,
    'cianosis': false,
    'ictericia': false,
    'malformacion': false,
    'circuCordonCuello': false,
    'sufriFetal': false,
    'oxigeno': false,
    'incubadora': false,
    'alMaterna': false,
    'alArtifical': false,
    'alMaticacion': false,
    'controlCefalico': false,
    'gateo': false,
    'marcha': false,
    'sedestacion': false,
    'sincinesias': false,
    'subeBajaGradas': false,
    'rotacionPies': false,
    'berrinches': false,
    'insulta': false,
    'llora': false,
    'grita': false,
    'agrede': false,
    'seEncierra': false,
    'Payuda': false,
    'PePadres': false,
    'Agresivo': false,
    'Pasivo': false,
    'Destructor': false,
    'Sociable': false,
    'Hipercinetico': false,
    'Empatia': false,
    'InterePeculia': false,
    'InteInteraccion': false,
    'mayoresSocial': false,
    'menoresSocial': false,
    'todos': false,
    'familiaSocial': false,
    'reaPerExtra': false,
    'concen5m': false,
    'partesCuerpo': false,
    'asoObjts': false,
    'recoFami': false,
    'recoColBas': false,
    'nuclear': false,
    'monoParen': false,
    'funcional': false,
    'reconsti': false,
    'disfun': false,
    'extensa': false,
    'vista': false,
    'oido': false,
    'tacto': false,
    'gustoOlfa': false,
  };

  // Method to build the family member fields
  Widget _buildFamilyMemberFields(int index) {
    return Row(
      children: <Widget>[
        // Familiar Field
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Familiar'),
            onChanged: (value) {
              familyMembers[index]['familiar'] = value;
            },
          ),
        ),
        SizedBox(width: 10),

        // Edad Field
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Edad'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              familyMembers[index]['edad'] = value;
            },
          ),
        ),
        SizedBox(width: 10),

        // Observaciones Field
        Expanded(
          child: TextFormField(
            decoration: InputDecoration(labelText: 'Observaciones'),
            onChanged: (value) {
              familyMembers[index]['observaciones'] = value;
            },
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    for (var field in _formFields) {
      _controllers[field['name']] = TextEditingController();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      try {
        Map<String, dynamic> formData = {};

        // Agregar los otros campos del formulario
        for (var field in _formFields) {
          formData[field['name']] = _controllers[field['name']]!.text;
        }

        // Formatear fechas
        formData['fechaEntrevista'] = _fechaEntrevista != null
            ? DateFormat('dd/MM/yyyy').format(_fechaEntrevista!)
            : null;
        formData['fechaNacimiento'] = _fechaNacimiento != null
            ? DateFormat('dd/MM/yyyy').format(_fechaNacimiento!)
            : null;
        formData['edad'] = _edad;
        formData['sexo'] = _sexoSeleccionado;
        formData['tipoInstitucion'] = _tipoInstitucion;

        // Agregar los valores de los radio buttons
        formData['lloroAlNacer'] = _selectedValueLloro;
        formData['sufrimientoFetal'] = _selectedValueSufrimiento;
        formData['Palmarplantar'] = _selectedValuePalmarplantar;
        formData['Moro'] = _selectedValueMoro;
        formData['Prensión'] = _selectedValuePrension;
        formData['Debúsqueda'] = _selectedValueDebusqueda;
        formData['Babinski'] = _selectedValueBabinski;

        formData['PinzaDigital'] = _selectedValuePinzadigital;
        formData['Garabato'] = _selectedValueGarabateo;
        formData['SostenerObjeto'] = _selectedValueSostenerobjetos;

        //TEA
        formData['ProblemasenAlimentacion'] =
            _selectedValueProblemasenAlimentacion;
        formData['GarabateoT'] = _selectedValueGarabateoT;
        formData['Ticsmotores'] = _selectedValueTicsmotores;
        formData['Ticsvocales'] = _selectedValueTicsvocales;
        formData['Conductasproblematicas'] =
            _selectedValueConductasproblematicas;
        formData['Sonrisasocial'] = _selectedValueSonrisasocial;
        formData['Movimientosestereotipados'] =
            _selectedValueMovimientosestereotipados;
        formData['Manipulapermanentementeunobjeto'] =
            _selectedValueManipulapermanentementeunobjeto;
        formData['Balanceos'] = _selectedValueBalanceos;
        formData['Juegorepetitivo'] = _selectedValueJuegorepetitivo;
        formData['Tendenciaarutinas'] = _selectedValueTendenciaarutinas;
        formData['Caminasinsentido'] = _selectedValueCaminasinsentido;
        formData['Problemasdesueño'] = _selectedValueProblemasdesueno;
        formData['Reiteratemasfavoritos'] = _selectedValueReiteratemasfavoritos;
        formData['Caminaenpuntitas'] = _selectedValueCaminaenpuntitas;
        formData['Irritabilidad'] = _selectedValueIrritabilidad;
        formData['Manipulapermanentementealgo'] =
            _selectedValueManipulapermanentementealgo;
        formData['Iniciaymantieneconversacion'] =
            _selectedValueIniciaymantieneconversacion;
        formData['Ecolalia'] = _selectedValueEcolalia;
        formData['Conocimientodealguntema'] =
            _selectedValueConocimientodealguntema;
        formData['Lenguajeliteral'] = _selectedValueLenguajeliteral;
        formData['Miraalosojos'] = _selectedValueMiraalosojos;
        formData['Otrossistemasdecomunicacion'] =
            _selectedValueOtrossistemasdecomunicacion;
        formData['Selectivoenlacomida'] = _selectedValueSelectivoenlacomida;
        formData['Intensioncomunicativa'] = _selectedValueIntensioncomunicativa;
        formData['Interesrestringido'] = _selectedValueInteresrestringido;
        formData['Angustiasincausa'] = _selectedValueAngustiasincausa;
        formData['Preferenciaporalgunalimento'] =
            _selectedValuePreferenciaporalgunalimento;
        formData['Sonidosextranos'] = _selectedValueSonidosextranos;
        formData['Hablacomoadulto'] = _selectedValueHablacomoadulto;
        formData['Frioparahablar'] = _selectedValueFrioparahablar;
        formData['Pensamientoobsesivo'] = _selectedValuePensamientoobsesivo;
        formData['Cambiodecaracterextremo'] =
            _selectedValueCambiodecaracterextremo;
        formData['Ingenuo'] = _selectedValueIngenuo;
        formData['Torpezamotriz'] = _selectedValueTorpezamotriz;
        formData['Frioemocional'] = _selectedValueFrioemocional;
        formData['Pocosamigos'] = _selectedValuePocosamigos;
        formData['Juegoimaginativo'] = _selectedValueJuegoimaginativo;

        // Agregar los valores de los checkboxes
        checkboxValues.forEach((key, value) {
          formData[key] = value;
        });

        // Agregar los miembros de la familia a formData como una lista de mapas
        formData['miembrosDeFamilia'] = familyMembers
            .map((miembro) => {
                  'familiar': miembro['familiar'],
                  'edad': miembro['edad'],
                  'observaciones': miembro['observaciones'],
                })
            .toList();

        // Enviar a Firebase
        await FirebaseFirestore.instance
            .collection('HistoriaTeraGeneral')
            .add(formData);

        _clearForm();

        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Datos enviados correctamente')),
        );
      } catch (e) {
        // Mostrar mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar los datos: $e')),
        );
      }
    }
  }

  void _clearForm() {
    for (var controller in _controllers.values) {
      controller.clear();
    }

    // Limpiar las fechas y otras selecciones
    setState(() {
      _fechaEntrevista = null;
      _fechaNacimiento = null;
      _sexoSeleccionado = null;
      _edad = 0;
      _tipoInstitucion = null;
      _selectedValueLloro = null;
      _selectedValueSufrimiento = null;
      _selectedValuePalmarplantar = null;
      _selectedValueMoro = null;
      _selectedValuePrension = null;
      _selectedValueDebusqueda = null;
      _selectedValueBabinski = null;
      _selectedValuePinzadigital = null;
      _selectedValueGarabateo = null;
      _selectedValueSostenerobjetos = null;

      // Limpiar variables TEA
      _selectedValueProblemasenAlimentacion = null;
      _selectedValueGarabateoT = null;
      _selectedValueTicsmotores = null;
      _selectedValueTicsvocales = null;
      _selectedValueConductasproblematicas = null;
      _selectedValueSonrisasocial = null;
      _selectedValueMovimientosestereotipados = null;
      _selectedValueManipulapermanentementeunobjeto = null;
      _selectedValueBalanceos = null;
      _selectedValueJuegorepetitivo = null;
      _selectedValueTendenciaarutinas = null;
    });
  }

  Widget _buildFechaField(String label, DateTime? fechaSeleccionada,
      void Function(DateTime?) onFechaSeleccionada) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () async {
          DateTime? fecha = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (fecha != null) {
            onFechaSeleccionada(fecha);
          }
        },
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Text(
            fechaSeleccionada != null
                ? DateFormat('dd/MM/yyyy').format(fechaSeleccionada)
                : 'Seleccione una fecha',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioButtonGroup(String label, List<String> options,
      String? groupValue, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Wrap(
            spacing: 0.0, // Espacio horizontal entre los botones
            runSpacing:
                4.0, // Espacio vertical si se envuelven en una nueva línea
            children: options.map((option) {
              return Row(
                mainAxisSize:
                    MainAxisSize.min, // Ajusta el tamaño del Row al contenido
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: groupValue,
                    onChanged: onChanged,
                  ),
                  Text(option),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historia Clínica - Terapia',
            style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(224, 68, 137, 255),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            _buildHeader(),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SearchHistoriaPage()), // Navega a la página Histori
                  );
                },
                child: Text('Pagina de busqueda'),
              ),
            ),

            _buildSection('1.- DATOS INFORMATIVOS'),
            _buildFechaField('Fecha de la entrevista', _fechaEntrevista,
                (fecha) => setState(() => _fechaEntrevista = fecha)),
            _buildFormField(_formFields[1]), // Evaluador
            _buildFormField(_formFields[0]), // Nombre completo
            Row(
              children: [
                Expanded(
                  child: _buildFechaField(
                      'Fecha de Nacimiento', _fechaNacimiento, (fecha) {
                    setState(() {
                      _fechaNacimiento = fecha;

                      // Calcular la edad solo si la fecha no es nula
                      if (_fechaNacimiento != null) {
                        _edad = DateTime.now().year - _fechaNacimiento!.year;

                        // Ajustar la edad si la fecha de nacimiento aún no ha ocurrido en este año
                        if (DateTime.now().month < _fechaNacimiento!.month ||
                            (DateTime.now().month == _fechaNacimiento!.month &&
                                DateTime.now().day < _fechaNacimiento!.day)) {
                          _edad--;
                        }
                      } else {
                        _edad = 0; // Restablecer a 0 si la fecha es nula
                      }
                    });
                  }),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    child: Text(
                      _edad.toString(),
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            _buildRadioButtonGroup(
              'Sexo',
              ['Masculino', 'Femenino', 'Otro'],
              _sexoSeleccionado,
              (value) => setState(() => _sexoSeleccionado = value),
            ),
            _buildFormField(_formFields[2]), // Escolaridad
            _buildFormField(_formFields[3]), // Nombre de la Institución
            Divider(),
            _buildRadioButtonGroup(
              'Tipo de Institución',
              ['Particular', 'Fiscal', 'Municipal', 'Fiscomisional'],
              _tipoInstitucion,
              (value) => setState(() => _tipoInstitucion = value),
            ),
            Divider(),
            _buildFormField(_formFields[4]), // Domicilio
            _buildFormField(_formFields[5]), // Email
            _buildFormField(_formFields[6]), // Teléfono
            _buildFormField(_formFields[7]), // entrevistado por
            _buildFormField(_formFields[8]), // remitido por
            Divider(),
            _buildSection('2 .- MOTIVO DE CONSULTA'),
            _buildFormField(_formFields[9]), // motivo de consulta
            Divider(),
            _buildSection('3 .- CARACTERIZACIÓN DEL PROBLEMA'),
            _buildFormField(_formFields[10]), // Campo adicional
            _buildSection('     HISTORIA ESCOLAR'),
            _buildFormField(_formFields[11]), // Campo adicional

            _buildSection('4 .- ANTECEDENTES PERSONALES'),
            _buildSection('     4.1.  ANTECEDENTES PRENATALES'),

            CheckboxListTile(
              title: Text('Deseado / Planificado'),
              value: checkboxValues['deseadoPlanificado'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['deseadoPlanificado'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Automedicación'),
              value: checkboxValues['automedicacion'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['automedicacion'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Depresión'),
              value: checkboxValues['depresion'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['depresion'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Estrés'),
              value: checkboxValues['estres'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['estres'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Ansiedad'),
              value: checkboxValues['ansiedad'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['ansiedad'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Traumatismo'),
              value: checkboxValues['traumatismos'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['traumatismos'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Radiaciones'),
              value: checkboxValues['radiaciones'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['radiaciones'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Medicina'),
              value: checkboxValues['medicina'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['medicina'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Riesgos de aborto'),
              value: checkboxValues['riesgosAborto'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['riesgosAborto'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Maltrato fisico'),
              value: checkboxValues['maltratoFisico'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['maltratoFisico'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Maltrato psicológico'),
              value: checkboxValues['maltratoPsicologico'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['maltratoPsicologico'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Consumo de drogas'),
              value: checkboxValues['consumoDrogas'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['consumoDrogas'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Consumo de alcohol'),
              value: checkboxValues['consumoAlcohol'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['consumoAlcohol'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Consumo de tabaco'),
              value: checkboxValues['consumoTabaco'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['consumoTabaco'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Hipertensión'),
              value: checkboxValues['hipertension'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['hipertension'] = value!;
                });
              },
            ),

            CheckboxListTile(
              title: Text('Dieta balanceada'),
              value: checkboxValues['dietaBalanceada'],
              onChanged: (bool? value) {
                setState(() {
                  checkboxValues['dietaBalanceada'] = value!;
                });
              },
            ),

            _buildSection('     4.2.  ANTECEDENTES PERINATALES'),
            const Text(
              'Duración de la gestación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            //NECESITO AQUI UN CHECK BOZ ALADO DEL OTRO
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['pretermino'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['pretermino'] = value!;
                        });
                      },
                    ),
                    const Text('Pretérmino'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['aTermino'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['aTermino'] = value!;
                        });
                      },
                    ),
                    const Text('A término'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['postTermino'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['postTermino'] = value!;
                        });
                      },
                    ),
                    const Text('Postérmino'),
                  ],
                ),
              ],
            ),

            _buildFormField(_formFields[12]),

            const SizedBox(height: 10),
            const Text(
              'Tipo de parto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['normal'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['normal'] = value!;
                        });
                      },
                    ),
                    const Text('Normal'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['forceps'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['forceps'] = value!;
                        });
                      },
                    ),
                    const Text('Fórceps'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['cesarea'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['cesarea'] = value!;
                        });
                      },
                    ),
                    const Text('Cesárea'),
                  ],
                ),
              ],
            ),

            Divider(),
            const SizedBox(height: 10),
            const Text(
              'Duración del parto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['breve'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['breve'] = value!;
                        });
                      },
                    ),
                    const Text('Breve'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['normalP'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['normalP'] = value!;
                        });
                      },
                    ),
                    const Text('Normal'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['prolongado'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['prolongado'] = value!;
                        });
                      },
                    ),
                    const Text('Prolongado'),
                  ],
                ),
              ],
            ),

            Divider(),
            const SizedBox(height: 10),
            const Text(
              'Presentación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['cefalico'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['cefalico'] = value!;
                        });
                      },
                    ),
                    const Text('Cefálico'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['podalico'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['podalico'] = value!;
                        });
                      },
                    ),
                    const Text('Podálico'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['transverso'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['transverso'] = value!;
                        });
                      },
                    ),
                    const Text('Tranverso'),
                  ],
                ),
              ],
            ),

            Divider(),
            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Lloro al nacer:",
              ["SI", "NO"],
              _selectedValueLloro,
              (value) {
                setState(() {
                  _selectedValueLloro = value;
                });
              },
            ),

            Divider(),

            _buildRadioButtonGroup(
              "Sufrimiento fetal:",
              ["SI", "NO"],
              _selectedValueSufrimiento,
              (value) {
                setState(() {
                  _selectedValueSufrimiento = value;
                });
              },
            ),

            Divider(),
            const Text(
              'Al nacer necesito:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['oxigeno'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['oxigeno'] = value!;
                        });
                      },
                    ),
                    const Text('Oxigeno'),
                  ],
                ),

                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['incubadora'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['incubadora'] = value!;
                        });
                      },
                    ),
                    const Text('Incubadora'),
                  ],
                ),
              ],
            ),

            _buildFormField(_formFields[13]),

            Divider(),
            const SizedBox(height: 10),
            const Text(
              'Al nacer presento:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['cianosis'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['cianosis'] = value!;
                        });
                      },
                    ),
                    const Text('Cianosis'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['ictericia'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['ictericia'] = value!;
                        });
                      },
                    ),
                    const Text('Ictericia'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['malformacion'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['malformacion'] = value!;
                        });
                      },
                    ),
                    const Text('Malformacion'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['circuCordonCuello'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['circuCordonCuello'] = value!;
                        });
                      },
                    ),
                    const Text('Circulación del cordón en el cuello'),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['sufriFetal'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['sufriFetal'] = value!;
                        });
                      },
                    ),
                    const Text('Sufrimiento fetal'),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),

            _buildFormField(_formFields[14]),
            _buildFormField(_formFields[15]),
            _buildFormField(_formFields[16]),
            _buildFormField(_formFields[17]),

            Divider(),
            const Text(
              'Observaciones:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildFormField(_formFields[18]),

            Divider(),
            _buildSection('     4.3.  ANTECEDENTES POSTNATALES'),

            const SizedBox(height: 10),
            const Text(
              'Alimentación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['alMaterna'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['alMaterna'] = value!;
                        });
                      },
                    ),
                    const Text('Materna'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['alArtifical'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['alArtifical'] = value!;
                        });
                      },
                    ),
                    const Text('Artificial'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['alMaticacion'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['alMaticacion'] = value!;
                        });
                      },
                    ),
                    const Text('Maticación'),
                  ],
                ),
              ],
            ),

            Divider(),
            const Text(
              'Desarrollo motor grueso:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['controlCefalico'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['controlCefalico'] = value!;
                        });
                      },
                    ),
                    const Text('Control cefálico'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['gateo'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['gateo'] = value!;
                        });
                      },
                    ),
                    const Text('Gateo'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['marcha'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['marcha'] = value!;
                        });
                      },
                    ),
                    const Text('Marcha'),
                  ],
                ),
              ],
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['sedestacion'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['sedestacion'] = value!;
                        });
                      },
                    ),
                    const Text('Sedestación'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['sincinesias'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['sincinesias'] = value!;
                        });
                      },
                    ),
                    const Text('Sincinesias'),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['subeBajaGradas'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['subeBajaGradas'] = value!;
                        });
                      },
                    ),
                    const Text('Sube y baja gradas'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['rotacionPies'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['rotacionPies'] = value!;
                        });
                      },
                    ),
                    const Text('Rotación de pies'),
                  ],
                ),
                SizedBox(width: 10),
              ],
            ),

            Divider(),
            const Text(
              'Reflejos primitivos:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Deja un espacio vertical de 20 píxeles.

            Container(
              height: 3.0, // Ajusta el grosor vertical del divisor
              width:
                  100.0, // Ajusta el ancho horizontal del divisor, o usa double.infinity para ocupar todo el espacio disponible
              color:
                  const Color.fromARGB(112, 75, 107, 176), // Color del divisor
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Palmar - Plantar:",
              ["SI", "NO"],
              _selectedValuePalmarplantar,
              (value) {
                setState(() {
                  _selectedValuePalmarplantar = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Moro:",
              ["SI", "NO"],
              _selectedValueMoro,
              (value) {
                setState(() {
                  _selectedValueMoro = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Presión:",
              ["SI", "NO"],
              _selectedValuePrension,
              (value) {
                setState(() {
                  _selectedValuePrension = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      De búsqueda:",
              ["SI", "NO"],
              _selectedValueDebusqueda,
              (value) {
                setState(() {
                  _selectedValueDebusqueda = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Banbiski:",
              ["SI", "NO"],
              _selectedValueBabinski,
              (value) {
                setState(() {
                  _selectedValueBabinski = value;
                });
              },
            ),

            Divider(),
            const Text(
              'Desarrollo motor fino:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10), // Deja un espacio vertical de 20 píxeles.

            Container(
              height: 3.0, // Ajusta el grosor vertical del divisor
              width:
                  100.0, // Ajusta el ancho horizontal del divisor, o usa double.infinity para ocupar todo el espacio disponible
              color:
                  const Color.fromARGB(112, 75, 107, 176), // Color del divisor
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Pinza digital:",
              ["SI", "NO"],
              _selectedValuePinzadigital,
              (value) {
                setState(() {
                  _selectedValuePinzadigital = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Garabateo:",
              ["SI", "NO"],
              _selectedValueGarabateo,
              (value) {
                setState(() {
                  _selectedValueGarabateo = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "      Sostener objetos:",
              ["SI", "NO"],
              _selectedValueSostenerobjetos,
              (value) {
                setState(() {
                  _selectedValueSostenerobjetos = value;
                });
              },
            ),

            Container(
              color: Colors.yellow,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: const Text(
                'TEA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Problemas alimenticios:",
              ["SI", "NO"],
              _selectedValueProblemasenAlimentacion,
              (value) {
                setState(() {
                  _selectedValueProblemasenAlimentacion = value;
                });
              },
            ),
            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Garabato:",
              ["SI", "NO"],
              _selectedValueGarabateoT,
              (value) {
                setState(() {
                  _selectedValueGarabateoT = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Tics motores:",
              ["SI", "NO"],
              _selectedValueTicsmotores,
              (value) {
                setState(() {
                  _selectedValueTicsmotores = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Tics vocales:",
              ["SI", "NO"],
              _selectedValueTicsvocales,
              (value) {
                setState(() {
                  _selectedValueTicsvocales = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Conductas problematicas:",
              ["SI", "NO"],
              _selectedValueConductasproblematicas,
              (value) {
                setState(() {
                  _selectedValueConductasproblematicas = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Sonrisa social:",
              ["SI", "NO"],
              _selectedValueSonrisasocial,
              (value) {
                setState(() {
                  _selectedValueSonrisasocial = value;
                });
              },
            ),

            const SizedBox(height: 10),
            _buildRadioButtonGroup(
              "Movimientos estereotipados:",
              ["SI", "NO"],
              _selectedValueMovimientosestereotipados,
              (value) {
                setState(() {
                  _selectedValueMovimientosestereotipados = value;
                });
              },
            ),

            // Variable para "Manipula permanentemente un objeto"
            _buildRadioButtonGroup(
              "Manipula permanentemente un objeto:",
              ["SI", "NO"],
              _selectedValueManipulapermanentementeunobjeto,
              (value) {
                setState(() {
                  _selectedValueManipulapermanentementeunobjeto = value;
                });
              },
            ),

// Variable para "Balanceos"
            _buildRadioButtonGroup(
              "Balanceos:",
              ["SI", "NO"],
              _selectedValueBalanceos,
              (value) {
                setState(() {
                  _selectedValueBalanceos = value;
                });
              },
            ),

// Variable para "Juego repetitivo"
            _buildRadioButtonGroup(
              "Juego repetitivo:",
              ["SI", "NO"],
              _selectedValueJuegorepetitivo,
              (value) {
                setState(() {
                  _selectedValueJuegorepetitivo = value;
                });
              },
            ),

// Variable para "Tendencia a rutinas"
            _buildRadioButtonGroup(
              "Tendencia a rutinas:",
              ["SI", "NO"],
              _selectedValueTendenciaarutinas,
              (value) {
                setState(() {
                  _selectedValueTendenciaarutinas = value;
                });
              },
            ),

// Variable para "Camina sin sentido"
            _buildRadioButtonGroup(
              "Camina sin sentido:",
              ["SI", "NO"],
              _selectedValueCaminasinsentido,
              (value) {
                setState(() {
                  _selectedValueCaminasinsentido = value;
                });
              },
            ),

// Variable para "Problemas de sueño"
            _buildRadioButtonGroup(
              "Problemas de sueño:",
              ["SI", "NO"],
              _selectedValueProblemasdesueno,
              (value) {
                setState(() {
                  _selectedValueProblemasdesueno = value;
                });
              },
            ),

// Variable para "Reitera temas favoritos"
            _buildRadioButtonGroup(
              "Reitera temas favoritos:",
              ["SI", "NO"],
              _selectedValueReiteratemasfavoritos,
              (value) {
                setState(() {
                  _selectedValueReiteratemasfavoritos = value;
                });
              },
            ),

// Variable para "Camina en puntitas"
            _buildRadioButtonGroup(
              "Camina en puntitas:",
              ["SI", "NO"],
              _selectedValueCaminaenpuntitas,
              (value) {
                setState(() {
                  _selectedValueCaminaenpuntitas = value;
                });
              },
            ),

// Variable para "Irritabilidad"
            _buildRadioButtonGroup(
              "Irritabilidad:",
              ["SI", "NO"],
              _selectedValueIrritabilidad,
              (value) {
                setState(() {
                  _selectedValueIrritabilidad = value;
                });
              },
            ),

// Variable para "Manipula permanentemente algo"
            _buildRadioButtonGroup(
              "Manipula permanentemente algo:",
              ["SI", "NO"],
              _selectedValueManipulapermanentementealgo,
              (value) {
                setState(() {
                  _selectedValueManipulapermanentementealgo = value;
                });
              },
            ),

// Variable para "Inicia y mantiene conversación"
            _buildRadioButtonGroup(
              "Inicia y mantiene conversación:",
              ["SI", "NO"],
              _selectedValueIniciaymantieneconversacion,
              (value) {
                setState(() {
                  _selectedValueIniciaymantieneconversacion = value;
                });
              },
            ),

// Variable para "Ecolalia"
            _buildRadioButtonGroup(
              "Ecolalia:",
              ["SI", "NO"],
              _selectedValueEcolalia,
              (value) {
                setState(() {
                  _selectedValueEcolalia = value;
                });
              },
            ),

// Variable para "Conocimiento de algún tema"
            _buildRadioButtonGroup(
              "Conocimiento de algún tema:",
              ["SI", "NO"],
              _selectedValueConocimientodealguntema,
              (value) {
                setState(() {
                  _selectedValueConocimientodealguntema = value;
                });
              },
            ),

// Variable para "Lenguaje literal"
            _buildRadioButtonGroup(
              "Lenguaje literal:",
              ["SI", "NO"],
              _selectedValueLenguajeliteral,
              (value) {
                setState(() {
                  _selectedValueLenguajeliteral = value;
                });
              },
            ),

// Variable para "Mira a los ojos"
            _buildRadioButtonGroup(
              "Mira a los ojos:",
              ["SI", "NO"],
              _selectedValueMiraalosojos,
              (value) {
                setState(() {
                  _selectedValueMiraalosojos = value;
                });
              },
            ),

// Variable para "Otros sistemas de comunicación"
            _buildRadioButtonGroup(
              "Otros sistemas de comunicación:",
              ["SI", "NO"],
              _selectedValueOtrossistemasdecomunicacion,
              (value) {
                setState(() {
                  _selectedValueOtrossistemasdecomunicacion = value;
                });
              },
            ),

// Variable para "Selectivo en la comida"
            _buildRadioButtonGroup(
              "Selectivo en la comida:",
              ["SI", "NO"],
              _selectedValueSelectivoenlacomida,
              (value) {
                setState(() {
                  _selectedValueSelectivoenlacomida = value;
                });
              },
            ),

// Variable para "Intención comunicativa"
            _buildRadioButtonGroup(
              "Intención comunicativa:",
              ["SI", "NO"],
              _selectedValueIntensioncomunicativa,
              (value) {
                setState(() {
                  _selectedValueIntensioncomunicativa = value;
                });
              },
            ),

// Variable para "Interés restringido"
            _buildRadioButtonGroup(
              "Interés restringido:",
              ["SI", "NO"],
              _selectedValueInteresrestringido,
              (value) {
                setState(() {
                  _selectedValueInteresrestringido = value;
                });
              },
            ),

// Variable para "Angustia sin causa"
            _buildRadioButtonGroup(
              "Angustia sin causa:",
              ["SI", "NO"],
              _selectedValueAngustiasincausa,
              (value) {
                setState(() {
                  _selectedValueAngustiasincausa = value;
                });
              },
            ),

// Variable para "Preferencia por algún alimento"
            _buildRadioButtonGroup(
              "Preferencia por algún alimento:",
              ["SI", "NO"],
              _selectedValuePreferenciaporalgunalimento,
              (value) {
                setState(() {
                  _selectedValuePreferenciaporalgunalimento = value;
                });
              },
            ),

// Variable para "Sonidos extraños"
            _buildRadioButtonGroup(
              "Sonidos extraños:",
              ["SI", "NO"],
              _selectedValueSonidosextranos,
              (value) {
                setState(() {
                  _selectedValueSonidosextranos = value;
                });
              },
            ),

// Variable para "Habla como adulto"
            _buildRadioButtonGroup(
              "Habla como adulto:",
              ["SI", "NO"],
              _selectedValueHablacomoadulto,
              (value) {
                setState(() {
                  _selectedValueHablacomoadulto = value;
                });
              },
            ),

// Variable para "Frío para hablar"
            _buildRadioButtonGroup(
              "Frío para hablar:",
              ["SI", "NO"],
              _selectedValueFrioparahablar,
              (value) {
                setState(() {
                  _selectedValueFrioparahablar = value;
                });
              },
            ),

// Variable para "Pensamiento obsesivo"
            _buildRadioButtonGroup(
              "Pensamiento obsesivo:",
              ["SI", "NO"],
              _selectedValuePensamientoobsesivo,
              (value) {
                setState(() {
                  _selectedValuePensamientoobsesivo = value;
                });
              },
            ),

// Variable para "Cambio de carácter extremo"
            _buildRadioButtonGroup(
              "Cambio de carácter extremo:",
              ["SI", "NO"],
              _selectedValueCambiodecaracterextremo,
              (value) {
                setState(() {
                  _selectedValueCambiodecaracterextremo = value;
                });
              },
            ),

// Variable para "Ingenuo"
            _buildRadioButtonGroup(
              "Ingenuo:",
              ["SI", "NO"],
              _selectedValueIngenuo,
              (value) {
                setState(() {
                  _selectedValueIngenuo = value;
                });
              },
            ),

// Variable para "Torpeza motriz"
            _buildRadioButtonGroup(
              "Torpeza motriz:",
              ["SI", "NO"],
              _selectedValueTorpezamotriz,
              (value) {
                setState(() {
                  _selectedValueTorpezamotriz = value;
                });
              },
            ),

// Variable para "Frío emocional"
            _buildRadioButtonGroup(
              "Frío emocional:",
              ["SI", "NO"],
              _selectedValueFrioemocional,
              (value) {
                setState(() {
                  _selectedValueFrioemocional = value;
                });
              },
            ),

// Variable para "Pocos amigos"
            _buildRadioButtonGroup(
              "Pocos amigos:",
              ["SI", "NO"],
              _selectedValuePocosamigos,
              (value) {
                setState(() {
                  _selectedValuePocosamigos = value;
                });
              },
            ),

            _buildRadioButtonGroup(
              "Juego imaginativo:",
              ["SI", "NO"],
              _selectedValueJuegoimaginativo,
              (value) {
                setState(() {
                  _selectedValueJuegoimaginativo = value;
                });
              },
            ),

            Divider(),
            const Text(
              'ESPECIFICACIONES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            _buildFormField(_formFields[19]),
            _buildFormField(_formFields[20]),
            _buildFormField(_formFields[21]),
            _buildFormField(_formFields[22]),
            _buildFormField(_formFields[23]),
            _buildFormField(_formFields[24]),
            _buildFormField(_formFields[25]),
            _buildFormField(_formFields[26]),
            _buildFormField(_formFields[27]),
            _buildFormField(_formFields[28]),
            _buildFormField(_formFields[29]),

            Divider(),
            _buildSection('5 .- HÁBITOS PERSONALES'),
            _buildSection('     Reacción ante las dificultades:'),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['berrinches'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['berrinches'] = value!;
                        });
                      },
                    ),
                    const Text('Berrinches'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['insulta'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['insulta'] = value!;
                        });
                      },
                    ),
                    const Text('Insulta'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['llora'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['llora'] = value!;
                        });
                      },
                    ),
                    const Text('Llora'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['grita'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['grita'] = value!;
                        });
                      },
                    ),
                    const Text('Grita'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['agrede'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['agrede'] = value!;
                        });
                      },
                    ),
                    const Text('Agrede'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['seEncierra'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['seEncierra'] = value!;
                        });
                      },
                    ),
                    const Text('Se encierra'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Payuda'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Payuda'] = value!;
                        });
                      },
                    ),
                    const Text('Pide ayuda'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['PePadres'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['PePadres'] = value!;
                        });
                      },
                    ),
                    const Text('Pega a los padres'),
                  ],
                ),
              ],
            ),

            Divider(),
            _buildSection('     Aptitudes e intereses escolares:'),
            _buildFormField(_formFields[30]),

            Divider(),
            _buildSection('     Rendimiento general en escolaridad:'),
            _buildFormField(_formFields[31]),

            Divider(),
            _buildSection('     Comportamiento General:'),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Agresivo'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Agresivo'] = value!;
                        });
                      },
                    ),
                    const Text('Agresivo'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Pasivo'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Pasivo'] = value!;
                        });
                      },
                    ),
                    const Text('Pasivo'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Destructor'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Destructor'] = value!;
                        });
                      },
                    ),
                    const Text('Destructor'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Sociable'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Sociable'] = value!;
                        });
                      },
                    ),
                    const Text('Sociable'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Hipercinetico'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Hipercinetico'] = value!;
                        });
                      },
                    ),
                    const Text('Hipercinetico'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['Empatia'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['Empatia'] = value!;
                        });
                      },
                    ),
                    const Text('Empatia'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['InterePeculia'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['InterePeculia'] = value!;
                        });
                      },
                    ),
                    const Text('Intereses peculiares'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['InteInteraccion'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['InteInteraccion'] = value!;
                        });
                      },
                    ),
                    const Text('Interes por interaccion'),
                  ],
                ),
              ],
            ),

            Divider(),
            _buildSection('ASPECTOS DE SOCIALIZACIÓN'),
            _buildSection('    Socialización:'),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['mayoresSocial'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['mayoresSocial'] = value!;
                        });
                      },
                    ),
                    const Text('Mayores'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['menoresSocial'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['menoresSocial'] = value!;
                        });
                      },
                    ),
                    const Text('Menores'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['todos'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['todos'] = value!;
                        });
                      },
                    ),
                    const Text('Todos'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['familiaSocial'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['familiaSocial'] = value!;
                        });
                      },
                    ),
                    const Text('Socializacion con familia'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['reaPerExtra'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['reaPerExtra'] = value!;
                        });
                      },
                    ),
                    const Text('Reaccion con personas extrañas'),
                  ],
                ),
              ],
            ),

            Divider(),
            _buildSection('    Aspectos cognitivos:'),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['concen5m'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['concen5m'] = value!;
                        });
                      },
                    ),
                    const Text('Logra concentrarse 5 min'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['partesCuerpo'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['partesCuerpo'] = value!;
                        });
                      },
                    ),
                    const Text('Reconoce partes del cuerpo'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['asoObjts'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['asoObjts'] = value!;
                        });
                      },
                    ),
                    const Text('Asocia objetos'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['recoFami'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['recoFami'] = value!;
                        });
                      },
                    ),
                    const Text('Reconoce a sus familiares'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['recoColBas'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['recoColBas'] = value!;
                        });
                      },
                    ),
                    const Text('Reconoce colores basicos'),
                  ],
                ),
              ],
            ),

            Divider(),
            _buildSection('DATOS FAMILIARES'),
            _buildSection('   Tipo de hogar:'),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['nuclear'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['nuclear'] = value!;
                        });
                      },
                    ),
                    const Text('Nuclear'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['monoParen'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['monoParen'] = value!;
                        });
                      },
                    ),
                    const Text('Monoparental'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['funcional'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['funcional'] = value!;
                        });
                      },
                    ),
                    const Text('Funcional'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['reconsti'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['reconsti'] = value!;
                        });
                      },
                    ),
                    const Text('Reconstituida'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['disfun'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['disfun'] = value!;
                        });
                      },
                    ),
                    const Text('Disfuncional'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['extensa'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['extensa'] = value!;
                        });
                      },
                    ),
                    const Text('Extensa'),
                  ],
                ),
              ],
            ),

            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                '¿Quién vive en la casa?',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),

            _buildFormField(_formFields[32]),

            SizedBox(height: 15),

            Divider(),

            _buildSection('   INTEGRACIÓN SENSORIAL'),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['vista'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['vista'] = value!;
                        });
                      },
                    ),
                    const Text('Vista'),
                  ],
                ),
                SizedBox(width: 10), // Espacio entre los checkboxes
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['oido'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['oido'] = value!;
                        });
                      },
                    ),
                    const Text('Oido'),
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['tacto'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['tacto'] = value!;
                        });
                      },
                    ),
                    const Text('Tacto'),
                  ],
                ),
              ],
            ),

            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Alinear los elementos al inicio
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: checkboxValues['gustoOlfa'],
                      onChanged: (bool? value) {
                        setState(() {
                          checkboxValues['gustoOlfa'] = value!;
                        });
                      },
                    ),
                    const Text('Gusto y Olfato'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton:
          _buildSubmitButton(), // Botón flotante en la parte inferior derecha
      floatingActionButtonLocation: FloatingActionButtonLocation
          .endFloat, // Posición en la esquina inferior derecha
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/imagenes/san-miguel.png', // Imagen del ángel
                width: 60,
                height: 100,
              ),
              SizedBox(width: 10), // Espacio entre la imagen y el texto
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Cambiado a 'center' para centrar el texto
                  children: [
                    Text(
                      'Fundación de niños especiales',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign
                          .center, // Asegura que cada texto también esté centrado
                    ),
                    Text(
                      '"SAN MIGUEL" FUNESAMI',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center, // Centra el texto
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Historia clínica General - Terapia',
                      style: TextStyle(
                        fontSize: 18,
                        color: const Color.fromARGB(255, 252, 4, 4),
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center, // Centra el texto
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 9.0),
      child: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFormField(Map<String, dynamic> field) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: _controllers[field['name']],
        decoration: InputDecoration(
          labelText: field['label'],
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        keyboardType: field['name'] == 'telefono'
            ? TextInputType.phone // Aquí configuramos el teclado numérico
            : TextInputType.text, // Para otros campos el teclado es de texto
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Por favor complete este campo';
          }
          return null;
        },
        minLines: field['multiline'] == true
            ? 3
            : null, // Campo mínimo de 1 línea si es multilinea
        maxLines: field['multiline'] == true
            ? 3
            : 1, // Campo máximo de 3 líneas si es multilinea
      ),
    );
  }

  Widget _buildSubmitButton() {
    return FloatingActionButton(
      onPressed: _submitForm,
      child: Icon(Icons.save), // Usa un icono de guardado como en la imagen
      backgroundColor: Color.fromARGB(224, 68, 137, 255),
    );
  }
}

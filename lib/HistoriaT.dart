import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Necesario para formatear la fecha

class HistoriaT extends StatefulWidget {
  const HistoriaT({super.key});

  @override
  _HistoriaState createState() => _HistoriaState();
}

class _HistoriaState extends State<HistoriaT> {
  DateTime? _selectedDate;
  String? _selectedSex;
  DateTime? _evaluationDate;
  int _age = 0;
  String? _selectedOption; // Variable para almacenar la opción seleccionada
  double _textSize = 14.5; // Tamaño del texto

  // Variables para controlar el estado de los checkboxes
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
  bool DpBreve = false;
  bool DpNormal = false;
  bool DpProlongado = false;
  bool PrCefalico = false;
  bool PrPodalico = false;
  bool PrTrasnverso = false;
  bool LLSi = false;
  bool LLNO = false;
  bool SfSi = false;
  bool SfNo = false;
  bool Oxigeno = false;
  bool Incubadora = false;
  bool ApCia = false;
  bool ApIct = false;
  bool ApMal = false;
  bool CordonCuello = false;
  bool SufriFetal = false;
  bool AlMater = false;
  bool AlArtf = false;
  bool AlMati = false;
  bool controlCefalico = false;
  bool gateo = false;
  bool marcha = false;
  bool sedestacion = false;
  bool sincinesias = false;
  bool subeBajaGradas = false;
  bool rotacionPies = false;

  // Variables para los checkboxes y radio buttons
  bool pretermino = false;
  bool aTermino = false;
  bool postTermino = false;
  bool oxigeno = false;
  bool incubadora = false;
  bool ictericia = false;
  bool sufrimientoFetal = false;
  bool cordonEnCuello = false;
  bool Tpnormal = false;
  bool TpForceps = false;
  bool TpCesarea = false;
  bool berrinches = false;
  bool insulta = false;
  bool llora = false;
  bool grita = false;
  bool agrede = false;
  bool seEncierra = false;
  bool Payuda = false;
  bool PePadres = false;
  bool Agresivo = false;
  bool Hipercinetico = false;
  bool Pasivo = false;
  bool InterePeculia = false;
  bool Destructor = false;
  bool Empatia = false;
  bool Social = false;
  bool InteInteraccion = false;
  bool mayoresSocial = false;
  bool menoresSocial = false;
  bool todos = false;
  bool familiaSocial = false;
  bool reaPerExtra = false;
  bool concen5m = false;
  bool partesCuerpo = false;
  bool asoObjts = false;
  bool recoFami = false;
  bool recoColBas = false;
  bool nuclear = false;
  bool monoParen = false;
  bool funcional = false;
  bool reconsti = false;
  bool disfun = false;
  bool extensa = false;
  bool vista = false;
  bool oido = false;
  bool tacto = false;
  bool gustoOlfa = false;

  // Mapeo para guardar el valor de selección de cada fila
  Map<String, String?> seleccionReflejos = {
    'Palmar - plantar': null,
    'Moro': null,
    'Prensión': null,
    'De búsqueda': null,
    'Babinski': null,
  };

  Map<String, String?> seleccionMotorFino = {
    'Pinza digital': null,
    'Garabateo': null,
    'Sostener objetos': null,
  };

  Map<String, String?> seleccionTea = {
    'Problemas en alimentación': null,
    'Tics motores': null,
    'Tics vocales': null,
    'Conductas problemáticas': null,
    'Sonrisa social': null,
    'Movimientos estereotipados': null,
    'Manipula permanentemente un objeto': null,
    'Balanceos': null,
    'Juego repetitivo': null,
    'Tendencia a rutinas': null,
    'Camina sin sentido': null,
    'Problemas de sueño': null,
    'Reitera temas favoritos': null,
    'Camina en puntitas': null,
    'Irritabilidad': null,
    'Manipula permanentemente algo': null,
    'Inicia y mantiene conversación': null,
    'Ecolalia': null,
    'Conocimiento de algún tema': null,
    'Lenguaje literal': null,
    'Mira a los ojos': null,
    'Otros sistemas de comunicación': null,
    'Selectivo en la comida': null,
    'Intensión comunicativa': null,
    'Interés restringido': null,
    'Angustia sin causa': null,
    'Preferencia por algún alimento': null,
    'Sonidos extraños': null,
    'Habla como adulto': null,
    'Frío para hablar': null,
    'Pensamiento obsesivo': null,
    'Cambio de carácter extremo': null,
    'Ingenuo': null,
    'Torpeza motriz': null,
    'Frío emocional': null,
    'Pocos amigos': null,
    'Juego imaginativo': null,
  };

  List<Map<String, dynamic>> familiaData = [];
  @override
  void initState() {
    super.initState();
    // Inicialmente agregamos un conjunto de campos
    addNewField();
  }

  void addNewField() {
    setState(() {
      familiaData.add({
        'familiar': '',
        'edad': '',
        'observaciones': '',
      });
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Historia Clínica - Terapia',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(224, 68, 137, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

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

            const SizedBox(height: 20),

            const Text(
              '1.- DATOS INFORMATIVOS:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: const InputDecoration(
                        labelText: 'Fecha de la entrevista',
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
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Evaluador',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre completo',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Escolaridad',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Seleccione sexo',
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedSex,
                    items: ['sexo1', 'sexo2', 'sexo3']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedSex = newValue!;
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre de la Institucion',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Fila con RadioButtons en la misma fila
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Particular',
                        style: TextStyle(fontSize: _textSize),
                        textAlign: TextAlign.center,
                      ),
                      Radio<String>(
                        value: 'Particular',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Fiscal',
                        style: TextStyle(fontSize: _textSize),
                        textAlign: TextAlign.center,
                      ),
                      Radio<String>(
                        value: 'Fiscal',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Municipal',
                        style: TextStyle(fontSize: _textSize),
                        textAlign: TextAlign.center,
                      ),
                      Radio<String>(
                        value: 'Municipal',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Fiscomisional',
                        style: TextStyle(fontSize: _textSize),
                        textAlign: TextAlign.center,
                      ),
                      Radio<String>(
                        value: 'Fiscomisional',
                        groupValue: _selectedOption,
                        onChanged: (String? value) {
                          setState(() {
                            _selectedOption = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Domicilio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Telefono',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre los dos campos
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Entrevista con',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Espacio entre los dos campos
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Remitido por',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              '2.- MOTIVO DE CONSULTA:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Describa le motivo de consulta',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              '3.- CARACTERIZACION DEL PROBLEMA:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextFormField(
              maxLines:
                  6, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText:
                    '¿Desde cuando inicia y cuales son los síntomas? Frecuencia y manejo',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),
            const Text(
              'HISTORIA ESCOLAR:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Escribir institucion exito y fracaso',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),

            const Text(
              '4.- ANTECEDENTES PERSONALES:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '       4.1. ANTECEDENTES PRENATALES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Checkboxes como en la imagen
            CheckboxListTile(
              title: const Text('Deseado / Planificado'),
              value: deseadoPlanificado,
              onChanged: (bool? value) {
                setState(() {
                  deseadoPlanificado = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Automedicación'),
              value: automedicacion,
              onChanged: (bool? value) {
                setState(() {
                  automedicacion = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Depresión'),
              value: depresion,
              onChanged: (bool? value) {
                setState(() {
                  depresion = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Estrés'),
              value: estres,
              onChanged: (bool? value) {
                setState(() {
                  estres = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Ansiedad'),
              value: ansiedad,
              onChanged: (bool? value) {
                setState(() {
                  ansiedad = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Traumatismos'),
              value: traumatismos,
              onChanged: (bool? value) {
                setState(() {
                  traumatismos = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Radiaciones'),
              value: radiaciones,
              onChanged: (bool? value) {
                setState(() {
                  radiaciones = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Medicina'),
              value: medicina,
              onChanged: (bool? value) {
                setState(() {
                  medicina = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Riesgos de aborto'),
              value: riesgosAborto,
              onChanged: (bool? value) {
                setState(() {
                  riesgosAborto = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Maltrato físico'),
              value: maltratoFisico,
              onChanged: (bool? value) {
                setState(() {
                  maltratoFisico = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Maltrato psicológico'),
              value: maltratoPsicologico,
              onChanged: (bool? value) {
                setState(() {
                  maltratoPsicologico = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Consumo de drogas'),
              value: consumoDrogas,
              onChanged: (bool? value) {
                setState(() {
                  consumoDrogas = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Consumo de alcohol'),
              value: consumoAlcohol,
              onChanged: (bool? value) {
                setState(() {
                  consumoAlcohol = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Consumo de tabaco'),
              value: consumoTabaco,
              onChanged: (bool? value) {
                setState(() {
                  consumoTabaco = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Hipertensión'),
              value: hipertension,
              onChanged: (bool? value) {
                setState(() {
                  hipertension = value!;
                });
              },
            ),
            CheckboxListTile(
              title: const Text('Dieta balanceada'),
              value: dietaBalanceada,
              onChanged: (bool? value) {
                setState(() {
                  dietaBalanceada = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            const Text(
              '       4.2. ANTECEDENTES PERINATALES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

            const Text(
              'Duración de la gestación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: pretermino,
                  onChanged: (bool? value) {
                    setState(() {
                      pretermino = value!;
                    });
                  },
                ),
                const Text('Pretérmino'),
                Checkbox(
                  value: aTermino,
                  onChanged: (bool? value) {
                    setState(() {
                      aTermino = value!;
                    });
                  },
                ),
                const Text('A término'),
                Checkbox(
                  value: postTermino,
                  onChanged: (bool? value) {
                    setState(() {
                      postTermino = value!;
                    });
                  },
                ),
                const Text('Postérmino'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Lugar de atención',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Divider(),

            const Text(
              'Tipo de parto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: Tpnormal,
                  onChanged: (bool? value) {
                    setState(() {
                      Tpnormal = value!;
                    });
                  },
                ),
                const Text('Normal'),
                Checkbox(
                  value: TpForceps,
                  onChanged: (bool? value) {
                    setState(() {
                      TpForceps = value!;
                    });
                  },
                ),
                const Text('Fórceps'),
                Checkbox(
                  value: TpCesarea,
                  onChanged: (bool? value) {
                    setState(() {
                      TpCesarea = value!;
                    });
                  },
                ),
                const Text('Cesárea'),
              ],
            ),
            const SizedBox(height: 10),
            Divider(),

            const Text(
              'Duración del parto:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: DpBreve,
                  onChanged: (bool? value) {
                    setState(() {
                      DpBreve = value!;
                    });
                  },
                ),
                const Text('Breve'),
                Checkbox(
                  value: DpNormal,
                  onChanged: (bool? value) {
                    setState(() {
                      DpNormal = value!;
                    });
                  },
                ),
                const Text('Normal'),
                Checkbox(
                  value: DpProlongado,
                  onChanged: (bool? value) {
                    setState(() {
                      DpProlongado = value!;
                    });
                  },
                ),
                const Text('Prolongado'),
              ],
            ),

            const SizedBox(height: 10),
            Divider(),
            const Text(
              'Presentación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Checkbox(
                  value: PrCefalico,
                  onChanged: (bool? value) {
                    setState(() {
                      PrCefalico = value!;
                    });
                  },
                ),
                const Text('Cefálico'),
                Checkbox(
                  value: PrPodalico,
                  onChanged: (bool? value) {
                    setState(() {
                      PrPodalico = value!;
                    });
                  },
                ),
                const Text('Podálico'),
                Checkbox(
                  value: PrTrasnverso,
                  onChanged: (bool? value) {
                    setState(() {
                      PrTrasnverso = value!;
                    });
                  },
                ),
                const Text('Tranverso'),
              ],
            ),

            const SizedBox(height: 10),
            Divider(),
            const Text(
              'Lloro al nacer:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Checkbox(
                  value: LLSi,
                  onChanged: (bool? value) {
                    setState(() {
                      LLSi = value!;
                    });
                  },
                ),
                const Text('SI'),
                Checkbox(
                  value: LLNO,
                  onChanged: (bool? value) {
                    setState(() {
                      LLNO = value!;
                    });
                  },
                ),
                const Text('NO'),
              ],
            ),

            const SizedBox(height: 10),
            Divider(),
            const Text(
              'Sufrimiento fetal:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            Row(
              children: [
                Checkbox(
                  value: SfSi,
                  onChanged: (bool? value) {
                    setState(() {
                      SfSi = value!;
                    });
                  },
                ),
                const Text('SI'),
                Checkbox(
                  value: SfNo,
                  onChanged: (bool? value) {
                    setState(() {
                      SfNo = value!;
                    });
                  },
                ),
                const Text('NO'),
              ],
            ),

            const SizedBox(height: 10),
            Divider(),
            const Text(
              'Al nacer necesito:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: Oxigeno,
                  onChanged: (bool? value) {
                    setState(() {
                      Oxigeno = value!;
                    });
                  },
                ),
                const Text('SI'),
                Checkbox(
                  value: Incubadora,
                  onChanged: (bool? value) {
                    setState(() {
                      Incubadora = value!;
                    });
                  },
                ),
                const Text('NO'),
                SizedBox(width: 10), // Espaciado entre "NO" y la caja de texto
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Tiempo ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Divider(),
            const Text(
              'Al nacer presento:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: ApCia,
                  onChanged: (bool? value) {
                    setState(() {
                      ApCia = value!;
                    });
                  },
                ),
                const Text('Cianosis'),
                Checkbox(
                  value: ApIct,
                  onChanged: (bool? value) {
                    setState(() {
                      ApIct = value!;
                    });
                  },
                ),
                const Text('Ictericia'),
                Checkbox(
                  value: ApMal,
                  onChanged: (bool? value) {
                    setState(() {
                      ApMal = value!;
                    });
                  },
                ),
                const Text('malformacion'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: CordonCuello,
                  onChanged: (bool? value) {
                    setState(() {
                      CordonCuello = value!;
                    });
                  },
                ),
                const Text('Circulación del cordón en el cuello'),
              ],
            ),
            Row(
              children: [
                Checkbox(
                  value: SufriFetal,
                  onChanged: (bool? value) {
                    setState(() {
                      SufriFetal = value!;
                    });
                  },
                ),
                const Text('sufrimiento fetalo'),
              ],
            ),

            const SizedBox(height: 15),
            Divider(),
            Row(
              children: [
                const Text('Peso: '),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'gr',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Talla: '),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'cm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text('Perímetro cefálico: '),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'cm',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                const Text('Apgar: '),
                Flexible(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: '',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),
            Divider(),
            const Text(
              'Observaciones:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextFormField(
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 10),
            const Text(
              '       4.3. ANTECEDENTES POSTNATALES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),

// Alimentación
            const Text(
              'Alimentación:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: AlMater,
                  onChanged: (bool? value) {
                    setState(() {
                      AlMater = value!;
                    });
                  },
                ),
                const Text('Materna'),
                Checkbox(
                  value: AlArtf,
                  onChanged: (bool? value) {
                    setState(() {
                      AlArtf = value!;
                    });
                  },
                ),
                const Text('Artificial'),
                Checkbox(
                  value: AlMati,
                  onChanged: (bool? value) {
                    setState(() {
                      AlMati = value!;
                    });
                  },
                ),
                const Text('Maticacion'),
              ],
            ),
            const SizedBox(height: 20),

// Desarrollo Motor Grueso
            const Text('Desarrollo Motor Grueso:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Table(
              border: TableBorder.all(),
              columnWidths: {
                0: FlexColumnWidth(
                    2), // Controla el ancho de la columna de texto
                1: FlexColumnWidth(
                    1), // Controla el ancho de la columna de checkbox
              },
              children: [
                TableRow(
                  children: [
                    Text('Control cefálico'),
                    Checkbox(
                      value: controlCefalico,
                      onChanged: (bool? value) {
                        setState(() {
                          controlCefalico = value!;
                        });
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Gateo'),
                    Checkbox(
                      value: gateo,
                      onChanged: (bool? value) {
                        setState(() {
                          gateo = value!;
                        });
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Marcha'),
                    Checkbox(
                      value: marcha,
                      onChanged: (bool? value) {
                        setState(() {
                          marcha = value!;
                        });
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Sedestación'),
                    Checkbox(
                      value: sedestacion,
                      onChanged: (bool? value) {
                        setState(() {
                          sedestacion = value!;
                        });
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Sincinesias'),
                    Checkbox(
                      value: sincinesias,
                      onChanged: (bool? value) {
                        setState(() {
                          sincinesias = value!;
                        });
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Sube y baja gradas'),
                    Checkbox(
                      value: subeBajaGradas,
                      onChanged: (bool? value) {
                        setState(() {
                          subeBajaGradas = value!;
                        });
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Rotación de pies'),
                    Checkbox(
                      value: rotacionPies,
                      onChanged: (bool? value) {
                        setState(() {
                          rotacionPies = value!;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

// Reflejos Primitivos
            const Text('Reflejos Primitivos:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                _buildTableHeader(),
                _buildTableRow('Palmar - plantar', seleccionReflejos),
                _buildTableRow('Moro', seleccionReflejos),
                _buildTableRow('Prensión', seleccionReflejos),
                _buildTableRow('De búsqueda', seleccionReflejos),
                _buildTableRow('Babinski', seleccionReflejos),
              ],
            ),
            const SizedBox(height: 20),

            // Desarrollo Motor Fino
            const Text('Desarrollo Motor Fino:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                _buildTableHeader(),
                _buildTableRow('Pinza digital', seleccionMotorFino),
                _buildTableRow('Garabateo', seleccionMotorFino),
                _buildTableRow('Sostener objetos', seleccionMotorFino),
              ],
            ),

            const SizedBox(height: 20),
            Container(
              color:
                  Colors.yellow, // Fondo amarillo que cubre todo el contenedor
              width: double
                  .infinity, // Hace que el contenedor ocupe todo el ancho disponible
              child: const Text(
                'TEA',
                textAlign:
                    TextAlign.center, // Centra el texto dentro del contenedor
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Texto en color negro
                ),
              ),
            ),

            const SizedBox(height: 15),
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(1),
                2: FlexColumnWidth(1),
              },
              children: [
                _buildTableHeader(),
                _buildTableRow('Problemas en alimentación', seleccionTea),
                _buildTableRow('Garabateo', seleccionTea),
                _buildTableRow('Tics motores', seleccionTea),
                _buildTableRow('Tics vocales', seleccionTea),
                _buildTableRow('Conductas problemáticas', seleccionTea),
                _buildTableRow('Sonrisa social', seleccionTea),
                _buildTableRow('Movimientos estereotipados', seleccionTea),
                _buildTableRow(
                    'Manipula permanentemente un objeto', seleccionTea),
                _buildTableRow('Balanceos', seleccionTea),
                _buildTableRow('Juego repetitivo', seleccionTea),
                _buildTableRow('Tendencia a rutinas', seleccionTea),
                _buildTableRow('Camina sin sentido', seleccionTea),
                _buildTableRow('Problemas de sueño', seleccionTea),
                _buildTableRow('Reitera temas favoritos', seleccionTea),
                _buildTableRow('Camina en puntitas', seleccionTea),
                _buildTableRow('Irritabilidad', seleccionTea),
                _buildTableRow('Manipula permanentemente algo', seleccionTea),
                _buildTableRow('Inicia y mantiene conversación', seleccionTea),
                _buildTableRow('Ecolalia', seleccionTea),
                _buildTableRow('Conocimiento de algún tema', seleccionTea),
                _buildTableRow('Lenguaje literal', seleccionTea),
                _buildTableRow('Mira a los ojos', seleccionTea),
                _buildTableRow('Otros sistemas de comunicación', seleccionTea),
                _buildTableRow('Selectivo en la comida', seleccionTea),
                _buildTableRow('Intensión comunicativa', seleccionTea),
                _buildTableRow('Interés restringido', seleccionTea),
                _buildTableRow('Angustia sin causa', seleccionTea),
                _buildTableRow('Preferencia por algún alimento', seleccionTea),
                _buildTableRow('Sonidos extraños', seleccionTea),
                _buildTableRow('Habla como adulto', seleccionTea),
                _buildTableRow('Frío para hablar', seleccionTea),
                _buildTableRow('Pensamiento obsesivo', seleccionTea),
                _buildTableRow('Cambio de carácter extremo', seleccionTea),
                _buildTableRow('Ingenuo', seleccionTea),
                _buildTableRow('Torpeza motriz', seleccionTea),
                _buildTableRow('Frío emocional', seleccionTea),
                _buildTableRow('Pocos amigos', seleccionTea),
                _buildTableRow('Juego imaginativo', seleccionTea),
              ],
            ),

            const SizedBox(height: 20),
            const Text(
              'ESPECIFICACIONES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Intensión comunicativa Hospitalizaciones',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Traumatismos',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Infecciones, alergias, otitis, farin...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Reacciones peculiares vacunas',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Desnutrición/obesidad',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Cirugías',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Convulsiones febriles o epilepsia....',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Medicación',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Sindromes',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Observaciones',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'EE, TAC, RM',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),
            const Text(
              '5.- HÁBITOS PERSONALES:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            const Text(
              '    Reacción ante las dificultades:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: berrinches,
                  onChanged: (bool? value) {
                    setState(() {
                      berrinches = value!;
                    });
                  },
                ),
                const Text('Berrinches'),
                Checkbox(
                  value: insulta,
                  onChanged: (bool? value) {
                    setState(() {
                      insulta = value!;
                    });
                  },
                ),
                const Text('Insulta'),
                Checkbox(
                  value: llora,
                  onChanged: (bool? value) {
                    setState(() {
                      llora = value!;
                    });
                  },
                ),
                const Text('LLora'),
                Checkbox(
                  value: grita,
                  onChanged: (bool? value) {
                    setState(() {
                      grita = value!;
                    });
                  },
                ),
                const Text('Grita'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: agrede,
                  onChanged: (bool? value) {
                    setState(() {
                      agrede = value!;
                    });
                  },
                ),
                const Text('Agrede'),
                Checkbox(
                  value: seEncierra,
                  onChanged: (bool? value) {
                    setState(() {
                      seEncierra = value!;
                    });
                  },
                ),
                const Text('Se encierra'),
                Checkbox(
                  value: Payuda,
                  onChanged: (bool? value) {
                    setState(() {
                      Payuda = value!;
                    });
                  },
                ),
                const Text('Pide ayuda'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: PePadres,
                  onChanged: (bool? value) {
                    setState(() {
                      PePadres = value!;
                    });
                  },
                ),
                const Text('Pega a los padres'),
              ],
            ),
            const SizedBox(height: 10),

            const Text(
              '    Aptitudes e intereses escolares:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Describa las aptitudes e intereses escolares',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              '    Rendimiento general en escolaridad:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            TextFormField(
              maxLines:
                  3, // Esto hace que el cuadro de texto sea más grande, permitiendo 3 líneas
              decoration: const InputDecoration(
                labelText: 'Describa......',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            Divider(),
            const Text(
              'COMPORTAMIENTO GENERAL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: Agresivo,
                  onChanged: (bool? value) {
                    setState(() {
                      Agresivo = value!;
                    });
                  },
                ),
                const Text('Agresivo'),
                Checkbox(
                  value: Pasivo,
                  onChanged: (bool? value) {
                    setState(() {
                      Pasivo = value!;
                    });
                  },
                ),
                const Text('Pasivo'),
                Checkbox(
                  value: Destructor,
                  onChanged: (bool? value) {
                    setState(() {
                      Destructor = value!;
                    });
                  },
                ),
                const Text('Destructor'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: Social,
                  onChanged: (bool? value) {
                    setState(() {
                      Social = value!;
                    });
                  },
                ),
                const Text('Sociable'),
                Checkbox(
                  value: Hipercinetico,
                  onChanged: (bool? value) {
                    setState(() {
                      Hipercinetico = value!;
                    });
                  },
                ),
                const Text('Hipercinético'),
                Checkbox(
                  value: Empatia,
                  onChanged: (bool? value) {
                    setState(() {
                      Empatia = value!;
                    });
                  },
                ),
                const Text('empatia'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: InterePeculia,
                  onChanged: (bool? value) {
                    setState(() {
                      InterePeculia = value!;
                    });
                  },
                ),
                const Text('Intereses peculiares'),
                Checkbox(
                  value: InteInteraccion,
                  onChanged: (bool? value) {
                    setState(() {
                      InteInteraccion = value!;
                    });
                  },
                ),
                const Text('Interes por interacción'),
              ],
            ),

            const SizedBox(height: 10),

            Divider(),
            const Text(
              'Aspectos de socialización',
            ),
            const SizedBox(height: 10),
            const Text(
              '      Socialización:',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: mayoresSocial,
                  onChanged: (bool? value) {
                    setState(() {
                      mayoresSocial = value!;
                    });
                  },
                ),
                const Text('Mayores'),
                Checkbox(
                  value: menoresSocial,
                  onChanged: (bool? value) {
                    setState(() {
                      menoresSocial = value!;
                    });
                  },
                ),
                const Text('Menores'),
                Checkbox(
                  value: todos,
                  onChanged: (bool? value) {
                    setState(() {
                      todos = value!;
                    });
                  },
                ),
                const Text('Todos'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: familiaSocial,
                  onChanged: (bool? value) {
                    setState(() {
                      familiaSocial = value!;
                    });
                  },
                ),
                const Text('Socializacion con familia'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: reaPerExtra,
                  onChanged: (bool? value) {
                    setState(() {
                      reaPerExtra = value!;
                    });
                  },
                ),
                const Text('Reaccion con personas extrañas'),
              ],
            ),

            const SizedBox(height: 10),

            Divider(),
            const Text(
              'Aspectos Cognitivos',
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: concen5m,
                  onChanged: (bool? value) {
                    setState(() {
                      concen5m = value!;
                    });
                  },
                ),
                const Text('Logra concentarse 5 min'),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: partesCuerpo,
                  onChanged: (bool? value) {
                    setState(() {
                      partesCuerpo = value!;
                    });
                  },
                ),
                const Text('Reconoce partes del cuerpo'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: asoObjts,
                  onChanged: (bool? value) {
                    setState(() {
                      asoObjts = value!;
                    });
                  },
                ),
                const Text('Asocia Objetos'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: recoFami,
                  onChanged: (bool? value) {
                    setState(() {
                      recoFami = value!;
                    });
                  },
                ),
                const Text('Reconoce a sus familiares'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: recoColBas,
                  onChanged: (bool? value) {
                    setState(() {
                      recoColBas = value!;
                    });
                  },
                ),
                const Text('Reconoce colores basicos'),
              ],
            ),

            const SizedBox(height: 10),

            Divider(),
            const Text(
              'DATOS FAMILIARES',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              '     Tipo de hogar:',
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: nuclear,
                  onChanged: (bool? value) {
                    setState(() {
                      nuclear = value!;
                    });
                  },
                ),
                const Text('Nuclear'),
                Checkbox(
                  value: monoParen,
                  onChanged: (bool? value) {
                    setState(() {
                      monoParen = value!;
                    });
                  },
                ),
                const Text('Monoparental'),
                Checkbox(
                  value: funcional,
                  onChanged: (bool? value) {
                    setState(() {
                      funcional = value!;
                    });
                  },
                ),
                const Text('Funcional'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: reconsti,
                  onChanged: (bool? value) {
                    setState(() {
                      reconsti = value!;
                    });
                  },
                ),
                const Text('Reconstituida'),
                Checkbox(
                  value: disfun,
                  onChanged: (bool? value) {
                    setState(() {
                      disfun = value!;
                    });
                  },
                ),
                const Text('Disfuncional'),
                Checkbox(
                  value: extensa,
                  onChanged: (bool? value) {
                    setState(() {
                      extensa = value!;
                    });
                  },
                ),
                const Text('Extensa'),
              ],
            ),

            const SizedBox(height: 10),
            Divider(),
            const Text(
              '     ¿Quien vive en la casa?',
            ),
            const SizedBox(height: 10),
            // Botón para agregar nuevos campos
            ElevatedButton(
              onPressed: addNewField,
              child: Icon(Icons.add),
            ),
            const SizedBox(height: 10),

            SizedBox(
              height: 300, // Define una altura fija para el ListView
              child: ListView.builder(
                itemCount: familiaData.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        // Campo para el nombre del familiar
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Familiar'),
                            onChanged: (value) {
                              setState(() {
                                familiaData[index]['familiar'] = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Campo para la edad
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Edad'),
                            onChanged: (value) {
                              setState(() {
                                familiaData[index]['edad'] = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),

                        // Campo para observaciones
                        Expanded(
                          child: TextFormField(
                            decoration:
                                InputDecoration(labelText: 'Observaciones'),
                            onChanged: (value) {
                              setState(() {
                                familiaData[index]['observaciones'] = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Divider(),
            const Text(
              'INTEGRACIÓN SENSORIAL',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: vista,
                  onChanged: (bool? value) {
                    setState(() {
                      vista = value!;
                    });
                  },
                ),
                const Text('Vista'),
                Checkbox(
                  value: oido,
                  onChanged: (bool? value) {
                    setState(() {
                      oido = value!;
                    });
                  },
                ),
                const Text('Oido'),
                Checkbox(
                  value: tacto,
                  onChanged: (bool? value) {
                    setState(() {
                      tacto = value!;
                    });
                  },
                ),
                const Text('Tacto'),
              ],
            ),

            Row(
              children: [
                Checkbox(
                  value: gustoOlfa,
                  onChanged: (bool? value) {
                    setState(() {
                      gustoOlfa = value!;
                    });
                  },
                ),
                const Text('Gusto y olfato'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Encabezado de la tabla
  TableRow _buildTableHeader() {
    return TableRow(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(''),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('SI', textAlign: TextAlign.center),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('NO', textAlign: TextAlign.center),
      ),
    ]);
  }

  // Encabezado de la tabla
  TableRow _Espacio() {
    return TableRow(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(''),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('', textAlign: TextAlign.center),
      ),
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('', textAlign: TextAlign.center),
      ),
    ]);
  }

  // Crear filas de la tabla con opciones "Sí" o "No"
  TableRow _buildTableRow(String habilidad, Map<String, String?> seleccionMap) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(habilidad),
      ),
      Radio<String>(
        value: 'SI',
        groupValue: seleccionMap[habilidad],
        onChanged: (String? value) {
          setState(() {
            seleccionMap[habilidad] = value;
          });
        },
      ),
      Radio<String>(
        value: 'NO',
        groupValue: seleccionMap[habilidad],
        onChanged: (String? value) {
          setState(() {
            seleccionMap[habilidad] = value;
          });
        },
      ),
    ]);
  }
}
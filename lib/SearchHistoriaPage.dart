import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchHistoriaPage extends StatefulWidget {
  @override
  _SearchHistoriaPageState createState() => _SearchHistoriaPageState();
}

class _SearchHistoriaPageState extends State<SearchHistoriaPage> {
  late ScrollController _scrollController;
  String searchQuery = "";

  @override
  void initState() {    
    super.initState();
    _scrollController = ScrollController(); // Inicializa el controlador aquí  
     
 
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Libera los recursos del controlador
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();
  List<DocumentSnapshot> _results = [];
  bool _isLoading = false;
  bool _isEditing = false; // Indica si el modo de edición está activado
  Map<String, dynamic>? _selectedHistoria;
  String? _sexoSeleccionado;
  String? _tipoInstitucion;
  String? _selectedValueLloro; // Para almacenar el valor de "Lloro al nacer"
  String? _selectedValueSufrimiento;
  String? _selectedValuePalmarplantar;
  String? _selectedValueMoro;
  String? _selectedValuePresion;
  String? _selectedValueDebusqueda;
  String? _selectedValueBabinski;
  String? _selectedValuePinzadigital;
  String? _selectedValueGarabateo;
  String? _selectedValueSostenerobjetos;

  //VARIABLES TEA
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

  // chechkboxes
  Map<String, bool> _antecedentesPrenatales = {
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
  };

  Map<String, String> _antecedentesPrenatalesLabels = {
    'deseadoPlanificado': 'Deseado/Planificado',
    'automedicacion': 'Automedicación',
    'depresion': 'Depresión',
    'estres': 'Estres',
    'ansiedad': 'Ansiedad',
    'traumatismos': 'Traumatismo',
    'radiaciones': 'Radiaciones',
    'medicina': 'Medicina',
    'riesgosAborto': 'Riesgo de aborto',
    'maltratoFisico': 'Maltrato fisico',
    'maltratoPsicologico': 'Maltrato psicologico',
    'consumoDrogas': 'Consumo de drogas',
    'consumoAlcohol': 'Consumo de alcohol',
    'consumoTabaco': 'Consumo de tabaco',
    'hipertension': 'Hipertensión',
    'dietaBalanceada': 'Dieta balanceada',
  };

  Map<String, bool> _duracionGestacion = {
    'pretermino': false,
    'aTermino': false,
    'postTermino': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _duracionGestacionLabels = {
    'pretermino': 'Pretérmino',
    'aTermino': 'A término',
    'postTermino': 'Depresión',
  };

  Map<String, bool> _tipoParto = {
    'normal': false,
    'forceps': false,
    'cesarea': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _tipoPartoLabels = {
    'normal': 'Normal',
    'forceps': 'Fórceps',
    'cesarea': 'Cesárea',
  };

  Map<String, bool> _duracionParto = {
    'breve': false,
    'normalP': false,
    'prolongado': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _duracionPartoLabels = {
    'breve': 'Breve',
    'normalP': 'Normal',
    'prolongado': 'Prolongado',
  };

  Map<String, bool> _presentacion = {
    'cefalico': false,
    'podalico': false,
    'transverso': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _presentacionLabels = {
    'cefalico': 'Cefálico',
    'podalico': 'Podálico',
    'transverso': 'Transverso',
  };

  Map<String, bool> _alNacernecesito = {
    'oxigeno': false,
    'incubadora': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _alNacernecesitoLabels = {
    'oxigeno': 'Oxigeno',
    'incubadora': 'Incubadora',
  };

  Map<String, bool> _alNacerPresento = {
    'cianosis': false,
    'ictericia': false,
    'malformacion': false,
    'circuCordonCuello': false,
    'sufriFetal': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _alNacerPresentoLabels = {
    'cianosis': 'Cianosis',
    'ictericia': 'Ictericia',
    'malformacion': 'Malformación',
    'circuCordonCuello': 'Circulación del cordón en el cuello',
    'sufriFetal': 'Sufrimiento fetal',
  };

  Map<String, bool> _alimentacion = {
    'alMaterna': false,
    'alArtifical': false,
    'alMaticacion': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _alimentacionLabels = {
    'alMaterna': 'Materna',
    'alArtifical': 'Artificial',
    'alMaticacion': 'Maticación',
  };

  Map<String, bool> _desarrolloMgrueso = {
    'controlCefalico': false,
    'gateo': false,
    'marcha': false,
    'sedestacion': false,
    'sincinesias': false,
    'subeBajaGradas': false,
    'rotacionPies': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _desarrolloMgruesoLabels = {
    'controlCefalico': 'Control cefálico',
    'gateo': 'Gateo',
    'marcha': 'Marcha',
    'sedestacion': 'Sedestación',
    'sincinesias': 'Sincinesias',
    'subeBajaGradas': 'Sube y baja gradas',
    'rotacionPies': 'Rotación de pies',
  };


  Map<String, bool> _ReaccionAnteDificul = {
'berrinches' : false,
'insulta' : false,
'llora' : false,
'grita' : false,
'agrede' : false,
'seEncierra' : false,
'Payuda' : false,
'PePadres' : false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _ReaccionAnteDificulLabels = {
'berrinches': 'Berrinches',
'insulta': 'Insulta',
'llora': 'Llora',
'grita': 'Grita',
'agrede': 'Agrede',
'seEncierra': 'Se encierra',
'Payuda': 'Pide ayuda',
'PePadres': 'Pega a los padres',
  };



   Map<String, bool> _comportaGeneral = {
  'Agresivo': false,
  'Pasivo': false,
  'Destructor': false,
  'Sociable': false,
  'Hipercinetico': false,
  'Empatia': false,
  'InterePeculia': false,
  'InteInteraccion': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _comportaGeneralLabels = {
  'Agresivo': 'Agresivo',
  'Pasivo': 'Pasivo',
  'Destructor': 'Destructor',
  'Sociable': 'Sociable',
  'Hipercinetico': 'Hipercinetico',
  'Empatia': 'Empatia',
  'InterePeculia': 'Intereses peculiares',
  'InteInteraccion': 'Interes por interacción',
  };


Map<String, bool> _Socializacion = {
  'mayoresSocial': false,
    'menoresSocial': false,    
    'familiaSocial': false,
    'reaPerExtra': false,
    'todos': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _SocializacionLabels = {
'mayoresSocial': 'Mayores',
    'menoresSocial': 'Menores',    
    'familiaSocial': 'Socialización con familia',
    'reaPerExtra': 'Reacción con personas extrañas',
    'todos': 'Todos',
  };



  Map<String, bool> _AspcCogni = {
  'concen5m': false,
    'partesCuerpo': false,
    'asoObjts': false,
    'recoFami': false,
    'recoColBas': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _AspcCogniLabels = {
'concen5m': 'Logra concentrarse 5 min',
    'partesCuerpo': 'Reconoce partes del cuerpo',
    'asoObjts': 'Asocia objetos',
    'recoFami': 'Reconoce a sus familiares',
    'recoColBas': 'Reconoce colores basicos',
  };


    Map<String, bool> _tipoHogar = {
  'nuclear': false,
    'monoParen': false,
    'funcional': false,
    'reconsti': false,
    'disfun': false,
    'extensa': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _tipoHogarLabels = {
 'nuclear': 'Nuclear',
    'monoParen': 'Monoparental',
    'funcional': 'Funcional',
    'reconsti': 'Reconstituida',
    'disfun': 'Disfuncional',
    'extensa': 'Extensa',
  };


  Map<String, bool> _integraSensorial = {
'vista': false, 
    'oido': false, 
    'tacto': false, 
    'gustoOlfa': false,
  };
  // Mapa de etiquetas amigables para las casillas de verificación
  Map<String, String> _integraSensorialLabels = {
 'vista': 'Vista',
    'oido': 'Oido',
    'tacto': 'Tacto',
    'gustoOlfa': 'Gusto y Olfato',
  };




  Future<void> _searchHistorias() async {
    setState(() {
      _isLoading = true;
      _isEditing = false;
    });

    try {
      // Realiza la búsqueda en Firestore por nombre
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('HistoriaTeraGeneral')
          .where('nombre', isEqualTo: _searchController.text)
          .get();

      setState(() {
        _results = querySnapshot.docs;
        _isLoading = false;

        if (_results.isNotEmpty) {
          _selectedHistoria = _results[0].data() as Map<String, dynamic>;

          // Asegurarse de que el campo 'sexo' existe en la historia seleccionada
          _sexoSeleccionado = _selectedHistoria?['sexo'] ?? '';

          // Asegurarse de que el campo 'tipoInstitucion' existe en la historia seleccionada
          _tipoInstitucion = _selectedHistoria?['tipoInstitucion'] ?? '';
          _selectedValueLloro = _selectedHistoria?['lloroAlNacer'] ?? '';
          _selectedValueSufrimiento =
              _selectedHistoria?['sufrimientoFetal'] ?? '';

          _selectedValuePalmarplantar =
              _selectedHistoria?['Palmarplantar'] ?? '';
          _selectedValueMoro = _selectedHistoria?['Moro'] ?? '';
          _selectedValuePresion = _selectedHistoria?['Prensión'] ?? '';
          _selectedValueDebusqueda = _selectedHistoria?['Debúsqueda'] ?? '';
          _selectedValueBabinski = _selectedHistoria?['Babinski'] ?? '';

          _selectedValuePinzadigital = _selectedHistoria?['PinzaDigital'] ?? '';
          _selectedValueGarabateo = _selectedHistoria?['Garabato'] ?? '';
          _selectedValueSostenerobjetos =
              _selectedHistoria?['SostenerObjeto'] ?? '';

          //TEA
          _selectedValueProblemasenAlimentacion =
              _selectedHistoria?['ProblemasenAlimentacion'] ?? '';
          _selectedValueGarabateoT = _selectedHistoria?['GarabateoT'] ?? '';
          _selectedValueTicsmotores = _selectedHistoria?['Ticsmotores'] ?? '';
          _selectedValueTicsvocales = _selectedHistoria?['Ticsvocales'] ?? '';
          _selectedValueConductasproblematicas =
              _selectedHistoria?['Conductasproblematicas'] ?? '';
          _selectedValueSonrisasocial =
              _selectedHistoria?['Sonrisasocial'] ?? '';
          _selectedValueMovimientosestereotipados =
              _selectedHistoria?['Movimientosestereotipados'] ?? '';
          _selectedValueManipulapermanentementeunobjeto =
              _selectedHistoria?['Manipulapermanentementeunobjeto'] ?? '';
          _selectedValueBalanceos = _selectedHistoria?['Balanceos'] ?? '';
          _selectedValueJuegorepetitivo =
              _selectedHistoria?['Juegorepetitivo'] ?? '';
          _selectedValueTendenciaarutinas =
              _selectedHistoria?['Tendenciaarutinas'] ?? '';
          _selectedValueCaminasinsentido =
              _selectedHistoria?['Caminasinsentido'] ?? '';
          _selectedValueProblemasdesueno =
              _selectedHistoria?['Problemasdesueño'] ?? '';
          _selectedValueReiteratemasfavoritos =
              _selectedHistoria?['Reiteratemasfavoritos'] ?? '';
          _selectedValueCaminaenpuntitas =
              _selectedHistoria?['Caminaenpuntitas'] ?? '';
          _selectedValueIrritabilidad =
              _selectedHistoria?['Irritabilidad'] ?? '';
          _selectedValueManipulapermanentementealgo =
              _selectedHistoria?['Manipulapermanentementealgo'] ?? '';
          _selectedValueIniciaymantieneconversacion =
              _selectedHistoria?['Iniciaymantieneconversacion'] ?? '';
          _selectedValueEcolalia = _selectedHistoria?['Ecolalia'] ?? '';
          _selectedValueConocimientodealguntema =
              _selectedHistoria?['Conocimientodealguntema'] ?? '';
          _selectedValueLenguajeliteral =
              _selectedHistoria?['Lenguajeliteral'] ?? '';
          _selectedValueMiraalosojos = _selectedHistoria?['Miraalosojos'] ?? '';
          _selectedValueOtrossistemasdecomunicacion =
              _selectedHistoria?['Otrossistemasdecomunicacion'] ?? '';
          _selectedValueSelectivoenlacomida =
              _selectedHistoria?['Selectivoenlacomida'] ?? '';
          _selectedValueIntensioncomunicativa =
              _selectedHistoria?['Intensioncomunicativa'] ?? '';
          _selectedValueInteresrestringido =
              _selectedHistoria?['Interesrestringido'] ?? '';
          _selectedValueAngustiasincausa =
              _selectedHistoria?['Angustiasincausa'] ?? '';
          _selectedValuePreferenciaporalgunalimento =
              _selectedHistoria?['Preferenciaporalgunalimento'] ?? '';
          _selectedValueSonidosextranos =
              _selectedHistoria?['Sonidosextranos'] ?? '';
          _selectedValueHablacomoadulto =
              _selectedHistoria?['Hablacomoadulto'] ?? '';
          _selectedValueFrioparahablar =
              _selectedHistoria?['Frioparahablar'] ?? '';
          _selectedValuePensamientoobsesivo =
              _selectedHistoria?['Pensamientoobsesivo'] ?? '';
          _selectedValueCambiodecaracterextremo =
              _selectedHistoria?['Cambiodecaracterextremo'] ?? '';
          _selectedValueIngenuo = _selectedHistoria?['Ingenuo'] ?? '';
          _selectedValueTorpezamotriz =
              _selectedHistoria?['Torpezamotriz'] ?? '';
          _selectedValueFrioemocional =
              _selectedHistoria?['Frioemocional'] ?? '';
          _selectedValuePocosamigos = _selectedHistoria?['Pocosamigos'] ?? '';
          _selectedValueJuegoimaginativo =
              _selectedHistoria?['Juegoimaginativo'] ?? '';

          _selectedHistoria = _results[0].data() as Map<String, dynamic>;

          // Asignar valores de antecedentes prenatales (checkboxes)
          _antecedentesPrenatales['deseadoPlanificado'] =
              _selectedHistoria?['deseadoPlanificado'] ?? false;
          _antecedentesPrenatales['automedicacion'] =
              _selectedHistoria?['automedicacion'] ?? false;
          _antecedentesPrenatales['depresion'] =
              _selectedHistoria?['depresion'] ?? false;
          _antecedentesPrenatales['estres'] =
              _selectedHistoria?['estres'] ?? false;
          _antecedentesPrenatales['ansiedad'] =
              _selectedHistoria?['ansiedad'] ?? false;
          _antecedentesPrenatales['traumatismos'] =
              _selectedHistoria?['traumatismos'] ?? false;
          _antecedentesPrenatales['radiaciones'] =
              _selectedHistoria?['radiaciones'] ?? false;
          _antecedentesPrenatales['medicina'] =
              _selectedHistoria?['medicina'] ?? false;
          _antecedentesPrenatales['riesgosAborto'] =
              _selectedHistoria?['riesgosAborto'] ?? false;
          _antecedentesPrenatales['maltratoFisico'] =
              _selectedHistoria?['maltratoFisico'] ?? false;
          _antecedentesPrenatales['maltratoPsicologico'] =
              _selectedHistoria?['maltratoPsicologico'] ?? false;
          _antecedentesPrenatales['consumoDrogas'] =
              _selectedHistoria?['consumoDrogas'] ?? false;
          _antecedentesPrenatales['consumoAlcohol'] =
              _selectedHistoria?['consumoAlcohol'] ?? false;
          _antecedentesPrenatales['consumoTabaco'] =
              _selectedHistoria?['consumoTabaco'] ?? false;
          _antecedentesPrenatales['hipertension'] =
              _selectedHistoria?['hipertension'] ?? false;
          _antecedentesPrenatales['dietaBalanceada'] =
              _selectedHistoria?['dietaBalanceada'] ?? false;

          _duracionGestacion['pretermino'] =
              _selectedHistoria?['pretermino'] ?? false;
          _duracionGestacion['aTermino'] =
              _selectedHistoria?['aTermino'] ?? false;
          _duracionGestacion['postTermino'] =
              _selectedHistoria?['postTermino'] ?? false;

          _tipoParto['normal'] = _selectedHistoria?['normal'] ?? false;
          _tipoParto['forceps'] = _selectedHistoria?['forceps'] ?? false;
          _tipoParto['cesarea'] = _selectedHistoria?['cesarea'] ?? false;

          _duracionParto['breve'] = _selectedHistoria?['breve'] ?? false;
          _duracionParto['normalP'] = _selectedHistoria?['normalP'] ?? false;
          _duracionParto['prolongado'] =
              _selectedHistoria?['prolongado'] ?? false;

          _presentacion['cefalico'] = _selectedHistoria?['cefalico'] ?? false;
          _presentacion['podalico'] = _selectedHistoria?['podalico'] ?? false;
          _presentacion['transverso'] =
              _selectedHistoria?['transverso'] ?? false;

          _alNacernecesito['oxigeno'] = _selectedHistoria?['oxigeno'] ?? false;
          _alNacernecesito['incubadora'] =
              _selectedHistoria?['incubadora'] ?? false;

          _alNacerPresento['cianosis'] =
              _selectedHistoria?['cianosis'] ?? false;
          _alNacerPresento['ictericia'] =
              _selectedHistoria?['ictericia'] ?? false;
          _alNacerPresento['malformacion'] =
              _selectedHistoria?['malformacion'] ?? false;
          _alNacerPresento['circuCordonCuello'] =
              _selectedHistoria?['circuCordonCuello'] ?? false;
          _alNacerPresento['sufriFetal'] =
              _selectedHistoria?['sufriFetal'] ?? false;

          _alimentacion['alMaterna'] = _selectedHistoria?['alMaterna'] ?? false;
          _alimentacion['alArtifical'] =
              _selectedHistoria?['alArtifical'] ?? false;
          _alimentacion['alMaticacion'] =
              _selectedHistoria?['alMaticacion'] ?? false;

          _desarrolloMgrueso['controlCefalico'] =
              _selectedHistoria?['controlCefalico'] ?? false;
          _desarrolloMgrueso['gateo'] = _selectedHistoria?['gateo'] ?? false;
          _desarrolloMgrueso['marcha'] = _selectedHistoria?['marcha'] ?? false;
          _desarrolloMgrueso['sedestacion'] =
              _selectedHistoria?['sedestacion'] ?? false;
          _desarrolloMgrueso['sincinesias'] =
              _selectedHistoria?['sincinesias'] ?? false;
          _desarrolloMgrueso['subeBajaGradas'] =
              _selectedHistoria?['subeBajaGradas'] ?? false;
          _desarrolloMgrueso['rotacionPies'] = _selectedHistoria?['rotacionPies'] ?? false;




          _ReaccionAnteDificul['berrinches'] = _selectedHistoria?['berrinches'] ?? false;
          _ReaccionAnteDificul['insulta'] = _selectedHistoria?['insulta'] ?? false;
          _ReaccionAnteDificul['llora'] = _selectedHistoria?['llora'] ?? false;
          _ReaccionAnteDificul['grita'] = _selectedHistoria?['grita'] ?? false;
          _ReaccionAnteDificul['agrede'] = _selectedHistoria?['agrede'] ?? false;
          _ReaccionAnteDificul['seEncierra'] = _selectedHistoria?['seEncierra'] ?? false;
          _ReaccionAnteDificul['Payuda'] = _selectedHistoria?['Payuda'] ?? false;
          _ReaccionAnteDificul['PePadres'] = _selectedHistoria?['PePadres'] ?? false;


          _comportaGeneral['Agresivo'] = _selectedHistoria?['Agresivo'] ?? false;
          _comportaGeneral['Pasivo'] = _selectedHistoria?['Pasivo'] ?? false;
          _comportaGeneral['Destructor'] = _selectedHistoria?['Destructor'] ?? false;
          _comportaGeneral['Hipercinetico'] = _selectedHistoria?['Hipercinetico'] ?? false;
          _comportaGeneral['Empatia'] = _selectedHistoria?['Empatia'] ?? false;
          _comportaGeneral['InterePeculia'] = _selectedHistoria?['InterePeculia'] ?? false;
          _comportaGeneral['InteInteraccion'] = _selectedHistoria?['InteInteraccion'] ?? false;


          _Socializacion['mayoresSocial'] = _selectedHistoria?['mayoresSocial'] ?? false;
          _Socializacion['menoresSocial'] = _selectedHistoria?['menoresSocial'] ?? false;
          _Socializacion['todos'] = _selectedHistoria?['todos'] ?? false;
          _Socializacion['familiaSocial'] = _selectedHistoria?['familiaSocial'] ?? false;
          _Socializacion['reaPerExtra'] = _selectedHistoria?['reaPerExtra'] ?? false;


          _AspcCogni['concen5m'] = _selectedHistoria?['concen5m'] ?? false;
          _AspcCogni['partesCuerpo'] = _selectedHistoria?['partesCuerpo'] ?? false;
          _AspcCogni['asoObjts'] = _selectedHistoria?['asoObjts'] ?? false;
          _AspcCogni['recoFami'] = _selectedHistoria?['recoFami'] ?? false;
          _AspcCogni['recoColBas'] = _selectedHistoria?['recoColBas'] ?? false;


          _tipoHogar['nuclear'] = _selectedHistoria?['nuclear'] ?? false;
         _tipoHogar['monoParen'] = _selectedHistoria?['monoParen'] ?? false;
         _tipoHogar['funcional'] = _selectedHistoria?['funcional'] ?? false;
         _tipoHogar['reconsti'] = _selectedHistoria?['reconsti'] ?? false;
         _tipoHogar['disfun'] = _selectedHistoria?['disfun'] ?? false;
         _tipoHogar['extensa'] = _selectedHistoria?['extensa'] ?? false; 


         _integraSensorial['vista'] = _selectedHistoria?['vista'] ?? false;  
         _integraSensorial['oido'] = _selectedHistoria?['oido'] ?? false;  
         _integraSensorial['tacto'] = _selectedHistoria?['tacto'] ?? false;  
         _integraSensorial['gustoOlfa'] = _selectedHistoria?['gustoOlfa'] ?? false; 

        }
      });
    } catch (e) {
      print("Error al buscar historias clínicas: $e");
      setState(() {
        _isLoading = false;
      });
    }
  }



  Future<void> _saveChanges() async {
    try {
      if (_selectedHistoria != null) {
        // Actualizar el documento en Firestore
        await FirebaseFirestore.instance
            .collection('HistoriaTeraGeneral')
            .doc(_results[0].id)
            .update(_selectedHistoria!);

        // Mostrar mensaje de éxito
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Cambios guardados exitosamente'),
        ));

        // Desactivar el modo de edición
        setState(() {
          _isEditing = false;
        });
      }
    } catch (e) {
      print("Error al guardar los cambios: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al guardar los cambios: $e'),
      ));
    }
  }

  Widget _buildCheckboxGroup(
      Map<String, bool> options, Map<String, String> labels,
      {String? label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null && label.isNotEmpty)
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Column(
            children: options.keys.map((option) {
              bool isEnabled = _isEditing; // Verificar si está habilitado
              return CheckboxListTile(
                title: Text(
                  labels[option] ?? option,
                  style: TextStyle(
                    color: isEnabled
                        ? Colors.black
                        : Colors.black54, // Controlar el color del texto
                  ),
                ),
                value: options[option],
                activeColor: isEnabled
                    ? Colors.blue
                    : Colors.grey, // Color cuando está activo o deshabilitado
                checkColor: Colors.white, // Color de la marca de verificación
                onChanged: isEnabled
                    ? (bool? value) {
                        setState(() {
                          options[option] = value ?? false;
                          _selectedHistoria![option] = options[option];
                        });
                      }
                    : null,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildCheckboxGroupLaders(
      Map<String, bool> options, Map<String, String> labels,
      {String? label}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null && label.isNotEmpty)
            Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          Row(
            // Cambiado a Row para alinear horizontalmente
            mainAxisAlignment: MainAxisAlignment.start, // Alineación al inicio
            children: options.keys.map((option) {
              return Row(
                // Envolver cada checkbox en su propio Row
                children: [
                  Checkbox(
                    value: options[option],
                    onChanged: _isEditing
                        ? (bool? value) {
                            setState(() {
                              options[option] = value ?? false;
                              _selectedHistoria![option] = options[option];
                            });
                          }
                        : null,
                  ),
                  Text(labels[option] ??
                      option), // Etiqueta al lado del checkbox
                  SizedBox(width: 10), // Añadir espacio entre opciones
                ],
              );
            }).toList(),
          ),
        ],
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
            spacing: 0.0,
            runSpacing: 4.0,
            children: options.map((option) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: groupValue, // El valor actualmente seleccionado
                    onChanged: _isEditing
                        ? onChanged
                        : null, // Solo permite cambiar si está en modo edición
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
        title: Text('Buscar Historias Clínicas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Nombre del Paciente',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchHistorias,
                  
                ),
              ),
            ),
            SizedBox(height: 20),            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _isEditing
                      ? _saveChanges
                      : () {
                          setState(() {
                            _isEditing = true; // Activar modo edición
                          });
                        },
                  child: Text(_isEditing ? 'Guardar' : 'Editar'),
                ),
              ],
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : _selectedHistoria != null
                    ? Expanded(
                        child: ListView(
                          controller:
                              _scrollController, // Asignar el controlador
                          children: [
                            _buildSection('1.- DATOS INFORMATIVOS'),
                            _buildTextField(
                                'Fecha de entrevista', 'fechaEntrevista'),
                            _buildTextField('Evaluador', 'evaluador'),
                            _buildTextField(
                                'Nombre completo del paciente', 'nombre'),
                            Row(
                              children: [
                                Expanded(
                                  child: _buildTextField(
                                      'Fecha de Nacimiento', 'fechaNacimiento'),
                                ),
                                SizedBox(width: 16.0),
                                Expanded(
                                  child: _buildTextField('Edad', 'edad',
                                      isNumeric: true),
                                ),
                              ],
                            ),
                            _buildRadioButtonGroup(
                              'Sexo',
                              ['Masculino', 'Femenino', 'Otro'],
                              _sexoSeleccionado,
                              (String? value) {
                                setState(() {
                                  _sexoSeleccionado = value;
                                  _selectedHistoria!['sexo'] = value;
                                });
                              },
                            ),
                            _buildTextField('Escolaridad', 'escolaridad'),
                            _buildTextField('Institución', 'institucion'),
                            Divider(),
                            SizedBox(height: 10),
                            _buildRadioButtonGroup(
                              'Tipo de Institución',
                              [
                                'Particular',
                                'Fiscal',
                                'Municipal',
                                'Fiscomisional'
                              ],
                              _tipoInstitucion,
                              (String? value) {
                                setState(() {
                                  _tipoInstitucion = value;
                                  _selectedHistoria!['tipoInstitucion'] = value;
                                });
                              },
                            ),
                            Divider(),
                            SizedBox(height: 10),
                            _buildTextField('Domicilio', 'domicilio'),
                            _buildTextField('Email', 'email'),
                            _buildTextField('Teléfono', 'telefono'),
                            _buildTextField(
                                'Entrevistado por', 'entrevistador'),
                            _buildTextField('Remitido por', 'remitido'),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('2.- MOTIVO DE CONSULTA'),
                            _buildTextFielMaxLine(
                                'Motivo de consulta', 'motivoC'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('3.- CARACTERIZACIÓN DEL PROBLEMA'),
                            _buildTextFielMaxLine(
                                '¿Desde cuando inicia y cuales son los síntomas? Frecuencia y manejo.',
                                'caracteProbl'),
                            _buildTextFielMaxLine(
                                'Historia escolar', 'historiaEsco'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('4.- ANTECEDENTES DEL PERSONALES'),
                            _buildSection('   4.1. Antecedentes prenatales'),
                            _buildCheckboxGroup(_antecedentesPrenatales,
                                _antecedentesPrenatalesLabels,
                                label: 'Antecedentes Prenatales'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   4.2. Antecedentes perinatales'),
                            _buildSection('   Duración de la gestación:'),
                            _buildCheckboxGroupLaders(
                                _duracionGestacion, _duracionGestacionLabels),
                            _buildTextField(
                                'Lugar de atención', 'lugarAtencion'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   Tipo de parto:'),
                            _buildCheckboxGroupLaders(
                                _tipoParto, _tipoPartoLabels),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   Duración del parto:'),
                            _buildCheckboxGroupLaders(
                                _duracionParto, _duracionPartoLabels),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   Presentación:'),
                            _buildCheckboxGroupLaders(
                                _presentacion, _presentacionLabels),
                            Divider(),
                            SizedBox(height: 10),
                            _buildRadioButtonGroup(
                              'Lloro al nacer:',
                              ['SI', 'NO'],
                              _selectedValueLloro,
                              (String? value) {
                                setState(() {
                                  _selectedValueLloro = value;
                                  _selectedHistoria!['lloroAlNacer'] = value;
                                });
                              },
                            ),
                            Divider(),
                            SizedBox(height: 10),
                            _buildRadioButtonGroup(
                              'Sufrimiento fetal:',
                              ['SI', 'NO'],
                              _selectedValueSufrimiento,
                              (String? value) {
                                setState(() {
                                  _selectedValueSufrimiento = value;
                                  _selectedHistoria!['sufrimientoFetal'] =
                                      value;
                                });
                              },
                            ),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   Al nacer necesito:'),
                            _buildCheckboxGroupLaders(
                                _alNacernecesito, _alNacernecesitoLabels),
                            _buildTextField('Tiempo', 'tiempo'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   Al nacer presento:'),
                            _buildCheckboxGroup(
                                _alNacerPresento, _alNacerPresentoLabels),
                            _buildTextField('Peso', 'Peso'),
                            _buildTextField('Talla', 'Talla'),
                            _buildTextField(
                                'Perímetro cefálico', 'perimetroCefali'),
                            _buildTextField('Apgar', 'apgar'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildTextFielMaxLine(
                                'Observaciones', 'Observaciones'),
                            SizedBox(height: 10),
                            Divider(),
                            SizedBox(height: 10),
                            _buildSection('   4.3. Antecedentes postnatales'),
                            _buildSection('    Alimentación:'),
                            _buildCheckboxGroupLaders(
                                _alimentacion, _alimentacionLabels),
                            SizedBox(height: 10),
                            Divider(),
                            _buildSection('    Desarrollo motor grueso:'),
                            _buildCheckboxGroup(
                                _desarrolloMgrueso, _desarrolloMgruesoLabels),
                            SizedBox(height: 10),
                            Divider(),
                            _buildSection('    Reflejos primitivos:'),
                            Container(
                              height: 3.0,
                              width: 50.0,
                              color: const Color.fromARGB(112, 75, 107, 176),
                            ),
                            _buildRadioButtonGroup(
                              'Palmar - Plantar',
                              ['SI', 'NO'],
                              _selectedValuePalmarplantar,
                              (String? value) {
                                setState(() {
                                  _selectedValuePalmarplantar = value;
                                  _selectedHistoria!['Palmarplantar'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Moro',
                              ['SI', 'NO'],
                              _selectedValueMoro,
                              (String? value) {
                                setState(() {
                                  _selectedValueMoro = value;
                                  _selectedHistoria!['Moro'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Presión',
                              ['SI', 'NO'],
                              _selectedValuePresion,
                              (String? value) {
                                setState(() {
                                  _selectedValuePresion = value;
                                  _selectedHistoria!['Prensión'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'De búsqueda',
                              ['SI', 'NO'],
                              _selectedValueDebusqueda,
                              (String? value) {
                                setState(() {
                                  _selectedValueDebusqueda = value;
                                  _selectedHistoria!['Debúsqueda'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Banbiski',
                              ['SI', 'NO'],
                              _selectedValueBabinski,
                              (String? value) {
                                setState(() {
                                  _selectedValueBabinski = value;
                                  _selectedHistoria!['Babinski'] = value;
                                });
                              },
                            ),
                            SizedBox(height: 10),
                            Divider(),
                            _buildSection('    Desarrollo motor fino:'),
                            Container(
                              height: 3.0,
                              width: 50.0,
                              color: const Color.fromARGB(112, 75, 107, 176),
                            ),
                            _buildRadioButtonGroup(
                              'Pinza digital',
                              ['SI', 'NO'],
                              _selectedValuePinzadigital,
                              (String? value) {
                                setState(() {
                                  _selectedValuePinzadigital = value;
                                  _selectedHistoria!['PinzaDigital'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Garabateo',
                              ['SI', 'NO'],
                              _selectedValueGarabateo,
                              (String? value) {
                                setState(() {
                                  _selectedValueGarabateo = value;
                                  _selectedHistoria!['Garabato'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Sostener objetos',
                              ['SI', 'NO'],
                              _selectedValueSostenerobjetos,
                              (String? value) {
                                setState(() {
                                  _selectedValueSostenerobjetos = value;
                                  _selectedHistoria!['SostenerObjeto'] = value;
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
                            _buildRadioButtonGroup(
                              'Problemas de alimnetación',
                              ['SI', 'NO'],
                              _selectedValueProblemasenAlimentacion,
                              (String? value) {
                                setState(() {
                                  _selectedValueProblemasenAlimentacion = value;
                                  _selectedHistoria![
                                      'ProblemasenAlimentacion'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Garabateo',
                              ['SI', 'NO'],
                              _selectedValueGarabateoT,
                              (String? value) {
                                setState(() {
                                  _selectedValueGarabateoT = value;
                                  _selectedHistoria!['GarabateoT'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Tics motores',
                              ['SI', 'NO'],
                              _selectedValueTicsmotores,
                              (String? value) {
                                setState(() {
                                  _selectedValueTicsmotores = value;
                                  _selectedHistoria!['Ticsmotores'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Tics vocales',
                              ['SI', 'NO'],
                              _selectedValueTicsvocales,
                              (String? value) {
                                setState(() {
                                  _selectedValueTicsvocales = value;
                                  _selectedHistoria!['Ticsvocales'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Conductas problemáticas',
                              ['SI', 'NO'],
                              _selectedValueConductasproblematicas,
                              (String? value) {
                                setState(() {
                                  _selectedValueConductasproblematicas = value;
                                  _selectedHistoria!['Conductasproblematicas'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Sonrisa social',
                              ['SI', 'NO'],
                              _selectedValueSonrisasocial,
                              (String? value) {
                                setState(() {
                                  _selectedValueSonrisasocial = value;
                                  _selectedHistoria!['Sonrisasocial'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Movimientos estereotipados',
                              ['SI', 'NO'],
                              _selectedValueMovimientosestereotipados,
                              (String? value) {
                                setState(() {
                                  _selectedValueMovimientosestereotipados =
                                      value;
                                  _selectedHistoria![
                                      'Movimientosestereotipados'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Manipula permanentemente un objeto',
                              ['SI', 'NO'],
                              _selectedValueManipulapermanentementeunobjeto,
                              (String? value) {
                                setState(() {
                                  _selectedValueManipulapermanentementeunobjeto =
                                      value;
                                  _selectedHistoria![
                                          'Manipulapermanentementeunobjeto'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Balanceos',
                              ['SI', 'NO'],
                              _selectedValueBalanceos,
                              (String? value) {
                                setState(() {
                                  _selectedValueBalanceos = value;
                                  _selectedHistoria!['Balanceos'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Juego repetitivo',
                              ['SI', 'NO'],
                              _selectedValueJuegorepetitivo,
                              (String? value) {
                                setState(() {
                                  _selectedValueJuegorepetitivo = value;
                                  _selectedHistoria!['Juegorepetitivo'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Tendencia a rutinas',
                              ['SI', 'NO'],
                              _selectedValueTendenciaarutinas,
                              (String? value) {
                                setState(() {
                                  _selectedValueTendenciaarutinas = value;
                                  _selectedHistoria!['Tendenciaarutinas'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Camina sin sentido',
                              ['SI', 'NO'],
                              _selectedValueCaminasinsentido,
                              (String? value) {
                                setState(() {
                                  _selectedValueCaminasinsentido = value;
                                  _selectedHistoria!['Caminasinsentido'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Problemas de sueño',
                              ['SI', 'NO'],
                              _selectedValueProblemasdesueno,
                              (String? value) {
                                setState(() {
                                  _selectedValueProblemasdesueno = value;
                                  _selectedHistoria!['Problemasdesueño'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Reitera temas favoritos',
                              ['SI', 'NO'],
                              _selectedValueReiteratemasfavoritos,
                              (String? value) {
                                setState(() {
                                  _selectedValueReiteratemasfavoritos = value;
                                  _selectedHistoria!['Reiteratemasfavoritos'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Camina en puntitas',
                              ['SI', 'NO'],
                              _selectedValueCaminaenpuntitas,
                              (String? value) {
                                setState(() {
                                  _selectedValueCaminaenpuntitas = value;
                                  _selectedHistoria!['Caminaenpuntitas'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Irritabilidad',
                              ['SI', 'NO'],
                              _selectedValueIrritabilidad,
                              (String? value) {
                                setState(() {
                                  _selectedValueIrritabilidad = value;
                                  _selectedHistoria!['Irritabilidad'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Manipula permanentemente algo',
                              ['SI', 'NO'],
                              _selectedValueManipulapermanentementealgo,
                              (String? value) {
                                setState(() {
                                  _selectedValueManipulapermanentementealgo =
                                      value;
                                  _selectedHistoria![
                                      'Manipulapermanentementealgo'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Inicia y mantiene conversación',
                              ['SI', 'NO'],
                              _selectedValueIniciaymantieneconversacion,
                              (String? value) {
                                setState(() {
                                  _selectedValueIniciaymantieneconversacion =
                                      value;
                                  _selectedHistoria![
                                      'Iniciaymantieneconversacion'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Ecolalia',
                              ['SI', 'NO'],
                              _selectedValueEcolalia,
                              (String? value) {
                                setState(() {
                                  _selectedValueEcolalia = value;
                                  _selectedHistoria!['Ecolalia'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Conocimiento de algún tema',
                              ['SI', 'NO'],
                              _selectedValueConocimientodealguntema,
                              (String? value) {
                                setState(() {
                                  _selectedValueConocimientodealguntema = value;
                                  _selectedHistoria![
                                      'Conocimientodealguntema'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Lenguaje literal',
                              ['SI', 'NO'],
                              _selectedValueLenguajeliteral,
                              (String? value) {
                                setState(() {
                                  _selectedValueLenguajeliteral = value;
                                  _selectedHistoria!['Lenguajeliteral'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Mira a los ojos',
                              ['SI', 'NO'],
                              _selectedValueMiraalosojos,
                              (String? value) {
                                setState(() {
                                  _selectedValueMiraalosojos = value;
                                  _selectedHistoria!['Miraalosojos'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Otros sistemas de comunicación',
                              ['SI', 'NO'],
                              _selectedValueOtrossistemasdecomunicacion,
                              (String? value) {
                                setState(() {
                                  _selectedValueOtrossistemasdecomunicacion =
                                      value;
                                  _selectedHistoria![
                                      'Otrossistemasdecomunicacion'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Selectivo en la comida',
                              ['SI', 'NO'],
                              _selectedValueSelectivoenlacomida,
                              (String? value) {
                                setState(() {
                                  _selectedValueSelectivoenlacomida = value;
                                  _selectedHistoria!['Selectivoenlacomida'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Intención comunicativa',
                              ['SI', 'NO'],
                              _selectedValueIntensioncomunicativa,
                              (String? value) {
                                setState(() {
                                  _selectedValueIntensioncomunicativa = value;
                                  _selectedHistoria!['Intensioncomunicativa'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Interés restringido',
                              ['SI', 'NO'],
                              _selectedValueInteresrestringido,
                              (String? value) {
                                setState(() {
                                  _selectedValueInteresrestringido = value;
                                  _selectedHistoria!['Interesrestringido'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Angustia sin causa',
                              ['SI', 'NO'],
                              _selectedValueAngustiasincausa,
                              (String? value) {
                                setState(() {
                                  _selectedValueAngustiasincausa = value;
                                  _selectedHistoria!['Angustiasincausa'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Preferencia por algún alimento',
                              ['SI', 'NO'],
                              _selectedValuePreferenciaporalgunalimento,
                              (String? value) {
                                setState(() {
                                  _selectedValuePreferenciaporalgunalimento =
                                      value;
                                  _selectedHistoria![
                                      'Preferenciaporalgunalimento'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Sonidos extraños',
                              ['SI', 'NO'],
                              _selectedValueSonidosextranos,
                              (String? value) {
                                setState(() {
                                  _selectedValueSonidosextranos = value;
                                  _selectedHistoria!['Sonidosextranos'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Habla como adulto',
                              ['SI', 'NO'],
                              _selectedValueHablacomoadulto,
                              (String? value) {
                                setState(() {
                                  _selectedValueHablacomoadulto = value;
                                  _selectedHistoria!['Hablacomoadulto'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Frío para hablar',
                              ['SI', 'NO'],
                              _selectedValueFrioparahablar,
                              (String? value) {
                                setState(() {
                                  _selectedValueFrioparahablar = value;
                                  _selectedHistoria!['Frioparahablar'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Pensamiento obsesivo',
                              ['SI', 'NO'],
                              _selectedValuePensamientoobsesivo,
                              (String? value) {
                                setState(() {
                                  _selectedValuePensamientoobsesivo = value;
                                  _selectedHistoria!['Pensamientoobsesivo'] =
                                      value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Cambio de carácter extremo',
                              ['SI', 'NO'],
                              _selectedValueCambiodecaracterextremo,
                              (String? value) {
                                setState(() {
                                  _selectedValueCambiodecaracterextremo = value;
                                  _selectedHistoria![
                                      'Cambiodecaracterextremo'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Ingenuo',
                              ['SI', 'NO'],
                              _selectedValueIngenuo,
                              (String? value) {
                                setState(() {
                                  _selectedValueIngenuo = value;
                                  _selectedHistoria!['Ingenuo'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Torpeza motriz',
                              ['SI', 'NO'],
                              _selectedValueTorpezamotriz,
                              (String? value) {
                                setState(() {
                                  _selectedValueTorpezamotriz = value;
                                  _selectedHistoria!['Torpezamotriz'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Frío emocional',
                              ['SI', 'NO'],
                              _selectedValueFrioemocional,
                              (String? value) {
                                setState(() {
                                  _selectedValueFrioemocional = value;
                                  _selectedHistoria!['Frioemocional'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Pocos amigos',
                              ['SI', 'NO'],
                              _selectedValuePocosamigos,
                              (String? value) {
                                setState(() {
                                  _selectedValuePocosamigos = value;
                                  _selectedHistoria!['Pocosamigos'] = value;
                                });
                              },
                            ),
                            _buildRadioButtonGroup(
                              'Juego imaginativo',
                              ['SI', 'NO'],
                              _selectedValueJuegoimaginativo,
                              (String? value) {
                                setState(() {
                                  _selectedValueJuegoimaginativo = value;
                                  _selectedHistoria!['Juegoimaginativo'] =
                                      value;
                                });
                              },
                            ),


                            SizedBox(height: 10),
                            Divider(),
                            _buildSection('ESPECIFICACIONES'),
                            SizedBox(height: 10),
                            _buildTextFielMaxLine('Intención comunicativa', 'intensionComunica'),
                            _buildTextFielMaxLine('Traumatismo', 'traumatismo'),
                           _buildTextFielMaxLine('Infecciones......', 'infecciones'),
                            _buildTextFielMaxLine('Reacciones pecualiares', 'reaccionPecu'),
                            _buildTextFielMaxLine('Desnutrición....', 'desnutricion'),
                            _buildTextFielMaxLine('Cirugías', 'cirugias'),
                            _buildTextFielMaxLine('Convulsiones', 'convulsiones'),
                            _buildTextFielMaxLine('Medicación', 'medicacion'),
                            _buildTextFielMaxLine('Sindromes', 'sindormes'),
                            _buildTextFielMaxLine('Observaciones', 'Observaciones2'),
                            _buildTextFielMaxLine('EE,TAC,RM...', 'eeTacRm'),


                            
                             SizedBox(height: 10),
                            Divider(),
                            _buildSection('5.- HÁBITOS PERSONALES'),
                             SizedBox(height: 20),
                             _buildSection('   Reacción ante las dificultades:'),
                             _buildCheckboxGroup(
                                _ReaccionAnteDificul, _ReaccionAnteDificulLabels),

                            Divider(),
                            SizedBox(height: 20),
                             _buildSection('   Aptitudes e intereses escolares:'),
                             _buildTextFielMaxLine('', 'aptitudIntereEscolar'),
                           
                            Divider(),
                            SizedBox(height: 20),
                             _buildSection('   Rendimiento general en escolaridad :'),
                             _buildTextFielMaxLine('', 'rendiGeneescolar'),


                             Divider(),
                            SizedBox(height: 20),
                             _buildSection('   Comportamiento general:'),
                             _buildCheckboxGroup(
                                _comportaGeneral, _comportaGeneralLabels),


                                 Divider(),
                            SizedBox(height: 20),
                             _buildSection('   Aspectos de socialización :'),
                              Container(
                              height: 3.0,
                              width: 50.0,
                              color: const Color.fromARGB(112, 75, 107, 176),
                            ),
                             _buildSection('       Socialzación'),
                              _buildCheckboxGroup(
                                _Socializacion, _SocializacionLabels), 

                                    Divider(),
                            SizedBox(height: 20),                             
                             _buildSection('       Aspectos cognitivos '),
                              _buildCheckboxGroup(
                                _AspcCogni, _AspcCogniLabels),      



                                 Divider(),
                            SizedBox(height: 20),
                             _buildSection('   DATOS FAMILIARES'),  
                             _buildSection('       Tipo de hogar'), 
                             _buildCheckboxGroup(
                                _tipoHogar, _tipoHogarLabels),  

                                 
                            SizedBox(height: 20),
                            Container(
                              height: 3.0,
                              width: 50.0,
                              color: const Color.fromARGB(112, 75, 107, 176),
                            ),
                             _buildSection(' ¿Quién vive en la casa?'),
                             _buildTextFielMaxLine('', 'quienViveCasa'),
                             SizedBox(height: 20),
                             Container(
                              height: 3.0,
                              width: 50.0,
                              color: const Color.fromARGB(112, 75, 107, 176),
                            ), 
                           
                            SizedBox(height: 20),
                             _buildSection('   Integración sensorial'),
                             _buildCheckboxGroup(
                                _integraSensorial, _integraSensorialLabels),  

                            
                            SizedBox(height: 20),
                          ],
                        ),
                      )
                    : Text('No se encontraron historias clínicas'),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String key, {bool isNumeric = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Fondo completamente blanco sin opacidad
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Desplazamiento de la sombra
            ),
          ],
        ),
        child: TextField(
          controller: TextEditingController(
            text: (_selectedHistoria?[key] ?? '')
                .toString(), // Conversión a string
          ),
          keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
          onChanged: (value) {
            setState(() {
              _selectedHistoria![key] =
                  isNumeric ? int.tryParse(value) : value; // Conversión inversa
            });
          },
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(
              color: Colors.grey[800], // Color de la etiqueta más oscuro
            ),
            border: OutlineInputBorder(),
          ),
          enabled: _isEditing, // Control de edición (bloqueado o no)
          style: TextStyle(
            color: Colors.black, // Asegura que el texto se vea claramente
          ),
        ),
      ),
    );
  }

  Widget _buildTextFielMaxLine(String label, String key) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: TextField(
                  controller: TextEditingController(
                    text: (_selectedHistoria?[key] ?? '').toString(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _selectedHistoria![key] = value;
                    });
                  },
                  maxLines: null,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  enabled: _isEditing,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}

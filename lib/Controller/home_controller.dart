


import 'package:flutter_application_1/Model/home_model.dart';

class HomeController {
  final HomeModel _model = HomeModel();

  String getUserName() {
    return _model.getUserName();
  }
}

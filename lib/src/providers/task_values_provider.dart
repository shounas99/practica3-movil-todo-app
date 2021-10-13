//Provider que me ayudara a manejar valores de mis formularios

import 'package:flutter/material.dart';

class TaskValuesProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>(); //Estados de formularios

  //Inicializar valores
  String? nameTask;
  String? desTask;
  String? dateTask;
  int? doneTask;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    this._isLoading = value;
    notifyListeners();
  }
}
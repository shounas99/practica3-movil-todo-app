//Clase que me ayudara a saber cual sera mi pantalla seleccionada
//UserInterface

import 'package:flutter/material.dart';

class UiProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  //Aqui se ejecutara el codigo
  set selectedMenuOpt(int i) {
    this._selectedMenuOpt = i;
    //Notificar cuando cambie
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class AportesProvider with ChangeNotifier {
  int _aportes = 0;

  int get aportes => _aportes;

  void incrementAportes() {
    _aportes += 1;
    notifyListeners();
  }
}



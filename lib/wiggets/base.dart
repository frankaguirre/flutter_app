import 'package:flutter/material.dart';

class AportesModel with ChangeNotifier {
  int _aporteCount = 0;

  int get aporteCount => _aporteCount;

  void addAporte() {
    _aporteCount += 1;
    notifyListeners();
  }

  void resetAportes() {
    _aporteCount = 0;
    notifyListeners();
  }
}

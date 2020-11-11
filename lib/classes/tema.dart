import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sctproject/classes/spHelper.dart';
import 'package:sctproject/utils/theme.dart';

class TemaCambio with ChangeNotifier {
  static int numeroTema = SPHelper.getInt('temaActual') ?? 0;

  ThemeData temaActual() {
    switch (numeroTema) {
      case 0:
        return basicTheme();
        break;
      case 1:
        return temaOscuro();
        break;
      case 2:
        return temaAmoled();
        break;

      default:
        return basicTheme();
    }
  }

  void cambiarTema(int num) {
    if (numeroTema != num) {
      numeroTema = num;
      SPHelper.setInt('temaActual', numeroTema);
      notifyListeners();
    }
  }
}

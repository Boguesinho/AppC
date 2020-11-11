import 'package:sctproject/models/solve.dart';

class CalculoAvg {
  static double getActualAoX(List<Solve> listaSolves, int cantidadAvg) {
    listaSolves = listaSolves.reversed.toList();
    List<double> tiempos = new List<double>();

    if (listaSolves.length >= cantidadAvg) {
      for (int i = 0; i < cantidadAvg; i++) {
        listaSolves[i].masdos == 1
            ? tiempos.add(listaSolves[i].tiempo + 2)
            : tiempos.add(listaSolves[i].tiempo);
      }

      if (cantidadAvg == 3) {
        double sum = tiempos.reduce((a, b) => a + b);
        return sum / tiempos.length;
      }

      double mayor = tiempos[0];
      double menor = tiempos[0];

      for (int i = 0; i < cantidadAvg; i++) {
        if (tiempos[i] > mayor) {
          mayor = tiempos[i];
        }
        if (tiempos[i] < menor) {
          menor = tiempos[i];
        }
      }
      double sum = tiempos.reduce((a, b) => a + b) - menor - mayor;
      return sum / (tiempos.length - 2);
    }
    return 0;
  }

  static double getMejorAoX(List<Solve> listaSolves, int cantidadAvg) {
    listaSolves = listaSolves.reversed.toList();
    List<double> tiempos = new List<double>();

    if (listaSolves.length >= cantidadAvg) {
      for (int i = 0; i < cantidadAvg; i++) {
        listaSolves[i].masdos == 1
            ? tiempos.add(listaSolves[i].tiempo + 2)
            : tiempos.add(listaSolves[i].tiempo);
      }

      double mayor = tiempos[0];
      double menor = tiempos[0];

      for (int i = 0; i < cantidadAvg; i++) {
        if (tiempos[i] > mayor) {
          mayor = tiempos[i];
        }
        if (tiempos[i] < menor) {
          menor = tiempos[i];
        }
      }
      double sum = tiempos.reduce((a, b) => a + b) - menor - mayor;
      return sum / (tiempos.length - 2);
    }
    return 0;
  }
}

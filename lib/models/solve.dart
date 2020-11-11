import 'dart:core';

import 'package:sctproject/DB/dataBaseProvider.dart';

class Solve {
  int idSolve;
  double tiempo;
  String scramble;
  int masdos;
  int dnf;
  int favorito;
  int emoticon;
  int sesion;
  int categoria;

  Solve({
    this.idSolve,
    this.tiempo,
    this.scramble,
    this.masdos,
    this.dnf,
    this.favorito,
    this.emoticon,
    this.sesion,
    this.categoria,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_TIEMPO: tiempo,
      DatabaseProvider.COLUMN_SCRAMBLE: scramble,
      DatabaseProvider.COLUMN_MASDOS: masdos,
      DatabaseProvider.COLUMN_DNF: dnf,
      DatabaseProvider.COLUMN_FAVORITO: favorito,
      DatabaseProvider.COLUMN_EMOTICON: emoticon,
      DatabaseProvider.COLUMN_FOREIGN_SESIONES: sesion,
      DatabaseProvider.COLUMN_FOREIGN_SESIONES_CATEGORIAS: categoria
    };

    if (idSolve != null) {
      map[DatabaseProvider.COLUMN_IDSOLVE] = idSolve;
    }

    return map;
  }

  Solve.fromMap(Map<String, dynamic> map) {
    idSolve = map[DatabaseProvider.COLUMN_IDSOLVE];
    tiempo = map[DatabaseProvider.COLUMN_TIEMPO];
    scramble = map[DatabaseProvider.COLUMN_SCRAMBLE];
    masdos = map[DatabaseProvider.COLUMN_MASDOS];
    dnf = map[DatabaseProvider.COLUMN_DNF];
    favorito = map[DatabaseProvider.COLUMN_FAVORITO];
    emoticon = map[DatabaseProvider.COLUMN_EMOTICON];
    sesion = map[DatabaseProvider.COLUMN_FOREIGN_SESIONES];
    categoria = map[DatabaseProvider.COLUMN_FOREIGN_SESIONES_CATEGORIAS];
  }
}

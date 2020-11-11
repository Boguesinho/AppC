import 'dart:core';

import 'package:sctproject/DB/dataBaseProvider.dart';

class Sesion {
  int idSesion;
  String nombreSesion;
  int foreignCategorias;

  Sesion({this.idSesion, this.nombreSesion, this.foreignCategorias});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.COLUMN_IDSESION: idSesion,
      DatabaseProvider.COLUMN_NOMBRESESION: nombreSesion,
      DatabaseProvider.COLUMN_FOREIGN_CATEGORIAS: foreignCategorias,
    };

    if (idSesion != null) {
      map[DatabaseProvider.COLUMN_IDSESION] = idSesion;
    }

    return map;
  }

  Sesion.fromMap(Map<String, dynamic> map) {
    idSesion = map[DatabaseProvider.COLUMN_IDSESION];
    nombreSesion = map[DatabaseProvider.COLUMN_NOMBRESESION];
    foreignCategorias = map[DatabaseProvider.COLUMN_FOREIGN_CATEGORIAS];
  }
}

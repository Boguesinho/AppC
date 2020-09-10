import 'package:flutter/material.dart';

class InformacionEquipo {
  bool _enEquipo = false;
  int _cantidadMiembros = 27;
  String _nombreEquipo = "Gan Rubik's Team";
  String _descripcionEquipo = "For al Gan's members around the world";
  String _anfitrionEquipo = "Gan";
  String _fechaCreacion = "06/09/2020";
  Widget _imagenEquipo = Image(
    image: AssetImage('assets/images/Gan.jpg'),
    height: 1000,
    width: 1000,
  );

  //GETTERS

  bool get enEquipo => _enEquipo;
  String get anfitrionEquipo => _anfitrionEquipo;
  String get nombreEquipo => _nombreEquipo;
  String get descripcionEquipo => _descripcionEquipo;
  Widget get imagenEquipo => _imagenEquipo;
  int get cantidadMiembros => _cantidadMiembros;

  //SETTERS

  set setEnEquipo(bool enEquipo) {
    this._enEquipo = enEquipo;
  }

  set setCantidadMiembros(int cantidadMiembros) {
    this._cantidadMiembros = cantidadMiembros;
  }

  set setNombreEquipo(String nombreEquipo) {
    this._nombreEquipo = nombreEquipo;
  }

  set setDescripcionEquipo(String descripcionEquipo) {
    this._descripcionEquipo = descripcionEquipo;
  }

  set setAnfitrionEquipo(String anfitrionEquipo) {
    this._anfitrionEquipo = anfitrionEquipo;
  }
}

import 'package:flutter/material.dart';

class InformacionEquipo {
  bool _enEquipo = false;
  String _nombreEquipo = "";
  String _descripcionEquipo = "";
  String _anfitrionEquipo = "";
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

  //SETTERS

  set setEnEquipo(bool enEquipo) {
    this._enEquipo = enEquipo;
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

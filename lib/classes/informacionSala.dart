class InformacionSala {
  bool _enSala = false;
  int _cantidadEnSala = 12;
  String _nombreSala = "Jarocholos Retas";
  String _descripcionSala = "Para echar las retas con los panas";
  String _anfitrionSala = "Alejandro Ortega";
  bool _salaAbierta = true;
  String _categoriaSala = "3x3";

  //GETTERS

  bool get getEnSala => _enSala;
  int get getCantidadEnSala => _cantidadEnSala;
  String get getNombreSala => _nombreSala;
  String get getDescripcionSala => _descripcionSala;
  String get getAnfitrionSala => _anfitrionSala;
  bool get getSalaAbierta => _salaAbierta;
  String get getCategoriaSala => _categoriaSala;

  //SETTERS

  set setEnSala(bool enSala) {
    this._enSala = enSala;
  }

  set setCantidadEnSala(int cantidadEnSala) {
    this._cantidadEnSala = cantidadEnSala;
  }

  set setNombreSala(String nombreSala) {
    this._nombreSala = nombreSala;
  }

  set setDescripcionSala(String descripcionSala) {
    this._descripcionSala = descripcionSala;
  }

  set setAnfitrionSala(String anfitrionSala) {
    this._anfitrionSala = anfitrionSala;
  }

  set setSalaAbierta(bool salaAbierta) {
    this._salaAbierta = salaAbierta;
  }

  set setCategoriaSala(String categoriaSala) {
    this._categoriaSala = categoriaSala;
  }
}

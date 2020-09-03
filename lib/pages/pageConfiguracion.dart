import 'package:flutter/material.dart';
import 'package:sctproject/classes/informacionEquipo.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InformacionEquipo info = new InformacionEquipo();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Configuración'),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("CAMBIADO ESTADO...");
          info.setEnEquipo = info.enEquipo ? false : true;
          print(info.enEquipo);
        },
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sctproject/classes/tema.dart';

import '../main.dart';

class Configuracion extends StatefulWidget {
  Configuracion({Key key}) : super(key: key);

  @override
  _ConfiguracionState createState() => _ConfiguracionState();
}

class _ConfiguracionState extends State<Configuracion> {
  TemaCambio temaActual = MyApp.getThemeObject();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Estadísticas Avanzadas'),
      ),
      body: Container(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CupertinoButton(
                  child: Container(
                    color: Colors.yellow,
                    height: 50,
                    width: 50,
                  ),
                  onPressed: () {
                    temaActual.cambiarTema(0);
                  }),
              CupertinoButton(
                  child: Container(
                    color: Colors.grey[400],
                    height: 50,
                    width: 50,
                  ),
                  onPressed: () {
                    temaActual.cambiarTema(1);
                  }),
              CupertinoButton(
                  child: Container(
                    color: Colors.grey[800],
                    height: 50,
                    width: 50,
                  ),
                  onPressed: () {
                    temaActual.cambiarTema(2);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

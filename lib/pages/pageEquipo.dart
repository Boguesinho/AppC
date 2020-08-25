import 'package:flutter/material.dart';

import 'customNavigationBar.dart';

class Equipo extends StatelessWidget {
  const Equipo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Equipo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Ventana de búsqueda de equipos y chat del equipo',
            ),
          ],
        ),
      ),
    );
  }
}

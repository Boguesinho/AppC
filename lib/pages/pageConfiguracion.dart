import 'package:flutter/material.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text('Configuración'),
      ),
    );
  }
}

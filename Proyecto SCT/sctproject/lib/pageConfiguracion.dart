import 'package:flutter/material.dart';
import 'package:sctproject/customNavigationBar.dart';

class Configuracion extends StatelessWidget {
  const Configuracion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFADADAD),
      appBar: AppBar(
        title: Text('Configuración'),
      ),
    );
  }
}

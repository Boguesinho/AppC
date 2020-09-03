import 'package:flutter/material.dart';

class ChatEquipo extends StatefulWidget {
  ChatEquipo({Key key}) : super(key: key);

  @override
  _ChatEquipoState createState() => _ChatEquipoState();
}

class _ChatEquipoState extends State<ChatEquipo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Text("VENTANA DE CHAT EQUIPO"),
      ),
    );
  }
}

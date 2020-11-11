import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sctproject/classes/tema.dart';

class ConfiguracionCuenta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: <Widget>[
              Divider(color: Colors.transparent),
              Divider(color: Colors.transparent),
              ListTile(
                title: Text("Tema de Aplicación"),
                trailing: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 36.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0) //
                            ),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue,
                              Theme.of(context).primaryColor,
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text("Tema de Aplicación"),
                trailing: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 70,
                      height: 36.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20.0) //
                            ),
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue,
                              Theme.of(context).primaryColor,
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

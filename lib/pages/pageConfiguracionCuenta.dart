import 'package:flutter/material.dart';

class ConfiguracionCuenta extends StatefulWidget {
  ConfiguracionCuenta({Key key}) : super(key: key);

  @override
  _ConfiguracionCuentaState createState() => _ConfiguracionCuentaState();
}

class _ConfiguracionCuentaState extends State<ConfiguracionCuenta> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: 40),
          Container(
            height: 45,
            width: 80,
            alignment: Alignment.bottomRight,
            child: OutlineButton(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25.0)),
                color: Colors.transparent,
                child: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).iconTheme.color,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
        ],
      ),
    );
  }
}

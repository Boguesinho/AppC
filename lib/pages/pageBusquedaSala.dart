import 'package:flutter/material.dart';

class BusquedaSala extends StatelessWidget {
  const BusquedaSala({Key key}) : super(key: key);

  final String categoriaSala = "Megaminx";
  final String anfitrionSala = "Feliks Zemdegs";
  final String idiomaSala = "Español";
  final String tituloSala = "Jarocholos Team";
  final String descripcionSala =
      "Sala creada para echar las retas con los del team pai";

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: <Widget>[
        Container(
          // Here the height of the container is 45% of our total height
          height: size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue, Colors.grey])),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment: Alignment.topRight,
                ),
                Divider(
                  color: Color(0x00EBEBEB),
                  height: 20.0,
                ),
                Text(
                  "Únete o crea una sala para competir!",
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Divider(
                  color: Color(0x00EBEBEB),
                  height: 80.0,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .80,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    children: <Widget>[
                      for (int i = 0; i < 10; i++) _buildContainer(context),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  //CONSTRUIR CONTENEDOR
  Widget _buildContainer(context) {
    return Material(
      color: Color(0x00787878),
      child: InkWell(
        onTap: () => print("CONTENEDOR PRESIONADO"),
        child: Container(
          padding: EdgeInsets.all(3.5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 17),
                  blurRadius: 17,
                  spreadRadius: -23,
                  color: Colors.black,
                )
              ]),
          child: Column(children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/3x3.png'),
                  height: 32,
                  width: 32,
                ),
                Text(
                  '$categoriaSala',
                  style: TextStyle(color: Color(0xff505050)),
                  //textAlign: TextAlign.end,
                  textScaleFactor: 1.4,
                ),
              ],
            ),
            Divider(
              height: 6,
            ),
            Row(
              children: <Widget>[
                Text(
                  'Anfitrión: ',
                  style: TextStyle(color: Color(0xff505050)),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                ),
                Text(
                  '$anfitrionSala',
                  style: TextStyle(color: Colors.grey),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1,
                  maxLines: 1,
                ),
              ],
            ),
            Divider(
              height: 95,
            ),
            Divider(
              height: 4,
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sctproject/customNavigationBar.dart';

class BusquedaSala extends StatelessWidget {
  const BusquedaSala({Key key}) : super(key: key);

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
                  "Creación / Búsqueda \nde Salas",
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
          padding: EdgeInsets.all(5),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Image(
                  image: AssetImage('assets/images/3x3.png'),
                  height: 34,
                  width: 34,
                ),
                Text(
                  'Megaminx',
                  style: TextStyle(color: Color(0xff505050)),
                  //textAlign: TextAlign.end,
                  textScaleFactor: 1.5,
                ),
              ],
            ),
            Divider(),
            Row(
              children: <Widget>[
                Text(
                  '',
                  style: TextStyle(color: Color(0xff505050)),
                  textAlign: TextAlign.center,
                  textScaleFactor: 2,
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sctproject/classes/tema.dart';
import 'package:sctproject/pages/pageConfiguracionCuenta.dart';

class PerfilUsuario extends StatefulWidget {
  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  Future _getMedallas;

  bool gradienteActivado = true;

  String nombreCuenta = "Max Park";

  String identificadorCuenta = "@maxpark1";
  String cantidadSolves = "29k";

  double mediaSolves = 6.34;
  int categoriaMostrada = 1;
  double recordPersonal = 3.31;

  int cantidadCategorias = 8;
  int cantidadMedallas = 9;

  List<Widget> widgetsParteInferior = new List<Widget>();
  List<Widget> listaRecordsPersonales = new List<Widget>();
  List<Widget> listaWidgetsMedallas = new List<Widget>();
  List<Widget> listaColumnasMedallas = new List<Widget>();

  Color colorBaseMedallas;

  @override
  void initState() {
    super.initState();

    _getMedallas = obtenerMedallas();
  }

  @override
  Widget build(BuildContext context) {
    colorBaseMedallas = Theme.of(context).primaryColor;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 265,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(25.0),
                    bottomLeft: Radius.circular(25.0),
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/fondoGris-Azul.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 36,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 51,
                          backgroundColor: Colors.black,
                        ),
                        CircleAvatar(
                          radius: 48,
                          backgroundImage: AssetImage('assets/images/park.png'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),

                    //TEXTO CON BORDE
                    Stack(
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          '$nombreCuenta',
                          style: TextStyle(
                            fontFamily: GoogleFonts.baiJamjuree().fontFamily,
                            fontSize: 25,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.black,
                          ),
                        ),
                        Text(
                          '$nombreCuenta',
                          style: TextStyle(
                            fontFamily: GoogleFonts.baiJamjuree().fontFamily,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Text(
                              'Estados Unidos',
                              style: TextStyle(
                                fontFamily:
                                    GoogleFonts.baiJamjuree().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                foreground: Paint()
                                  ..style = PaintingStyle.stroke
                                  ..strokeWidth = 1
                                  ..color = Colors.black,
                              ),
                            ),
                            Text(
                              'Estados Unidos',
                              style: TextStyle(
                                fontFamily:
                                    GoogleFonts.baiJamjuree().fontFamily,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Container(width: 13),
                        Image.asset(
                          'assets/images/usa.png',
                          height: 12,
                          width: 22,
                          alignment: Alignment.bottomCenter,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(24.0),
                          bottomLeft: Radius.circular(24.0),
                        ),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Container(),
                          ),
                          Container(
                            width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "SOLVES",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[300]),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "$cantidadSolves",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .7,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "MEDIA",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[300]),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "$mediaSolves",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .7,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 110,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  "RÉCORD",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[300]),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .8,
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  "$recordPersonal",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                  textScaleFactor: .7,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //PARTE INFERIOR PERFIL - LISTA DE RECORDS Y MEDALLAS
              Expanded(
                child: Container(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    child: Column(
                      children: getWidgetsParteInferior(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            top: 32,
            left: 16,
            child: GestureDetector(
              onTap: () {
                print("SUP IZQ PRESIONADO");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ConfiguracionCuenta()),
                );
              },
              child: Icon(
                Icons.tune,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getWidgetsParteInferior() {
    widgetsParteInferior.clear();
    widgetsParteInferior.add(Divider(height: 25, color: Colors.transparent));
    widgetsParteInferior.add(getListaMedallas());
    widgetsParteInferior.add(Divider(height: 15, color: Colors.transparent));
    widgetsParteInferior.add(personalesIncube());
    widgetsParteInferior.add(Divider(height: 35, color: Colors.transparent));
    widgetsParteInferior.add(personalesIncube());
    widgetsParteInferior.add(Divider(height: 15, color: Colors.transparent));

    return widgetsParteInferior;
  }

  Widget personalesIncube() {
    return Container(
      width: MediaQuery.of(context).size.width - 25,
      alignment: Alignment.center,
      child: Column(
        children: [
          //ETIQUETA DE TÍTULO DE RÉCORDS PERSONALES
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                width: MediaQuery.of(context).size.width - 25,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 15),
                      blurRadius: 15,
                      spreadRadius: -8,
                      color: Colors.black,
                    )
                  ],
                  borderRadius: BorderRadius.circular(14),
                  color: Theme.of(context).backgroundColor.withOpacity(.7),
                ),
                child: Text("Récords Personales (InCube) ",
                    style: Theme.of(context)
                        .textTheme
                        .headline4
                        .copyWith(fontWeight: FontWeight.w400),
                    textScaleFactor: .7,
                    textAlign: TextAlign.center),
              ),
            ],
          ),

          Divider(height: 15, thickness: 1, color: Colors.transparent),
          //ETIQUETA SINGLE, A05, A100
          Container(
            width: MediaQuery.of(context).size.width - 20,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            "Categoría",
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(fontWeight: FontWeight.w700),
                            textScaleFactor: .80,
                          ),
                          flex: 8,
                        ),
                        Expanded(
                          flex: 2,
                          child: Container(width: 20, height: 1),
                        ),
                        Expanded(
                            flex: 1, child: Container(width: 1, height: 1)),
                        Expanded(
                            flex: 1, child: Container(width: 1, height: 1)),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Single",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(fontWeight: FontWeight.w700),
                            textScaleFactor: .80,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Ao5",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(fontWeight: FontWeight.w700),
                            textScaleFactor: .80,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            "Ao100",
                            textAlign: TextAlign.left,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(fontWeight: FontWeight.w700),
                            textScaleFactor: .80,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            child: Divider(
              height: 7,
              thickness: 1,
              indent: 15,
              endIndent: 10,
              color: Colors.transparent,
            ),
          ),

          //INFORMACIÓN DEBAJO DE ETIQUETA DE RÉCORDS PERSONALES

          Container(
            child: Column(
              children: mostrarRecordsPersonales(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> mostrarRecordsPersonales() {
    if (listaRecordsPersonales.length < 1) {
      for (int i = 0; i < cantidadCategorias; i++) {
        listaRecordsPersonales.add(Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Theme.of(context).cardColor,
              ),
              child: Row(
                children: [
                  //ZONA DE LA IZQUIERDA (CATEGORÍA E IMAGEN)
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              "Megaminx",
                              textAlign: TextAlign.right,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(fontWeight: FontWeight.w500),
                              textScaleFactor: .75,
                            ),
                            flex: 8,
                          ),
                          Expanded(
                              flex: 1, child: Container(width: 1, height: 1)),
                          Expanded(
                            flex: 2,
                            child: Image(
                              image: AssetImage('assets/images/3x3.png'),
                              height: 20,
                              width: 20,
                            ),
                          ),
                          Expanded(
                              flex: 1, child: Container(width: 1, height: 1)),
                        ],
                      ),
                    ),
                  ),

                  //ZONA DE LA DERECHA (TIEMPOS)
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              "34.87",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(fontWeight: FontWeight.w400),
                              textScaleFactor: .7,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "37.91",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(fontWeight: FontWeight.w600),
                              textScaleFactor: .835,
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "40.23",
                              textAlign: TextAlign.left,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline3
                                  .copyWith(fontWeight: FontWeight.w400),
                              textScaleFactor: .7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 10,
              thickness: .8,
              indent: 15,
              endIndent: 10,
              color: Colors.transparent,
            ),
          ],
        ));
      }
    }
    return listaRecordsPersonales;
  }

  Widget getListaMedallas() {
    return Column(
      children: [
        etiquetaMedallas(),
        Divider(color: Colors.transparent, height: 25),
        Column(
          children: [
            cantidadMedallas > 0
                ? Column(children: [
                    FutureBuilder(
                        future: _getMedallas,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              alignment: Alignment.topCenter,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CupertinoActivityIndicator(),
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: mostrarMedallas(),
                            );
                          }
                        }),
                  ])
                : Column(
                    children: [
                      Text(
                        "Aún no has coseguido insignias",
                        style: Theme.of(context)
                            .textTheme
                            .headline3
                            .copyWith(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                        textScaleFactor: .8,
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 8,
                      ),
                    ],
                  ),
            Text(
              "Ver todas las insignias",
              style: Theme.of(context)
                  .textTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              textScaleFactor: .8,
            ),
          ],
        ),
        Divider(
          color: Colors.transparent,
          height: 30,
        ),
      ],
    );
  }

  Widget etiquetaMedallas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          width: MediaQuery.of(context).size.width - 25,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 15),
                blurRadius: 15,
                spreadRadius: -8,
                color: Colors.black,
              )
            ],
            borderRadius: BorderRadius.circular(14),
            color: Theme.of(context).backgroundColor.withOpacity(.7),
          ),
          child: Text("Insignias Conseguidas (InCube)",
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(fontWeight: FontWeight.w400),
              textScaleFactor: .7,
              textAlign: TextAlign.center),
        ),
      ],
    );
  }

  Future obtenerMedallas() async {
    int conteo = cantidadMedallas;
    await Future.delayed(const Duration(milliseconds: 500));
    for (int i = 0; i < conteo; i++) {
      if (conteo % 5 == 0) {
        i = conteo;
      } else {
        conteo++;
      }
    }

    for (int i = 0; i < conteo; i++) {
      listaWidgetsMedallas.add(Container(
        height: 55,
        width: 43,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: [
              BoxShadow(
                  blurRadius: 0.0,
                  offset: Offset(0, 0),
                  color: Colors.white.withOpacity(.3)),
              BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(3, 3),
                  color: Colors.black.withOpacity(.15)),
              BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(-3, -3),
                  color: Colors.black.withOpacity(.15))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: colorBaseMedallas,
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 40,
                          offset: Offset(3, 6),
                          color: Colors.black.withOpacity(.25))
                    ]),
                child: i + 1 > cantidadMedallas
                    ? Icon(Icons.remove, color: Colors.grey)
                    : Image(
                        image: AssetImage('assets/images/badge.png'),
                      ),
              ),
            ),
          ),
        ),
      ));
    }
  }

  List<Widget> mostrarMedallas() {
    int conteo = 0;
    int numMedallas = listaWidgetsMedallas.length;
    listaColumnasMedallas.clear();

    while (numMedallas > 0) {
      listaColumnasMedallas.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (numMedallas > 0) listaWidgetsMedallas[0 + conteo],
            if (numMedallas > 1) listaWidgetsMedallas[1 + conteo],
            if (numMedallas > 2) listaWidgetsMedallas[2 + conteo],
            if (numMedallas > 3) listaWidgetsMedallas[3 + conteo],
            if (numMedallas > 4) listaWidgetsMedallas[4 + conteo],
          ],
        ),
      );
      listaColumnasMedallas.add(
        Divider(color: Colors.transparent),
      );
      conteo += 5;
      numMedallas -= 5;
    }

    return listaColumnasMedallas;
  }
}

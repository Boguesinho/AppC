import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sctproject/pages/pageConfiguracionCuenta.dart';

class PerfilUsuario extends StatefulWidget {
  PerfilUsuario({Key key}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  Future _getMedallas;

  bool gradienteActivado = true;

  String nombreCuenta = "Max Park";
  String identificadorCuenta = "@maxpark1";
  int cantidadSolves = 29232;

  double mediaSolves = 6.34;
  int categoriaMostrada = 1;
  double recordPersonal = 3.31;

  int cantidadCategorias = 8;
  int cantidadMedallas = 7;

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
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              perfilParteSuperior(),
              Divider(
                color: Colors.transparent,
                height: 50,
              ),

              //MEDALLAS DE USUARIO INCUBE

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        CupertinoActivityIndicator(),
                                      ],
                                    ),
                                  );
                                } else {
                                  print(listaWidgetsMedallas.length);
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

              //LISTA DE RECORDS DE USUARIO INCUBE
              personalesIncube(),

              Divider(
                color: Colors.transparent,
                height: 50,
              ),

              Divider(
                color: Colors.transparent,
                height: 80,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget perfilParteSuperior() {
    return Stack(
      children: [
        //CONTAINER INFERIOR DE LA PORTADA
        Container(
          alignment: Alignment.bottomCenter,
          height: 236,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 22),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 30),
                  blurRadius: 40,
                  spreadRadius: -10,
                  color: Theme.of(context).backgroundColor,
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Theme.of(context).backgroundColor,
                    Theme.of(context).backgroundColor,
                  ]),
              borderRadius: BorderRadius.circular(30)),
          child: FadeInUp(
            delay: Duration(milliseconds: 0),
            duration: Duration(milliseconds: 500),
            from: 15,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                tituloDeTarjetaDePortada("3x3 InCube Solves"),
                tituloDeTarjetaDePortada("3x3 InCube Average"),
                tituloDeTarjetaDePortada("3x3 Personal Record")
              ],
            ),
          ),
        ),
        //CONTAINER SUPERIOR DE LA PORTADA

        Container(
          padding: EdgeInsets.symmetric(horizontal: 22),
          alignment: Alignment.center,
          height: 202,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).primaryColor,
                ]),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Divider(
                height: 57,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.asset('assets/images/park.png'),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            indent: 15,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2.3,
                                height: 90,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "$nombreCuenta",
                                      textScaleFactor: 1,
                                      textDirection: TextDirection.ltr,
                                      maxLines: 2,
                                      overflow: TextOverflow.fade,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                    Text(
                                      "$identificadorCuenta",
                                      textScaleFactor: 1,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .copyWith(
                                              fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(width: 5, height: 1),
                  Column(
                    children: [
                      Row(children: [
                        Container(
                          height: 32,
                          width: 32,
                          alignment: Alignment.bottomRight,
                          child: OutlineButton(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(7.0)),
                            color: Colors.transparent,
                            child: Icon(
                              Icons.settings,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            onPressed: () {
                              print('Botón: CONFIGURACIÓN oprimido');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ConfiguracionCuenta()),
                              );
                            },
                          ),
                        ),
                      ]),
                      Container(width: 5, height: 20),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              'assets/images/usa.png',
                              height: 25,
                              width: 35,
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Divider(height: 10, color: Colors.transparent),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  infoDeTarjetaDePortada("$cantidadSolves"),
                  infoDeTarjetaDePortada("$mediaSolves"),
                  infoDeTarjetaDePortada("$recordPersonal"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget infoDeTarjetaDePortada(String contenidoTarjeta) {
    return Container(
      alignment: Alignment.center,
      height: 38,
      width: MediaQuery.of(context).size.width / 3.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0) //
            ),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ]),
      ),
      padding: const EdgeInsets.all(3.0),
      child: Text(
        "$contenidoTarjeta",
        style: Theme.of(context)
            .textTheme
            .headline5
            .copyWith(fontWeight: FontWeight.w500),
        textAlign: TextAlign.center,
        textScaleFactor: 1.15,
      ),
    );
  }

  Widget tituloDeTarjetaDePortada(String contenidoTarjeta) {
    return Container(
      alignment: Alignment.topCenter,
      height: 38,
      width: MediaQuery.of(context).size.width / 3.7,
      padding: const EdgeInsets.all(3.0),
      child: Container(
        child: Text(
          "$contenidoTarjeta",
          style: Theme.of(context)
              .textTheme
              .headline4
              .copyWith(fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
          textScaleFactor: .52,
        ),
      ),
    );
  }

//RÉCORDS PERSONALES DEBAJO DE LA PORTADA
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
                padding: EdgeInsets.all(6),
                width: MediaQuery.of(context).size.width - 25,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 15),
                        blurRadius: 15,
                        spreadRadius: -5,
                        color: Theme.of(context).backgroundColor,
                      )
                    ],
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).backgroundColor,
                          Theme.of(context).primaryColor,
                        ]),
                    borderRadius: BorderRadius.circular(30)),
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

          Divider(height: 7, thickness: 1, color: Colors.transparent),
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
              height: 10,
              thickness: 1,
              indent: 15,
              endIndent: 10,
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
            Row(
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
                                .copyWith(fontWeight: FontWeight.w400),
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
            Divider(
              height: 10,
              thickness: .8,
              indent: 15,
              endIndent: 10,
            ),
          ],
        ));
      }
    }
    return listaRecordsPersonales;
  }

  Widget etiquetaMedallas() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(6),
          width: MediaQuery.of(context).size.width - 10,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 15),
                  blurRadius: 15,
                  spreadRadius: -5,
                  color: Theme.of(context).backgroundColor,
                )
              ],
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [
                    Theme.of(context).backgroundColor,
                    Theme.of(context).primaryColor,
                  ]),
              borderRadius: BorderRadius.circular(30)),
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
                  blurRadius: 5.0,
                  offset: Offset(-3, -3),
                  color: Colors.white.withOpacity(.7)),
              BoxShadow(
                  blurRadius: 5.0,
                  offset: Offset(3, 3),
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

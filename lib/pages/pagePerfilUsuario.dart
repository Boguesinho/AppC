import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class PerfilUsuario extends StatefulWidget {
  PerfilUsuario({Key key}) : super(key: key);

  @override
  _PerfilUsuarioState createState() => _PerfilUsuarioState();
}

class _PerfilUsuarioState extends State<PerfilUsuario> {
  bool gradienteActivado = true;

  String nombreCuenta = "Max Park";
  String identificadorCuenta = "@maxpark1";
  int cantidadSolves = 29232;

  double mediaSolves = 6.34;
  int categoriaMostrada = 1;
  double recordPersonal = 3.31;

  int cantidadCategorias = 8;

  List<Widget> listaRecordsPersonales = new List<Widget>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Column(
            children: [
              perfilParteSuperior(),
              Divider(
                color: Colors.transparent,
                height: 50,
              ),

              //SEGUNDA SECCIÓN - DEBAJO DE PORTADA
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
          alignment: Alignment.topLeft,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                height: 57,
                color: Colors.transparent,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                                width: MediaQuery.of(context).size.width / 2.1,
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
                              Container(
                                  alignment: Alignment.bottomLeft,
                                  height: 25,
                                  width: 35,
                                  color: Colors.transparent,
                                  child: Image.asset('assets/images/usa.png'))
                            ],
                          ),
                        ],
                      ),
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
      width: MediaQuery.of(context).size.width - 10,
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
          Row(
            children: [
              Expanded(
                child: Container(),
              ),
              Expanded(
                flex: 1,
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
                          textScaleFactor: .75,
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
                          textScaleFactor: .75,
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
                          textScaleFactor: .75,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          Divider(height: 8, thickness: 1),

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
                          flex: 3,
                        ),
                        Expanded(
                          child: Image(
                            image: AssetImage('assets/images/3x3.png'),
                            height: 20,
                            width: 20,
                          ),
                        ),
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
              height: 7,
              thickness: .8,
            ),
          ],
        ));
      }
    }
    return listaRecordsPersonales;
  }
}

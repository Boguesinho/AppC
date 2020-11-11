import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sctproject/DB/dataBaseProvider.dart';
import 'package:sctproject/bloc/tiempos_bloc.dart';
import 'package:sctproject/classes/calculosAvgs.dart';
import 'package:sctproject/classes/spHelper.dart';
import 'package:sctproject/events/setSolve.dart';
import 'package:sctproject/models/solve.dart';

class Historial extends StatefulWidget {
  const Historial({Key key}) : super(key: key);

  @override
  _HistorialState createState() => _HistorialState();
}

class _HistorialState extends State<Historial> {
  bool conClave = false;

  double anchoCampoClave = 0;

  int contadorEmotes = 0;

  bool categoriasInicializadas = false;
  String nombreCategoria = "Rubik's Cube";
  List<Widget> listaCategorias = new List<Widget>();

  List<Solve> listaDeSolves = new List<Solve>();

  bool promediosSeleccionado = false;

  bool botonSeisSeleccionado = false;
  bool botonCincoSeleccionado = false;
  bool botonCuatroSeleccionado = false;
  bool botonTresSeleccioando = false;
  bool botonDosSeleccionado = false;
  bool botonUnoSeleccionado = false;

  //LISTAS PARA USAR CUANDO SE ELIMINA UN ELEMENTO EN EL HISTORIAL
  var begin = Offset(0, 1);
  var end = Offset.zero;
  final sc = new ScrollController();

  double alturaContainer = 155;

  @override
  void initState() {
    super.initState();
    int sesionActual = SPHelper.getInt('sesionSeleccionadaInt');

    //ENVIAR SESIÓN SELECCIONADA COMO PARÁMETRO
    DatabaseProvider.db.getSolves(sesionActual).then(
      (solveList) {
        BlocProvider.of<SolveBloc>(context).add(SetSolve(solveList));
      },
    );
  }

  Widget build(BuildContext context) {
    int cantidadHorizontalElementos = MediaQuery.of(context).size.width ~/ 90;

    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: Theme(
          data: Theme.of(context),
          child: CustomScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Theme.of(context).primaryColor,
                shadowColor: Theme.of(context).backgroundColor,
                leading: Container(
                  width: 50,
                  height: 50,
                  child: Container(),
                ),
                titleSpacing: 0,
                //TITULO, PARTE SUPERIOR DEL HISTORIAL
                title: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            "Historial",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.5,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${SPHelper.getString('sesionSeleccionada')} de ${SPHelper.getInt('sesionSeleccionadaInt')}",
                            textAlign: TextAlign.center,
                            textScaleFactor: 1,
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .copyWith(fontWeight: FontWeight.w900),
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          child: CupertinoButton(
                            padding: EdgeInsets.all(0),
                            child: Icon(Icons.delete_forever,
                                color: Theme.of(context).iconTheme.color),
                            onPressed: () {
                              vibrate();
                              mostrarConfirmacionEliminar(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                pinned: true,

                //ALTURA ZONA DE DATOS
                expandedHeight: 280.0,
                elevation: 20,

                //ZONA DE TIEMPOS SUPERIOR, PROMEDIOS Y DATOS
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      BlocConsumer<SolveBloc, List<Solve>>(
                        builder: (context, solveList) {
                          listaDeSolves = solveList;

                          return Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  width: MediaQuery.of(context).size.width - 35,
                                  padding: EdgeInsets.all(5),
                                  child: Column(
                                    children: [
                                      listaDeSolves.length > 0
                                          ? Column(
                                              //ZONA DE CANTIDAD DE SOLVES
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 7),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Solves",
                                                            textAlign:
                                                                TextAlign.right,
                                                            textScaleFactor: .9,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                          ),
                                                          Text(
                                                            "${listaDeSolves.length}",
                                                            textAlign:
                                                                TextAlign.right,
                                                            textScaleFactor:
                                                                2.8,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .headline5
                                                                .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w900),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Divider(
                                                    color: Colors.transparent),

                                                //ZONA DEL GRADIENTE - MEJOR TIEMPO, AO5, AO100
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    gradient: LinearGradient(
                                                      begin: Alignment.topRight,
                                                      end: Alignment.bottomLeft,
                                                      colors: [
                                                        Theme.of(context)
                                                            .primaryColorDark,
                                                        Theme.of(context)
                                                            .primaryColorLight
                                                      ],
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "Mejor",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textScaleFactor:
                                                                  .9,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "Ao5",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textScaleFactor:
                                                                  .9,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "Ao100",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              textScaleFactor:
                                                                  .9,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Divider(
                                                          color: Colors
                                                              .transparent,
                                                          height: 5),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Expanded(
                                                            child: Text(
                                                              "${listaDeSolves[listaDeSolves.length - 1].tiempo}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${CalculoAvg.getActualAoX(listaDeSolves, 5).toStringAsFixed(2)}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              "${CalculoAvg.getActualAoX(listaDeSolves, 100).toStringAsFixed(2)}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .headline5
                                                                  .copyWith(
                                                                      color: Colors
                                                                          .white,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                    color: Colors.transparent,
                                                    height: 9),

                                                //ZONA DE BOTONES DE OPCIONES DE BÚSQUEDA - EMOTICONES Y FAVORITOS
                                                Row(
                                                  children: [
                                                    //PRIMER BOTÓN
                                                    Expanded(
                                                      child: AnimatedContainer(
                                                        height: 30,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                FractionalOffset
                                                                    .centerRight,
                                                            end:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            colors:
                                                                botonUnoSeleccionado
                                                                    ? [
                                                                        Theme.of(context)
                                                                            .primaryColorDark,
                                                                        Theme.of(context)
                                                                            .primaryColorLight
                                                                      ]
                                                                    : [
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                      ],
                                                          ),
                                                        ),
                                                        child: CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Icon(
                                                            Icons
                                                                .sentiment_very_satisfied,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            vibrate();
                                                            setState(() {
                                                              botonUnoSeleccionado
                                                                  ? botonUnoSeleccionado =
                                                                      false
                                                                  : botonUnoSeleccionado =
                                                                      true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 5),
                                                    //SEGUNDO BOTÓN
                                                    Expanded(
                                                      child: AnimatedContainer(
                                                        height: 30,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                FractionalOffset
                                                                    .centerRight,
                                                            end:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            colors:
                                                                botonDosSeleccionado
                                                                    ? [
                                                                        Theme.of(context)
                                                                            .primaryColorDark,
                                                                        Theme.of(context)
                                                                            .primaryColorLight
                                                                      ]
                                                                    : [
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                      ],
                                                          ),
                                                        ),
                                                        child: CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Icon(
                                                            Icons
                                                                .sentiment_satisfied,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            vibrate();
                                                            setState(() {
                                                              botonDosSeleccionado
                                                                  ? botonDosSeleccionado =
                                                                      false
                                                                  : botonDosSeleccionado =
                                                                      true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 5),

                                                    //TERCER BOTÓN
                                                    Expanded(
                                                      child: AnimatedContainer(
                                                        height: 30,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                FractionalOffset
                                                                    .centerRight,
                                                            end:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            colors:
                                                                botonTresSeleccioando
                                                                    ? [
                                                                        Theme.of(context)
                                                                            .primaryColorDark,
                                                                        Theme.of(context)
                                                                            .primaryColorLight
                                                                      ]
                                                                    : [
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                      ],
                                                          ),
                                                        ),
                                                        child: CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Icon(
                                                            Icons
                                                                .sentiment_neutral,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            vibrate();
                                                            setState(() {
                                                              botonTresSeleccioando
                                                                  ? botonTresSeleccioando =
                                                                      false
                                                                  : botonTresSeleccioando =
                                                                      true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 5),

                                                    //CUARTO BOTÓN
                                                    Expanded(
                                                      child: AnimatedContainer(
                                                        height: 30,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                FractionalOffset
                                                                    .centerRight,
                                                            end:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            colors:
                                                                botonCuatroSeleccionado
                                                                    ? [
                                                                        Theme.of(context)
                                                                            .primaryColorDark,
                                                                        Theme.of(context)
                                                                            .primaryColorLight
                                                                      ]
                                                                    : [
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                      ],
                                                          ),
                                                        ),
                                                        child: CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Icon(
                                                            Icons
                                                                .sentiment_dissatisfied,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            vibrate();
                                                            setState(() {
                                                              botonCuatroSeleccionado
                                                                  ? botonCuatroSeleccionado =
                                                                      false
                                                                  : botonCuatroSeleccionado =
                                                                      true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 5),

                                                    //QUINTO BOTÓN
                                                    Expanded(
                                                      child: AnimatedContainer(
                                                        height: 30,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                FractionalOffset
                                                                    .centerRight,
                                                            end:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            colors:
                                                                botonCincoSeleccionado
                                                                    ? [
                                                                        Theme.of(context)
                                                                            .primaryColorDark,
                                                                        Theme.of(context)
                                                                            .primaryColorLight
                                                                      ]
                                                                    : [
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                      ],
                                                          ),
                                                        ),
                                                        child: CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Icon(
                                                            Icons
                                                                .sentiment_very_dissatisfied,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            vibrate();
                                                            setState(() {
                                                              botonCincoSeleccionado
                                                                  ? botonCincoSeleccionado =
                                                                      false
                                                                  : botonCincoSeleccionado =
                                                                      true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Container(width: 5),

                                                    //SEXTO BOTÓN
                                                    Expanded(
                                                      child: AnimatedContainer(
                                                        height: 30,
                                                        duration: Duration(
                                                            milliseconds: 500),
                                                        curve: Curves.ease,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          gradient:
                                                              LinearGradient(
                                                            begin:
                                                                FractionalOffset
                                                                    .centerRight,
                                                            end:
                                                                FractionalOffset
                                                                    .centerLeft,
                                                            colors:
                                                                botonSeisSeleccionado
                                                                    ? [
                                                                        Theme.of(context)
                                                                            .primaryColorDark,
                                                                        Theme.of(context)
                                                                            .primaryColorLight
                                                                      ]
                                                                    : [
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                        Theme.of(context)
                                                                            .primaryColor,
                                                                      ],
                                                          ),
                                                        ),
                                                        child: CupertinoButton(
                                                          padding:
                                                              EdgeInsets.all(0),
                                                          child: Icon(
                                                            Icons.favorite,
                                                            color: Theme.of(
                                                                    context)
                                                                .iconTheme
                                                                .color,
                                                            size: 22,
                                                          ),
                                                          onPressed: () {
                                                            vibrate();
                                                            setState(() {
                                                              botonSeisSeleccionado
                                                                  ? botonSeisSeleccionado =
                                                                      false
                                                                  : botonSeisSeleccionado =
                                                                      true;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.hourglass_empty,
                                                    size: 35),
                                                Divider(
                                                    color: Colors.transparent),
                                                Center(
                                                  child: Text(
                                                    "Aún no tienes resoluciones.\n ¡Usa el Timer para empezar!",
                                                    textAlign: TextAlign.center,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width - 30,
                                  height: 25,
                                  color: Colors.transparent,
                                ),
                              ],
                            ),
                          );
                        },
                        listener: (BuildContext context, solveList) {},
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<SolveBloc, List<Solve>>(
                builder: (context, solveList) {
                  listaDeSolves = new List<Solve>();
                  listaDeSolves = solveList;

                  //GRIDVIEW DE SOLVES - HISTORIAL

                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: cantidadHorizontalElementos),
                    delegate: SliverChildListDelegate(
                      _getTiles(
                          listaDeSolves, cantidadHorizontalElementos, context),
                    ),
                  );
                },
                listener: (BuildContext context, solveList) {},
              )
            ],
          ),
        ));
  }

  //CONFIRMACIÓN PARA ELIMINAR TODOS
  mostrarConfirmacionEliminar(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context),
        child: AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(1),
          title: Text(
            "Eliminar todo",
            textAlign: TextAlign.center,
            textScaleFactor: 1.2,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w900),
          ),
          content: Text(
            "Esta acción eliminará todos los registros de esta sesión. ¿Desea continuar?",
            textAlign: TextAlign.center,
            textScaleFactor: .9,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                setState(() {
                  DatabaseProvider.db.deleteAll();
                  listaDeSolves.clear();
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Eliminar",
                textAlign: TextAlign.left,
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancelar",
                textAlign: TextAlign.left,
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> vibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }

//OBTENER EL CONTAINER QUE DEBE, DEPENDIENDO DE EL EMOTICON/EMOTE AÑADIDO
  Widget getContainerEmoticon(
      context, cantidadHorizontalElementos, List<Solve> listaS, i) {
    double tiempoMasDos = listaS[i].tiempo + 2.0;
    Color colorContenedor;
    Container iconoContenedor;
    contadorEmotes = listaDeSolves[i].emoticon - 1;
    Color colorLinea;

    if (contadorEmotes > 4) contadorEmotes = 0;

    if (contadorEmotes == 0) {
      colorLinea = Colors.blue.withOpacity(1);
      iconoContenedor = new Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(
              Icons.sentiment_very_satisfied,
              color: Theme.of(context).iconTheme.color.withOpacity(.1),
              size: MediaQuery.of(context).size.width /
                      cantidadHorizontalElementos -
                  13,
            ),
          ],
        ),
      );
    }
    if (contadorEmotes == 1) {
      colorLinea = Colors.green.withOpacity(1);

      iconoContenedor = new Container(
        child: Stack(
          children: [
            Icon(
              Icons.sentiment_satisfied,
              color: Theme.of(context).iconTheme.color.withOpacity(.1),
              size: MediaQuery.of(context).size.width /
                      cantidadHorizontalElementos -
                  13,
            ),
          ],
        ),
      );
    }
    if (contadorEmotes == 2) {
      colorLinea = Colors.yellow.withOpacity(1);

      iconoContenedor = new Container(
        child: Stack(
          children: [
            Icon(
              Icons.sentiment_neutral,
              color: Theme.of(context).iconTheme.color.withOpacity(.1),
              size: MediaQuery.of(context).size.width /
                      cantidadHorizontalElementos -
                  13,
            ),
          ],
        ),
      );
    }
    if (contadorEmotes == 3) {
      colorLinea = Colors.orange.withOpacity(1);

      iconoContenedor = new Container(
        child: Stack(
          children: [
            Icon(
              Icons.sentiment_dissatisfied,
              color: Theme.of(context).iconTheme.color.withOpacity(.1),
              size: MediaQuery.of(context).size.width /
                      cantidadHorizontalElementos -
                  13,
            ),
          ],
        ),
      );
    }
    if (contadorEmotes == 4) {
      colorLinea = Colors.red.withOpacity(1);

      iconoContenedor = new Container(
        child: Stack(
          children: [
            Icon(
              Icons.sentiment_very_dissatisfied,
              color: Theme.of(context).iconTheme.color.withOpacity(.1),
              size: MediaQuery.of(context).size.width /
                      cantidadHorizontalElementos -
                  13,
            ),
          ],
        ),
      );
    }

    return InkResponse(
      enableFeedback: true,
      onTap: () => _onTileClicked(i),
      child: Container(
        decoration: BoxDecoration(
          color: colorContenedor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              child: iconoContenedor,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  listaS[i].dnf == 1
                      ? "DNF"
                      : listaS[i].masdos == 1
                          ? "${tiempoConFormato(tiempoMasDos)}+"
                          : "${tiempoConFormato(listaS[i].tiempo)}",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w800),
                  textScaleFactor: 1.2,
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: colorLinea,
                    ),
                    height: 2.5,
                    width: 1000,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(height: 15, color: Colors.transparent),
              ],
            ),
          ],
        ),
      ),
    );
  }

//DEVOLVER TIEMPO CON FORMATO AL SER > 60 SEGUNDOS
  String tiempoConFormato(double tiempoFormato) {
    int minutos = 0;

    while (tiempoFormato >= 60) {
      minutos++;
      tiempoFormato -= 60;
    }
    return minutos > 0
        ? tiempoFormato < 10
            ? "$minutos:0${tiempoFormato.toStringAsFixed(2)}"
            : "$minutos:${tiempoFormato.toStringAsFixed(2)}"
        : "${tiempoFormato.toStringAsFixed(2)}";
  }

//CONTAINER AL SELECCIONAR UN SOLVE - TIEMPO
  showSolveDialog(BuildContext context, Solve solve, int index, String tiempo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).backgroundColor.withOpacity(1),
        title: Text("$tiempo"),
        content: Container(
          height: 200,
          child: Column(
            children: [
              Text("TIEMPO: ${solve.tiempo}"),
              Text("SCRAMBLE: ${solve.scramble}"),
              Text("MASDOS: ${solve.masdos}"),
              Text("DNF: ${solve.dnf}"),
              Text("FAVORITO: ${solve.favorito}"),
              Text("EMOTICON: ${solve.emoticon}"),
              Text("SESION: ${solve.sesion}"),
              Text("CATEGORIA: ${solve.categoria}"),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              setState(() {
                DatabaseProvider.db.delete(solve.idSolve);
                listaDeSolves.removeAt(index);
                Navigator.pop(context);
              });
            },
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

//PARA LLAMAR AL SER PULSADO EL ELEMENTO DEL GRID
  void _onTileClicked(int index) {
    debugPrint("Solve seleccionado: $index");
    Solve solve = listaDeSolves[index];
    showSolveDialog(
        context, solve, index, listaDeSolves[index].tiempo.toString());
  }

// OBTENER LA LISTA DE TILES / ELEMENTOS DEL GRID

  List<Widget> _getTiles(
      List<Solve> listaS, cantidadHorizontalElementos, context) {
    int indiceHeader = 1;

    final List<Widget> tiles = <Widget>[];

    for (int i = 0; i < listaS.length; i++) {
      tiles.add(
        new GridTile(
          footer: Column(
            children: [
              listaDeSolves[i].favorito == 1
                  ? Icon(Icons.favorite, size: 15, color: Colors.red)
                  : Container(),
              Divider(color: Colors.transparent, height: 12),
            ],
          ),
          header: Container(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              "#$indiceHeader",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(fontWeight: FontWeight.w800),
              textScaleFactor: .6,
              maxLines: 15,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          child: getContainerEmoticon(
              context, cantidadHorizontalElementos, listaS, i),
        ),
      );
      indiceHeader++;
    }

    return tiles.reversed.toList();
  }
}

import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sctproject/classes/informacionSala.dart';

class ElapsedTime {
  final int hundreds;
  final int seconds;
  final int minutes;

  ElapsedTime({
    this.hundreds,
    this.seconds,
    this.minutes,
  });
}

class Dependencies {
  final List<ValueChanged<ElapsedTime>> timerListeners =
      <ValueChanged<ElapsedTime>>[];
  final Stopwatch stopwatch = new Stopwatch();
  final int timerMillisecondsRefreshRate = 30;
}

class Sala extends StatefulWidget {
  InformacionSala _informacionSala = new InformacionSala();
  Sala.constructor(InformacionSala informacionSala) {
    this._informacionSala = informacionSala;
  }

  @override
  SalaState createState() => new SalaState.constructorState(_informacionSala);
}

class SalaState extends State<Sala> {
  InformacionSala _informacionSala = new InformacionSala();
  List<String> listaNombresParticipantes = new List<String>();
  List<double> listaActualParticipantes = new List<double>();
  List<double> listaAo5Participantes = new List<double>();
  List<double> listaMediaParticipantes = new List<double>();

  List<Widget> listaRowsParticipantes = new List<Widget>();

  SalaState.constructorState(InformacionSala informacionSala) {
    this._informacionSala = informacionSala;
  }

  ScrollController _scrollController = new ScrollController();
  final Dependencies dependencies = new Dependencies();
  bool tiempoEnCero = true;
  bool tiempoDetenido = false;
  bool tiempoCorriendo = false;
  bool listoParaEmpezar = true;

  bool mostrarAnimaciones = false;

  TextStyle estiloTexto;

  String scramble =
      "F' R D F2 R' F B L' F' R' B2 U2 L2 U' F2 D' R2 U2 R2 F2 D2";

  String categoriaSeleccionada = "Megaminx";

  String nombrePerfil = "Alejandro Ortega";
  String tiempoActual = "31.15";
  String ao5Actual = "33.55";
  String ao12Actual = "0.0";
  String ao25Actual = "0.0";
  String ao50Actual = "0.0";
  String ao100Actual = "0.0";
  int posicionActual = 12;
  String media = "35.11";

  int _cantidadParticipantes = 13;
  double alturaAnimatedContainer = 63;

  bool contenedorParticipantesExpandido = false;

  void resetTimer() {
    setState(() {
      dependencies.stopwatch.reset();
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
        print("Tiempo Detenido");
      } else {
        dependencies.stopwatch.start();
        print("Tiempo Corriendo");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (event) {
          if (tiempoCorriendo == true &&
              tiempoDetenido == false &&
              tiempoEnCero == false) {
            rightButtonPressed();
            tiempoCorriendo = false;
            tiempoDetenido = true;
            listoParaEmpezar = false;
            mostrarAnimaciones = true;
            if (!dependencies.stopwatch.isRunning) {
              print("${dependencies.stopwatch.elapsed}");
            }
          }
        },
        onTapUp: (event) {
          if (listoParaEmpezar == true &&
              tiempoEnCero == true &&
              tiempoDetenido == false &&
              tiempoCorriendo == false) {
            rightButtonPressed();
            tiempoEnCero = false;
            tiempoCorriendo = true;
            tiempoDetenido = false;
          }
          if (listoParaEmpezar == true &&
              tiempoEnCero == false &&
              tiempoDetenido == true &&
              tiempoCorriendo == false) {
            resetTimer();
            rightButtonPressed();
            tiempoCorriendo = true;
            tiempoDetenido = false;
          }
          if (listoParaEmpezar == false) {
            listoParaEmpezar = true;
          }
        },
        child: Container(
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  !tiempoCorriendo
                      ? FadeInDown(
                          duration: Duration(milliseconds: 500),
                          from: 28,
                          child: topBar(),
                        )
                      : FadeInDownInvert(
                          duration: Duration(milliseconds: 500),
                          from: 28,
                          child: topBar(),
                        ),
                  !tiempoCorriendo
                      ? FadeInDown(
                          duration: Duration(milliseconds: 650),
                          from: 0,
                          child: contenedorScramble(),
                        )
                      : FadeInDownInvert(
                          duration: Duration(milliseconds: 650),
                          from: 0,
                          child: contenedorScramble(),
                        ),
                ],
              ),

              //ZONA DE TIMER E ICONOS
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Divider(
                    height: 20,
                    color: Colors.transparent,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      tiempoDetenido && mostrarAnimaciones
                          ? FadeInUp(
                              duration: Duration(milliseconds: 700),
                              from: 16,
                              child: Container(
                                width: MediaQuery.of(context).size.width - 120,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon:
                                          Icon(Icons.exposure_plus_2, size: 22),
                                      onPressed: () {
                                        print("MÁS DOS");
                                        vibrate();
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.clear, size: 22),
                                      onPressed: () {
                                        print("DNF");
                                        vibrate();
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon:
                                          Icon(Icons.favorite_border, size: 20),
                                      onPressed: () {
                                        print("Favorito");
                                        vibrate();
                                      },
                                    ),
                                  ],
                                ),
                              ))
                          : !tiempoDetenido && mostrarAnimaciones
                              ? FadeInUpInvert(
                                  duration: Duration(milliseconds: 500),
                                  from: 16,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 48,
                                          width: 48,
                                          child: Icon(Icons.exposure_plus_2,
                                              size: 22),
                                        ),
                                        Container(
                                          height: 48,
                                          width: 48,
                                          child: Icon(Icons.clear, size: 22),
                                        ),
                                        Container(
                                          height: 48,
                                          width: 48,
                                          child: Icon(Icons.favorite_border,
                                              size: 20),
                                        ),
                                      ],
                                    ),
                                  ))
                              : Container(),
                      Divider(
                        indent: 60,
                        endIndent: 60,
                        height: 0,
                      ),
                      Stack(
                        children: [
                          new TimerText(dependencies: dependencies),
                        ],
                      ),
                      Divider(
                        indent: 60,
                        endIndent: 60,
                        height: 0,
                      ),
                      tiempoDetenido && mostrarAnimaciones
                          ? Container(
                              width: MediaQuery.of(context).size.width - 120,
                              child: FadeInDown(
                                duration: Duration(milliseconds: 700),
                                from: 16,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.sentiment_very_satisfied,
                                          size: 22),
                                      onPressed: () {
                                        print("Ícono 1");
                                        vibrate();
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.sentiment_satisfied,
                                          size: 22),
                                      onPressed: () {
                                        print("Ícono 2");
                                        vibrate();
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.sentiment_neutral,
                                          size: 22),
                                      onPressed: () {
                                        print("Ícono 3");
                                        vibrate();
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(Icons.sentiment_dissatisfied,
                                          size: 22),
                                      onPressed: () {
                                        print("Ícono 4");
                                        vibrate();
                                      },
                                    ),
                                    IconButton(
                                      padding: EdgeInsets.all(0),
                                      icon: Icon(
                                          Icons.sentiment_very_dissatisfied,
                                          size: 22),
                                      onPressed: () {
                                        print("Ícono 5");
                                        vibrate();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : !tiempoDetenido && mostrarAnimaciones
                              ? Container(
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: FadeInDownInvert(
                                    duration: Duration(milliseconds: 500),
                                    from: 16,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                            height: 48,
                                            width: 48,
                                            child: Icon(
                                                Icons.sentiment_very_satisfied,
                                                size: 22)),
                                        Container(
                                            height: 48,
                                            width: 48,
                                            child: Icon(
                                                Icons.sentiment_satisfied,
                                                size: 22)),
                                        Container(
                                            height: 48,
                                            width: 48,
                                            child: Icon(Icons.sentiment_neutral,
                                                size: 22)),
                                        Container(
                                            height: 48,
                                            width: 48,
                                            child: Icon(
                                                Icons.sentiment_dissatisfied,
                                                size: 22)),
                                        Container(
                                            height: 48,
                                            width: 48,
                                            child: Icon(
                                                Icons
                                                    .sentiment_very_dissatisfied,
                                                size: 22)),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                      Divider(
                        height: 5,
                        color: Colors.transparent,
                      ),
                      //BOTÓN PARA ENVIAR TIEMPO
                      tiempoDetenido && mostrarAnimaciones
                          ? Container(
                              child: FadeInDown(
                              delay: Duration(milliseconds: 0),
                              duration: Duration(milliseconds: 750),
                              from: 0,
                              child: _botonEnviar(),
                            ))
                          : tiempoCorriendo && mostrarAnimaciones
                              ? Container(
                                  child: FadeInDownInvert(
                                  delay: Duration(milliseconds: 0),
                                  duration: Duration(milliseconds: 600),
                                  from: 0,
                                  child: _ocultarBoton(),
                                ))
                              : Container(height: 47),
                    ],
                  ),
                ],
              ),
              !tiempoCorriendo
                  ? FadeInUp(
                      duration: Duration(milliseconds: 550),
                      from: 28,
                      child: contenedorPromedios(),
                    )
                  : FadeInUpInvert(
                      duration: Duration(milliseconds: 550),
                      from: 28,
                      child: contenedorPromedios(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> vibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }

  //ZONA DE SCRAMBLE (SUPERIOR)

  Widget contenedorScramble() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Divider(
          color: Colors.transparent,
          height: 7,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Theme.of(context).backgroundColor.withOpacity(.1),
                ),
                padding: EdgeInsets.all(7),
                width: MediaQuery.of(context).size.width - 40,
                child: Text(
                  "$scramble",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      .copyWith(fontWeight: FontWeight.w400),
                  textScaleFactor: .9,
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                )),
          ],
        ),
      ],
    );
  }

  //MENSAJE DE ENVIAR
  Widget _botonEnviar() {
    return Container(
      child: OutlineButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.transparent,
        child: Container(
          width: 80,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Enviar",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.w700),
                  textScaleFactor: .68,
                ),
              ),
              Container(
                width: 10,
                alignment: Alignment.centerRight,
                child: Icon(Icons.send, size: 15),
              ),
            ],
          ),
        ),
        onPressed: () {
          print('ENVIAR Presionado');
          vibrate();
        },
      ),
    );
  }

  Widget _ocultarBoton() {
    return Container(
      child: OutlineButton(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: Colors.transparent,
        child: Container(
          width: 80,
          child: Row(
            children: [
              Expanded(
                child: Text(
                  "Enviar",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.w700),
                  textScaleFactor: .68,
                ),
              ),
              Container(
                width: 10,
                alignment: Alignment.centerRight,
                child: Icon(Icons.send, size: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

//ZONA DE AVERAGES (INFERIOR)
  Widget contenedorPromedios() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 1, width: 13),
            !tiempoCorriendo
                ? FloatingActionButton(
                    elevation: 0,
                    onPressed: () {
                      print("Floating Chat Presionado");
                      vibrate();
                      _cantidadParticipantes++;
                    },
                    child: Icon(Icons.chat),
                  )
                : FloatingActionButton(
                    elevation: 0,
                    child: Icon(Icons.chat),
                  ),
          ],
        ),
        Container(height: 12, width: 1),
        AnimatedContainer(
          alignment: Alignment.topCenter,
          height: alturaAnimatedContainer,
          width: MediaQuery.of(context).size.width,
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: !contenedorParticipantesExpandido
              ? Column(
                  children: [
                    OutlineButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                      color: Colors.transparent,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Theme.of(context).primaryColor,
                              ),
                              height: 28,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      "Pos",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      textScaleFactor: .67,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Text(
                                      "Nombre",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      textScaleFactor: .67,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Actual",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      textScaleFactor: .67,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Ao5",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      textScaleFactor: .67,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      "Media",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      textScaleFactor: .67,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                                height: 7,
                                color: Colors.transparent,
                                indent: 3,
                                endIndent: 3,
                                thickness: 1.2),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    "$posicionActual",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w400),
                                    textScaleFactor: .55,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "$nombrePerfil",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w400),
                                    textScaleFactor: .55,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "$tiempoActual",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w400),
                                    textScaleFactor: .55,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "$ao5Actual",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w400),
                                    textScaleFactor: .55,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "$media",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w400),
                                    textScaleFactor: .55,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [],
                            ),
                            !contenedorParticipantesExpandido
                                ? Divider(color: Colors.transparent, height: 3)
                                : Container(),
                          ],
                        ),
                      ),
                      onPressed: tiempoCorriendo
                          ? null
                          : () {
                              setState(() {
                                print('Contenedor Maximizado');
                                contenedorParticipantesExpandido
                                    ? contenedorParticipantesExpandido = false
                                    : contenedorParticipantesExpandido = true;

                                _cantidadParticipantes < 11
                                    ? alturaAnimatedContainer +=
                                        (26 * _cantidadParticipantes) - 19
                                    : alturaAnimatedContainer += (26 * 10 - 12);

                                vibrate();
                              });
                            },
                    ),
                  ],
                )
              : Container(
                  child: Column(
                    children: [
                      OutlineButton(
                        onPressed: () {
                          setState(() {
                            print('Contenedor Minimizado');
                            contenedorParticipantesExpandido
                                ? contenedorParticipantesExpandido = false
                                : contenedorParticipantesExpandido = true;
                            alturaAnimatedContainer = 63;
                            vibrate();
                          });
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                        color: Colors.transparent,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Expanded(
                            child: Stack(
                              children: [
                                //MOSTRAR LISTA DE PARTICIPANTES
                                Container(
                                    height: alturaAnimatedContainer - 8,
                                    child: mostrarListaParticipantes()),

                                //PARTE SUPERIOR DE LA LISTA
                                Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  height: 28,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          "Pos",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          textScaleFactor: .67,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Nombre",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          textScaleFactor: .67,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Actual",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          textScaleFactor: .67,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Ao5",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          textScaleFactor: .67,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          "Media",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3
                                              .copyWith(
                                                  fontWeight: FontWeight.w600),
                                          textScaleFactor: .67,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  //MOSTRAR LISTA DE PARTICIPANTES
  Widget mostrarListaParticipantes() {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (context, index) {
        return Container(
          color: Colors.transparent,
          child: Column(
            children: obtenerListaParticipantes(),
          ),
        );
      },
      itemCount: listaNombresParticipantes.length + 1,
    );
  }

  //LISTA DE PARTICIPANTES HECHA
  List<Widget> obtenerListaParticipantes() {
    listaRowsParticipantes.clear();
    //CANTIDAD PARTICIPANTES
    for (int i = 0; i < _cantidadParticipantes; i++) {
      listaRowsParticipantes.add(obtenerRowParticipante(i + 1));
      if (i + 1 != _cantidadParticipantes) {
        listaRowsParticipantes.add(Divider(
          height: 10,
          indent: 8,
          endIndent: 8,
          thickness: 1,
        ));
      } else {
        listaRowsParticipantes.add(Divider(
          height: 10,
          indent: 8,
          endIndent: 8,
          thickness: 1,
          color: Colors.transparent,
        ));
      }
    }
    return listaRowsParticipantes;
  }

  //ROW PARA LISTA DE PARTICIPANTES
  Widget obtenerRowParticipante(int posIndexParticipante) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            "$posIndexParticipante°",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w400),
            textScaleFactor: .55,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            "$nombrePerfil",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w400),
            textScaleFactor: .55,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "$tiempoActual",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w400),
            textScaleFactor: .55,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "$ao5Actual",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w400),
            textScaleFactor: .55,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            "$media",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w400),
            textScaleFactor: .55,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  //BARRA DE NAVEGACION SUPERIOR

  Widget topBar() {
    return Container(
      height: 74,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: tiempoCorriendo
                  ? null
                  : () {
                      print("Volver Presionado");
                      vibrate();
                      Navigator.pop(context);
                    },
            ),
            Expanded(
              child: Text(
                "Jarocholos Retas",
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w600),
                textScaleFactor: .9,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: tiempoCorriendo
                  ? null
                  : () {
                      print("Configuración Presionado");
                      vibrate();
                    },
            ),
          ],
        ),
      ),
    );
  }
}

class TimerText extends StatefulWidget {
  TimerText({this.dependencies});
  final Dependencies dependencies;

  TimerTextState createState() =>
      new TimerTextState(dependencies: dependencies);
}

class TimerTextState extends State<TimerText> {
  TimerTextState({this.dependencies});
  final Dependencies dependencies;
  Timer timer;
  int milliseconds;

  @override
  void initState() {
    timer = new Timer.periodic(
        new Duration(milliseconds: dependencies.timerMillisecondsRefreshRate),
        callback);
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;
    super.dispose();
  }

  void callback(Timer timer) {
    if (milliseconds != dependencies.stopwatch.elapsedMilliseconds) {
      milliseconds = dependencies.stopwatch.elapsedMilliseconds;
      final int hundreds = (milliseconds / 10).truncate();
      final int seconds = (hundreds / 100).truncate();
      final int minutes = (seconds / 60).truncate();
      final ElapsedTime elapsedTime = new ElapsedTime(
        hundreds: hundreds,
        seconds: seconds,
        minutes: minutes,
      );
      for (final listener in dependencies.timerListeners) {
        listener(elapsedTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new RepaintBoundary(
          child: new SizedBox(
            height: 72.0,
            child: new MinutesAndSeconds(dependencies: dependencies),
          ),
        ),
        new RepaintBoundary(
          child: new SizedBox(
            height: 72.0,
            child: new Hundreds(dependencies: dependencies),
          ),
        ),
      ],
    );
  }
}

class MinutesAndSeconds extends StatefulWidget {
  MinutesAndSeconds({this.dependencies});
  final Dependencies dependencies;

  MinutesAndSecondsState createState() =>
      new MinutesAndSecondsState(dependencies: dependencies);
}

class MinutesAndSecondsState extends State<MinutesAndSeconds> {
  MinutesAndSecondsState({this.dependencies});
  final Dependencies dependencies;

  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.minutes != minutes || elapsed.seconds != seconds) {
      setState(() {
        minutes = elapsed.minutes;
        seconds = elapsed.seconds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String minutesStr = (minutes % 60).toString().padLeft(2, '');
    String secondsStr = (seconds % 60).toString().padLeft(2, '');
    bool enMinutos = false;

    if (enMinutos && seconds < 59) {
      enMinutos = false;
      (seconds % 60).toString().padLeft(2, '');
    }

    if (!enMinutos && seconds > 59) {
      enMinutos = true;
      secondsStr = (seconds % 60).toString().padLeft(2, '0');
    }

    if (!enMinutos) {
      return new Text(
        '$secondsStr.',
        style: GoogleFonts.baiJamjuree(fontSize: 55),
      );
    }

    if (enMinutos) {
      return new Text(
        '$minutesStr:$secondsStr.',
        style: GoogleFonts.baiJamjuree(fontSize: 55),
      );
    }
  }
}

class Hundreds extends StatefulWidget {
  Hundreds({this.dependencies});
  final Dependencies dependencies;

  HundredsState createState() => new HundredsState(dependencies: dependencies);
}

class HundredsState extends State<Hundreds> {
  HundredsState({this.dependencies});
  final Dependencies dependencies;

  int hundreds = 0;

  @override
  void initState() {
    dependencies.timerListeners.add(onTick);
    super.initState();
  }

  void onTick(ElapsedTime elapsed) {
    if (elapsed.hundreds != hundreds) {
      setState(() {
        hundreds = elapsed.hundreds;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return new Text(
      hundredsStr,
      style: GoogleFonts.baiJamjuree(fontSize: 55),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    var controlPoint = Offset(size.width / 8, size.height);
    var endPoint = Offset(size.width / 4.5, size.height);

    path.lineTo(0, size.height - 10);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width / .4, size.height);
    path.quadraticBezierTo(
        size.width / 3, endPoint.dy, size.width, size.height - 30);
    //path.lineTo(size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

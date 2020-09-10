import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

class TimerCubo extends StatefulWidget {
  @override
  TimerPageState createState() => new TimerPageState();
}

class TimerPageState extends State<TimerCubo> {
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

  String tiempoActual = "0.0";
  String ao5Actual = "0.0";
  String ao12Actual = "0.0";
  String ao25Actual = "0.0";
  String ao50Actual = "0.0";
  String ao100Actual = "0.0";

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

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
        child: new Text(text, style: roundTextStyle), onPressed: callback);
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
          child: SafeArea(
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Divider(
                      height: 70,
                    ),
                    !tiempoCorriendo
                        ? FadeInDown(
                            duration: Duration(milliseconds: 500),
                            from: 18,
                            child: topNavBar(),
                          )
                        : FadeInDownInvert(
                            duration: Duration(milliseconds: 500),
                            from: 18,
                            child: topNavBar(),
                          ),
                  ],
                ),

                !tiempoCorriendo
                    ? FadeInDown(
                        duration: Duration(milliseconds: 650),
                        from: 0,
                        child: contenedorPromedios(),
                      )
                    : FadeInDownInvert(
                        duration: Duration(milliseconds: 650),
                        from: 0,
                        child: contenedorPromedios(),
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
                                  width:
                                      MediaQuery.of(context).size.width - 120,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.delete_outline,
                                            size: 22),
                                        onPressed: () {
                                          print("ELIMINAR TIEMPO");
                                          vibrate();
                                        },
                                      ),
                                      IconButton(
                                        padding: EdgeInsets.all(0),
                                        icon: Icon(Icons.exposure_plus_2,
                                            size: 22),
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
                                        icon: Icon(Icons.favorite_border,
                                            size: 20),
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
                                      width: MediaQuery.of(context).size.width -
                                          120,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 48,
                                            width: 48,
                                            child: Icon(Icons.delete_outline,
                                                size: 22),
                                          ),
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
                          height: 5,
                        ),
                        Stack(
                          children: [
                            new TimerText(dependencies: dependencies),
                          ],
                        ),
                        Divider(
                          indent: 60,
                          endIndent: 60,
                          height: 5,
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
                                        icon: Icon(
                                            Icons.sentiment_very_satisfied,
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
                                                  Icons
                                                      .sentiment_very_satisfied,
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
                                              child: Icon(
                                                  Icons.sentiment_neutral,
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
                      ],
                    ),
                  ],
                ),
              ],
            ),
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
          height: 60,
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

//ZONA DE AVERAGES (INFERIOR)
  Widget contenedorPromedios() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Divider(
          color: Colors.transparent,
          height: 65,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).backgroundColor.withOpacity(.1),
              ),
              padding: EdgeInsets.all(9),
              width: MediaQuery.of(context).size.width / 3.5,
              child: Column(
                children: [
                  Text("Actual: $tiempoActual",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.w400),
                      textScaleFactor: .65,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text("Ao5: $ao5Actual",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.w400),
                      textScaleFactor: .65,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text("Ao12: $ao12Actual",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.w400),
                      textScaleFactor: .65,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text("Ao25: $ao25Actual",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.w400),
                      textScaleFactor: .65,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text("Ao50: $ao50Actual",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.w400),
                      textScaleFactor: .65,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  Text("Ao100: $ao100Actual",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headline3
                          .copyWith(fontWeight: FontWeight.w400),
                      textScaleFactor: .65,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Theme.of(context).backgroundColor.withOpacity(.1),
              ),
              height: 105,
              width: MediaQuery.of(context).size.width / 2.6,
              child: Column(),
            ),
          ],
        ),
        Divider(color: Colors.transparent, height: 8),
      ],
    );
  }

  //BARRA DE NAVEGACION SUPERIOR

  Widget topNavBar() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
              Theme.of(context).primaryColor,
              Theme.of(context).primaryColor,
            ]),
      ),
      child: Column(
        children: [
          Divider(
            height: 1,
            color: Colors.transparent,
          ),
          Row(
            children: [
              Expanded(
                child: !tiempoCorriendo
                    ? FlatButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          print("FLAT 1");
                          vibrate();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Icon(Icons.history),
                                    Text(
                                      "Historial",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      textScaleFactor: .60,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                flex: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(Icons.history),
                                  Text(
                                    "Historial",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontWeight: FontWeight.w500),
                                    textScaleFactor: .60,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              flex: 10,
                            ),
                          ],
                        ),
                      ),
              ),
              Expanded(
                child: !tiempoCorriendo
                    ? FlatButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          print("FLAT 2");
                          vibrate();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Icon(Icons.timer),
                                    Text(
                                      "$categoriaSeleccionada",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      textScaleFactor: .60,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                flex: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(Icons.timer),
                                  Text(
                                    "$categoriaSeleccionada",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontWeight: FontWeight.w500),
                                    textScaleFactor: .60,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              flex: 10,
                            ),
                          ],
                        ),
                      ),
              ),
              Expanded(
                child: !tiempoCorriendo
                    ? FlatButton(
                        padding: EdgeInsets.all(0),
                        color: Colors.transparent,
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          print("FLAT 3");
                          vibrate();
                        },
                        child: Container(
                          color: Colors.transparent,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Icon(Icons.show_chart),
                                    Text(
                                      "Estadísticas",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          .copyWith(
                                              fontWeight: FontWeight.w500),
                                      textScaleFactor: .60,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                                flex: 10,
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.transparent,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Icon(Icons.show_chart),
                                  Text(
                                    "Estadísticas",
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline3
                                        .copyWith(fontWeight: FontWeight.w500),
                                    textScaleFactor: .60,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              flex: 10,
                            ),
                          ],
                        ),
                      ),
              ),
              Container(
                height: 48,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.topCenter,
                height: 1.2,
                width: MediaQuery.of(context).size.width / 3 - 30,
                color: Colors.grey,
              ),
              Container(
                alignment: Alignment.topCenter,
                height: 1.2,
                width: MediaQuery.of(context).size.width / 3 - 30,
                color: Theme.of(context).accentColor,
              ),
              Container(
                alignment: Alignment.topCenter,
                height: 1.2,
                width: MediaQuery.of(context).size.width / 3 - 40,
                color: Colors.grey,
              ),
            ],
          ),
        ],
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
        style: Theme.of(context)
            .textTheme
            .headline3
            .copyWith(fontWeight: FontWeight.w400),
        textScaleFactor: 3,
      );
    }

    if (enMinutos) {
      return new Text(
        '$minutesStr:$secondsStr.',
        style: Theme.of(context)
            .textTheme
            .headline3
            .copyWith(fontWeight: FontWeight.w400),
        textScaleFactor: 3,
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
      style: Theme.of(context)
          .textTheme
          .headline3
          .copyWith(fontWeight: FontWeight.w400),
      textScaleFactor: 3,
    );
  }
}

import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:like_button/like_button.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sctproject/DB/dataBaseProvider.dart';
import 'package:sctproject/bloc/tiempos_bloc.dart';
import 'package:sctproject/classes/calculosAvgs.dart';
import 'package:sctproject/classes/spHelper.dart';
import 'package:sctproject/events/addSolve.dart';
import 'package:sctproject/events/setSolve.dart';
import 'package:sctproject/models/solve.dart';
import 'package:sctproject/pages/pageCategorias.dart';
import 'package:sctproject/pages/pageHistorial.dart';

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
  String sesionSeleccionadaStr = "";
  String categoriaSeleccionadaStr = "";
  List<Solve> listaSolves = new List<Solve>();

  @override
  void initState() {
    super.initState();
    _obtenerPresets();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _obtenerPresets() async {
    sesionSeleccionadaStr = SPHelper.getString('sesionSeleccionada');
    if (sesionSeleccionadaStr.length < 1) {
      await DatabaseProvider.db.setSesionSeleccionada(1);
      SPHelper.setInt('sesionSeleccionadaInt', 1);
    }

    DatabaseProvider.db
        .getSolvesLimite(SPHelper.getInt('sesionSeleccionadaInt'), 100)
        .then(
      (solveList) {
        BlocProvider.of<SolveBloc>(context).add(SetSolve(solveList));
      },
    );

    setState(() {
      sesionSeleccionadaStr = SPHelper.getString('sesionSeleccionada');
      categoriaSeleccionadaStr = SPHelper.getString('categoriaSeleccionada');
    });
  }

  final Dependencies dependencies = new Dependencies();

  bool tiempoEnCero = true;
  bool tiempoDetenido = false;
  bool tiempoCorriendo = false;
  bool listoParaEmpezar = true;

  bool mostrarAnimaciones = false;

  TextStyle estiloTexto;

  int emoticonSeleccionado = 0;
  bool favoritoSeleccionado = false;
  bool eliminarSeleccionado = false;
  bool masDosSeleccionado = false;
  bool dnfSeleccionado = false;

  double ultimoTiempo = 0.0;

  String scramble =
      "F' R D F2 R' F B L' F' R' B2 U2 L2 U' F2 D' R2 U2 R2 F2 D2 L2 U' F2 D' R2 U2 R2 F2 D2";

  String tiempoActual = "0.0";
  String ao5Actual = "0.0";
  String ao12Actual = "0.0";
  String ao25Actual = "0.0";
  String ao50Actual = "0.0";
  String ao100Actual = "0.0";

  Solve solveBuffer;

  void resetTimer() {
    setState(() {
      dependencies.stopwatch.reset();
    });
  }

  void rightButtonPressed() {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
        favoritoSeleccionado = false;
        eliminarSeleccionado = false;
        masDosSeleccionado = false;
        dnfSeleccionado = false;
      } else {
        dependencies.stopwatch.start();
        print("Tiempo Corriendo");
      }
    });
  }

  gestoDetenerTimer() {
    !tiempoCorriendo ? print("INICIO 1") : () {};
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
        emoticonSeleccionado = 3;
      } else {
        emoticonSeleccionado = 0;
      }

      //INSERTAR DATOS DEL TIEMPO EN LA BASE DE DATOS
      String tareaEnString = "";

      //CÁLCULOS PARA CREAR EL TIEMPO EN STRING
      if (dependencies.stopwatch.elapsed.inMilliseconds.toString().length ==
          2) {
        tareaEnString =
            ("0.0${dependencies.stopwatch.elapsed.inMilliseconds.toString()[0]}");
      }
      if (dependencies.stopwatch.elapsed.inMilliseconds.toString().length ==
          3) {
        tareaEnString =
            ("0.${dependencies.stopwatch.elapsed.inMilliseconds.toString()[0]}${dependencies.stopwatch.elapsed.inMilliseconds.toString()[1]}");
      }
      if (dependencies.stopwatch.elapsed.inMilliseconds.toString().length > 3) {
        for (int i = 0;
            i <
                dependencies.stopwatch.elapsed.inMilliseconds
                        .toString()
                        .length -
                    3;
            i++) {
          tareaEnString +=
              ("${dependencies.stopwatch.elapsed.inMilliseconds.toString()[i]}");
        }
        tareaEnString +=
            (".${dependencies.stopwatch.elapsed.inMilliseconds.toString()[dependencies.stopwatch.elapsed.inMilliseconds.toString().length - 3]}");
        tareaEnString +=
            ("${dependencies.stopwatch.elapsed.inMilliseconds.toString()[dependencies.stopwatch.elapsed.inMilliseconds.toString().length - 2]}");
      }

      //AGREGAR TIEMPO A DOUBLE Y A BASE DE DATOS
      double tiempoDouble = double.parse(tareaEnString);

      Solve solve = Solve(
        tiempo: tiempoDouble,
        scramble: "SCRAM",
        masdos: 0,
        dnf: 0,
        favorito: 0,
        emoticon: 3,
        sesion: SPHelper.getInt('sesionSeleccionadaInt'),
        categoria: 1,
      );

      solveBuffer = solve;
      ultimoTiempo = tiempoDouble + 2.0;

      DatabaseProvider.db.insert(solve).then(
            (storedSolve) => BlocProvider.of<SolveBloc>(context).add(
              AddSolve(storedSolve),
            ),
          );

      //SETEAR MEJOR TIEMPOS
      double singleGetter = SPHelper.getDouble('mejorSingle');
      if (!(SPHelper.getDouble('mejorSingle') > 0)) {
        print("PROBLEMA ER33 EN GETTER\nBUSCAR SINGLE BEST INDIVIDUALMENTE");
      }
      if (solveBuffer.tiempo < singleGetter) {
        SPHelper.setDouble('mejorSingle', solveBuffer.tiempo);
      }
    }
  }

  //BOTÓN DE PAUSA

  Widget buildFloatingButton(String text, VoidCallback callback) {
    TextStyle roundTextStyle =
        const TextStyle(fontSize: 16.0, color: Colors.white);
    return new FloatingActionButton(
        child: new Text(text, style: roundTextStyle), onPressed: callback);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,

      //DETECTOR DE GESTOS - CONDICIONES PARA INICIOS Y ALTOS
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTapDown: (event) {
          gestoDetenerTimer();
        },
        onTapUp: (event) {
          print("ON TAP UP");
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
            emoticonSeleccionado = 0;
          }
          if (listoParaEmpezar == false) {
            listoParaEmpezar = true;
          }
        },
        onPanStart: (event) {
          gestoDetenerTimer();
        },
        onPanEnd: (event) {
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
            emoticonSeleccionado = 0;
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
                  ],
                ),

                !tiempoCorriendo
                    ? FadeInUp(
                        delay: Duration(milliseconds: 100),
                        duration: Duration(milliseconds: 650),
                        from: 30,
                        child: contenedorPromedios(),
                      )
                    : FadeInUpInvert(
                        duration: Duration(milliseconds: 650),
                        from: 30,
                        child: contenedorPromedios(),
                      ),

                !tiempoCorriendo
                    ? FadeInDown(
                        delay: Duration(milliseconds: 100),
                        duration: Duration(milliseconds: 650),
                        from: 30,
                        child: contenedorScramble(),
                      )
                    : FadeInDownInvert(
                        duration: Duration(milliseconds: 650),
                        from: 30,
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
                        Container(
                          height: 32,
                          width: MediaQuery.of(context).size.width - 120,
                          color: Colors.transparent,
                          child: Row(
                            children: [
                              //SUPERIOR ICONO 1
                              tiempoDetenido && mostrarAnimaciones
                                  ? Expanded(
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 500),
                                        from: 15,
                                        child: LikeButton(
                                          size: 22,
                                          circleColor: CircleColor(
                                            start: Colors.white,
                                            end: Colors.black,
                                          ),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.black,
                                            dotSecondaryColor: Colors.red,
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? eliminarSeleccionado
                                                      ? Icons.restore_from_trash
                                                      : Icons.delete_outline
                                                  : eliminarSeleccionado
                                                      ? Icons.restore_from_trash
                                                      : Icons.delete_outline,
                                              color: isLiked
                                                  ? eliminarSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color
                                                  : eliminarSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                              size: 22,
                                            );
                                          },
                                          onTap: (isLiked) {
                                            setState(() {});
                                            !eliminarSeleccionado
                                                ? DatabaseProvider.db
                                                    .deleteLast()
                                                : DatabaseProvider.db
                                                    .insert(solveBuffer)
                                                    .then(
                                                      (storedSolve) =>
                                                          BlocProvider.of<
                                                                      SolveBloc>(
                                                                  context)
                                                              .add(
                                                        AddSolve(storedSolve),
                                                      ),
                                                    );

                                            !eliminarSeleccionado
                                                ? listaSolves.removeLast()
                                                : null;

                                            return eliminarOprimido(isLiked);
                                          },
                                        ),
                                      ),
                                    )
                                  : !tiempoDetenido && mostrarAnimaciones
                                      ? Expanded(
                                          child: FadeInUpInvert(
                                            duration:
                                                Duration(milliseconds: 500),
                                            from: 15,
                                            child: Icon(
                                              eliminarSeleccionado
                                                  ? Icons.restore_from_trash
                                                  : Icons.delete_outline,
                                              color: eliminarSeleccionado
                                                  ? Colors.red
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      : Container(),
                              //SUPERIOR ICONO 2
                              tiempoDetenido &&
                                      mostrarAnimaciones &&
                                      !eliminarSeleccionado
                                  ? Expanded(
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 500),
                                        from: 15,
                                        child: LikeButton(
                                          size: 22,
                                          circleColor: CircleColor(
                                            start: Colors.white,
                                            end: Colors.black,
                                          ),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.black,
                                            dotSecondaryColor: Colors.white,
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? masDosSeleccionado
                                                      ? Icons.exposure_plus_2
                                                      : MdiIcons.layersPlus
                                                  : masDosSeleccionado
                                                      ? Icons.exposure_plus_2
                                                      : MdiIcons.layersPlus,
                                              color: isLiked
                                                  ? masDosSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color
                                                  : masDosSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                              size: 22,
                                            );
                                          },
                                          onTap: (isLiked) {
                                            setState(() {});
                                            return masDosOprimido(isLiked);
                                          },
                                        ),
                                      ),
                                    )
                                  : !tiempoDetenido && mostrarAnimaciones ||
                                          eliminarSeleccionado
                                      ? Expanded(
                                          child: FadeInUpInvert(
                                            duration:
                                                Duration(milliseconds: 500),
                                            from: 15,
                                            child: Icon(
                                              masDosSeleccionado
                                                  ? Icons.exposure_plus_2
                                                  : MdiIcons.layersPlus,
                                              color: masDosSeleccionado
                                                  ? Colors.red
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      : Container(),
                              //SUPERIOR ICONO 3
                              tiempoDetenido &&
                                      mostrarAnimaciones &&
                                      !eliminarSeleccionado
                                  ? Expanded(
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 500),
                                        from: 15,
                                        child: LikeButton(
                                          size: 22,
                                          circleColor: CircleColor(
                                            start: Colors.white,
                                            end: Colors.black,
                                          ),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.black,
                                            dotSecondaryColor: Colors.white,
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? dnfSeleccionado
                                                      ? MdiIcons.cubeOffOutline
                                                      : MdiIcons.layersRemove
                                                  : dnfSeleccionado
                                                      ? MdiIcons.cubeOffOutline
                                                      : MdiIcons.layersRemove,
                                              color: isLiked
                                                  ? dnfSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color
                                                  : dnfSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                              size: 22,
                                            );
                                          },
                                          onTap: (isLiked) {
                                            setState(() {});
                                            return dnfOprimido(isLiked);
                                          },
                                        ),
                                      ),
                                    )
                                  : !tiempoDetenido && mostrarAnimaciones ||
                                          eliminarSeleccionado
                                      ? Expanded(
                                          child: FadeInUpInvert(
                                            duration:
                                                Duration(milliseconds: 500),
                                            from: 15,
                                            child: Icon(
                                              dnfSeleccionado
                                                  ? MdiIcons.cubeOffOutline
                                                  : MdiIcons.layersRemove,
                                              color: dnfSeleccionado
                                                  ? Colors.red
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      : Container(),
                              //SUPERIOR ICONO 4
                              tiempoDetenido &&
                                      mostrarAnimaciones &&
                                      !eliminarSeleccionado
                                  ? Expanded(
                                      child: FadeInUp(
                                        duration: Duration(milliseconds: 500),
                                        from: 15,
                                        child: LikeButton(
                                          size: 22,
                                          circleColor: CircleColor(
                                            start: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            end: Colors.red,
                                          ),
                                          bubblesColor: BubblesColor(
                                            dotPrimaryColor: Colors.red,
                                            dotSecondaryColor: Colors.white,
                                          ),
                                          likeBuilder: (bool isLiked) {
                                            return Icon(
                                              isLiked
                                                  ? favoritoSeleccionado
                                                      ? Icons.favorite
                                                      : Icons.favorite_border
                                                  : favoritoSeleccionado
                                                      ? Icons.favorite
                                                      : Icons.favorite_border,
                                              color: isLiked
                                                  ? favoritoSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color
                                                  : favoritoSeleccionado
                                                      ? Colors.red
                                                      : Theme.of(context)
                                                          .iconTheme
                                                          .color,
                                              size: 22,
                                            );
                                          },
                                          onTap: (isLiked) {
                                            return favoritoOprimido(isLiked);
                                          },
                                        ),
                                      ),
                                    )
                                  : !tiempoDetenido && mostrarAnimaciones ||
                                          eliminarSeleccionado
                                      ? Expanded(
                                          child: FadeInUpInvert(
                                            duration:
                                                Duration(milliseconds: 500),
                                            from: 15,
                                            child: Icon(
                                              favoritoSeleccionado
                                                  ? Icons.favorite
                                                  : Icons.favorite_border,
                                              color: favoritoSeleccionado
                                                  ? Colors.red
                                                  : Theme.of(context)
                                                      .iconTheme
                                                      .color,
                                              size: 22,
                                            ),
                                          ),
                                        )
                                      : Container(),
                            ],
                          ),
                        ),

                        Divider(
                          indent: 60,
                          endIndent: 60,
                          height: 15,
                          color:
                              Theme.of(context).iconTheme.color.withOpacity(.4),
                        ),

                        //TIMER - CRONÓMETRO - TIEMPO
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            dnfSeleccionado &&
                                    tiempoDetenido &&
                                    !eliminarSeleccionado
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'DNF',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 3.3,
                                        maxLines: 2,
                                      ),
                                    ],
                                  )
                                : Container(),
                            masDosSeleccionado &&
                                    tiempoDetenido &&
                                    !eliminarSeleccionado
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        tiempoConFormato().split(".")[0],
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 3.6,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        ".${tiempoConFormato().split(".")[1]}",
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 3.3,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        " +",
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 2,
                                        maxLines: 2,
                                      ),
                                    ],
                                  )
                                : Container(),
                            eliminarSeleccionado && tiempoDetenido
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '0.',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 3.6,
                                        maxLines: 2,
                                      ),
                                      Text(
                                        '00',
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 3.3,
                                        maxLines: 2,
                                      ),
                                    ],
                                  )
                                : Container(),
                            Opacity(
                              opacity: eliminarSeleccionado && tiempoDetenido ||
                                      dnfSeleccionado && tiempoDetenido ||
                                      masDosSeleccionado && tiempoDetenido ||
                                      tiempoEnCero
                                  ? 0
                                  : 1.0,
                              child: TimerText(dependencies: dependencies),
                            ),
                            tiempoEnCero
                                ? FadeIn(
                                    delay: Duration(milliseconds: 50),
                                    duration: Duration(milliseconds: 1000),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '0.',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 3.6,
                                          maxLines: 2,
                                        ),
                                        Text(
                                          '00',
                                          textAlign: TextAlign.center,
                                          textScaleFactor: 3.3,
                                          maxLines: 2,
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(),
                          ],
                        ),

                        Divider(
                          indent: 60,
                          endIndent: 60,
                          height: 15,
                          color:
                              Theme.of(context).iconTheme.color.withOpacity(.4),
                        ),
                        Container(
                            color: Colors.transparent,
                            width: 1,
                            height: mostrarAnimaciones ? 0 : 32),
                        tiempoDetenido &&
                                mostrarAnimaciones &&
                                !eliminarSeleccionado
                            ? Container(
                                height: 32,
                                width: MediaQuery.of(context).size.width - 120,
                                color: Colors.transparent,
                                child: FadeInDown(
                                  duration: Duration(milliseconds: 500),
                                  from: 15,
                                  child: Row(
                                    children: [
                                      //EMOTICON ICONO 1
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                              Icons.sentiment_very_satisfied,
                                              size: 22),
                                          onPressed: () {
                                            print("Emoticon 1");
                                            vibrate();
                                            setState(() {
                                              emoticonSeleccionado = 1;
                                              DatabaseProvider.db
                                                  .updateEmoticon(1);
                                              solveBuffer.emoticon = 1;
                                            });
                                          },
                                        ),
                                      ),
                                      //EMOTICON ICONO 2
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(Icons.sentiment_satisfied,
                                              size: 22),
                                          onPressed: () {
                                            print("Emoticon 2");
                                            vibrate();
                                            setState(() {
                                              emoticonSeleccionado = 2;
                                              DatabaseProvider.db
                                                  .updateEmoticon(2);
                                              solveBuffer.emoticon = 2;
                                            });
                                          },
                                        ),
                                      ),
                                      //EMOTICON ICONO 3
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(Icons.sentiment_neutral,
                                              size: 22),
                                          onPressed: () {
                                            print("Emoticon 3");
                                            vibrate();
                                            setState(() {
                                              emoticonSeleccionado = 3;
                                              DatabaseProvider.db
                                                  .updateEmoticon(3);
                                              solveBuffer.emoticon = 3;
                                            });
                                          },
                                        ),
                                      ),
                                      //EMOTICON ICONO 4
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                              Icons.sentiment_dissatisfied,
                                              size: 22),
                                          onPressed: () {
                                            print("Emoticon 4");
                                            vibrate();
                                            setState(() {
                                              emoticonSeleccionado = 4;
                                              DatabaseProvider.db
                                                  .updateEmoticon(4);
                                              solveBuffer.emoticon = 4;
                                            });
                                          },
                                        ),
                                      ),
                                      //EMOTICON ICONO 5
                                      Expanded(
                                        child: IconButton(
                                          padding: EdgeInsets.all(0),
                                          icon: Icon(
                                              Icons.sentiment_very_dissatisfied,
                                              size: 22),
                                          onPressed: () {
                                            print("Emoticon 5");
                                            vibrate();
                                            setState(() {
                                              emoticonSeleccionado = 5;
                                              DatabaseProvider.db
                                                  .updateEmoticon(5);
                                              solveBuffer.emoticon = 5;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : !tiempoDetenido && mostrarAnimaciones ||
                                    mostrarAnimaciones && eliminarSeleccionado
                                ? Container(
                                    height: 32,
                                    width:
                                        MediaQuery.of(context).size.width - 120,
                                    color: Colors.transparent,
                                    child: FadeInDownInvert(
                                      duration: Duration(milliseconds: 500),
                                      from: 15,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(
                                                Icons.sentiment_very_satisfied,
                                                size: 22,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(
                                                Icons.sentiment_satisfied,
                                                size: 22,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(
                                                Icons.sentiment_neutral,
                                                size: 22,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(
                                                Icons.sentiment_dissatisfied,
                                                size: 22,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                          Expanded(
                                            child: IconButton(
                                              padding: EdgeInsets.all(0),
                                              icon: Icon(
                                                Icons
                                                    .sentiment_very_dissatisfied,
                                                size: 22,
                                                color: Theme.of(context)
                                                    .iconTheme
                                                    .color,
                                              ),
                                              onPressed: null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Container(),

                        //CONTENEDORES/INDICADORES DE SELECCION DE EMOTICON
                        Container(
                          width: MediaQuery.of(context).size.width - 120,
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                        width: 22, color: Colors.transparent),
                                    AnimatedContainer(
                                      height: 3,
                                      width: emoticonSeleccionado == 1
                                          ? eliminarSeleccionado ? 0 : 35
                                          : 0,
                                      duration: Duration(milliseconds: 300),
                                      curve: emoticonSeleccionado == 1
                                          ? Curves.linear
                                          : Curves.linear,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                        width: 22, color: Colors.transparent),
                                    AnimatedContainer(
                                      height: 3,
                                      width: emoticonSeleccionado == 2
                                          ? eliminarSeleccionado ? 0 : 35
                                          : 0,
                                      duration: Duration(milliseconds: 300),
                                      curve: emoticonSeleccionado == 2
                                          ? Curves.linear
                                          : Curves.linear,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                        width: 22, color: Colors.transparent),
                                    AnimatedContainer(
                                      height: 3,
                                      width: emoticonSeleccionado == 3
                                          ? eliminarSeleccionado ? 0 : 35
                                          : 0,
                                      duration: Duration(milliseconds: 300),
                                      curve: emoticonSeleccionado == 3
                                          ? Curves.linear
                                          : Curves.linear,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color:
                                            Colors.yellow[600].withOpacity(.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                        width: 22, color: Colors.transparent),
                                    AnimatedContainer(
                                      height: 3,
                                      width: emoticonSeleccionado == 4
                                          ? eliminarSeleccionado ? 0 : 35
                                          : 0,
                                      duration: Duration(milliseconds: 300),
                                      curve: emoticonSeleccionado == 4
                                          ? Curves.linear
                                          : Curves.linear,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: Colors.orange.withOpacity(.9),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Container(
                                        width: 22, color: Colors.transparent),
                                    AnimatedContainer(
                                      height: 3,
                                      width: emoticonSeleccionado == 5
                                          ? eliminarSeleccionado ? 0 : 35
                                          : 0,
                                      duration: Duration(milliseconds: 300),
                                      curve: emoticonSeleccionado == 5
                                          ? Curves.linear
                                          : Curves.linear,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

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

  //DEVOLVER TIEMPO CON FORMATO AL SER > 60 SEGUNDOS
  String tiempoConFormato() {
    int minutos = 0;
    double tiempoFormato = ultimoTiempo;

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

  //BOTON FAVORITO OPRIMIDO
  Future<bool> favoritoOprimido(bool isLiked) async {
    vibrate();
    favoritoSeleccionado
        ? favoritoSeleccionado = false
        : favoritoSeleccionado = true;
    DatabaseProvider.db.updateFavorito(favoritoSeleccionado);
    solveBuffer.favorito = favoritoSeleccionado ? 1 : 0;

    return !isLiked;
  }

  //BOTON ELIMINAR OPRIMIDO
  Future<bool> eliminarOprimido(bool isLiked) async {
    vibrate();
    eliminarSeleccionado
        ? eliminarSeleccionado = false
        : eliminarSeleccionado = true;
    return !isLiked;
  }

  //BOTON MAS DOS OPRIMIDO
  Future<bool> masDosOprimido(bool isLiked) async {
    vibrate();
    masDosSeleccionado ? masDosSeleccionado = false : masDosSeleccionado = true;
    DatabaseProvider.db.updateMasDos(masDosSeleccionado);
    solveBuffer.masdos = masDosSeleccionado ? 1 : 0;

    dnfSeleccionado = false;
    DatabaseProvider.db.updateDnf(false);
    solveBuffer.dnf = 0;

    return !isLiked;
  }

  //BOTON DNF OPRIMIDO
  Future<bool> dnfOprimido(bool isLiked) async {
    vibrate();
    dnfSeleccionado ? dnfSeleccionado = false : dnfSeleccionado = true;
    DatabaseProvider.db.updateDnf(dnfSeleccionado);
    solveBuffer.dnf = dnfSeleccionado ? 1 : 0;

    masDosSeleccionado = false;
    DatabaseProvider.db.updateMasDos(false);
    solveBuffer.masdos = 0;

    return !isLiked;
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
          height: 0,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).primaryColorDark,
                Theme.of(context).primaryColorLight
              ],
            ),
          ),
          width: MediaQuery.of(context).size.width - 20,
          child: FlatButton(
            onPressed: tiempoCorriendo
                ? null
                : () {
                    vibrate();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Categorias()),
                    ).then((value) {
                      _obtenerPresets();
                      setState(() {});
                    });
                  },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "$categoriaSeleccionadaStr",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headline4
                      .copyWith(fontWeight: FontWeight.w900),
                  textScaleFactor: .58,
                  maxLines: 15,
                  overflow: TextOverflow.ellipsis,
                ),
                Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.transparent,
                ),
                Container(
                  alignment: Alignment.center,
                  height: 17,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "$sesionSeleccionadaStr",
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .copyWith(fontWeight: FontWeight.w500),
                        textScaleFactor: .5,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Icon(Icons.arrow_drop_down,
                          size: 15, color: Theme.of(context).iconTheme.color),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 18, vertical: 5),
          child: Text(
            "$scramble",
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(fontWeight: FontWeight.w500),
            textScaleFactor: .65,
            maxLines: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

//ZONA DE AVERAGES (INFERIOR)
  Widget contenedorPromedios() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).primaryColorDark,
                  Theme.of(context).primaryColorLight
                ],
              ),
              borderRadius: BorderRadius.circular(15.0),
            ),
            width: MediaQuery.of(context).size.width - 15,
            child: FlatButton(
              onPressed: null,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 7),
              color: Colors.transparent,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text("Mejor",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .55,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("Ao5",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .55,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("Ao12",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .55,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("Ao50",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .55,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("Ao100",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .55,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                  Divider(
                    height: 5,
                    indent: 5,
                    endIndent: 5,
                    thickness: .9,
                    color: Theme.of(context).iconTheme.color.withOpacity(.4),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text("${SPHelper.getDouble('mejorSingle')}",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .45,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("$ao5Actual",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .45,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("$ao12Actual",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .45,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: Text("$ao50Actual",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w600),
                            textScaleFactor: .45,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Expanded(
                        child: BlocConsumer<SolveBloc, List<Solve>>(
                            listener: (BuildContext context, solveList) {},
                            builder: (context, solveList) {
                              listaSolves = solveList;

                              return Text("${listaSolves.length}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(fontWeight: FontWeight.w600),
                                  textScaleFactor: .45,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mostrarMensajeInicio() {
    return Container();
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
                                    Icon(Icons.history,
                                        color:
                                            Theme.of(context).iconTheme.color),
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
                                    Icon(Icons.timer,
                                        color:
                                            Theme.of(context).iconTheme.color),
                                    Text(
                                      "$categoriaSeleccionadaStr",
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
                                    "$categoriaSeleccionadaStr",
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
                                    Icon(Icons.show_chart,
                                        color:
                                            Theme.of(context).iconTheme.color),
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
      return new Center(
        child: Text(
          '$secondsStr.',
          textAlign: TextAlign.center,
          textScaleFactor: 3.6,
          maxLines: 2,
        ),
      );
    }

    if (enMinutos) {
      return new Center(
        child: Text(
          '$minutesStr:$secondsStr.',
          textAlign: TextAlign.center,
          textScaleFactor: 3.6,
          maxLines: 2,
        ),
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

    return new Center(
      child: Text(
        '$hundredsStr',
        textAlign: TextAlign.center,
        textScaleFactor: 3.3,
        maxLines: 2,
      ),
    );
  }
}

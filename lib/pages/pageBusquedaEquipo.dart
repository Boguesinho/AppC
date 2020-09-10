import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:sctproject/classes/informacionEquipo.dart';
import 'package:sctproject/pages/pageCreacionSala.dart';

class BusquedaEquipo extends StatefulWidget {
  BusquedaEquipo({Key key}) : super(key: key);

  InformacionEquipo _informacionEquipo = new InformacionEquipo();
  BusquedaEquipo.constructor(InformacionEquipo informacionEquipo) {
    this._informacionEquipo = informacionEquipo;
  }

  @override
  _busquedaEquipoState createState() =>
      _busquedaEquipoState.constructorState(_informacionEquipo);
}

class _busquedaEquipoState extends State<BusquedaEquipo> {
  InformacionEquipo _informacionEquipo = new InformacionEquipo();

  _busquedaEquipoState.constructorState(InformacionEquipo informacionEquipo) {
    this._informacionEquipo = informacionEquipo;
  }

  Future _futureSalas;
  final scrollController = new ScrollController();
  final sc = new ScrollController();

  List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    myList = List.generate(10, (i) => "Item : ${i + 1}");

    _futureSalas = getEquipos();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _futureSalas = _getMoreData();
      }
    });
  }

  String fechaCreacion = "01/09/2020";
  String paisEquipo = "México";
  String nombreEquipo = "GAN Team";
  String descripcionEquipo = "Descripción del equipo en cuestión";
  List<Widget> listaSalas;

  int salaSeleccionada = -1;
  bool tieneClave = true;

  bool gradienteActivado = true;

  double busquedaEscalaHorizontal = 45;
  double busquedaEscalaVertical = 45;
  bool opcionesBusquedaMaximizado = false;
  bool agregandoSala = false;

  _getMoreData() {
    _futureSalas = getEquipos();
    for (int i = _currentMax; i < _currentMax + 10; i++) {
      myList.add("Item : ${i + 1}");
    }

    _currentMax = _currentMax + 10;

    _futureSalas.whenComplete(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          gradienteActivado
              ? Container(
                  color: Theme.of(context).primaryColor,
                )
              : Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
          ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                      Theme.of(context).backgroundColor,
                      Theme.of(context).primaryColor
                    ])),
              )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                  ),
                  Divider(
                    color: Color(0x00EBEBEB),
                    height: 25.0,
                  ),
                  FadeInDown(
                    duration: Duration(milliseconds: 1000),
                    delay: Duration(milliseconds: 0),
                    child: Text(
                      "Equipos",
                      textScaleFactor: 1.3,
                      style: Theme.of(context)
                          .textTheme
                          .headline4
                          .copyWith(fontWeight: FontWeight.w900),
                    ),
                  ),
                  Divider(
                    color: Color(0x00123456),
                  ),
                  //Search Bar
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      FadeIn(
                        delay: Duration(milliseconds: 0),
                        duration: Duration(milliseconds: 500),
                        child: AnimatedContainer(
                          alignment: Alignment.topLeft,
                          duration: Duration(milliseconds: 350),
                          curve: Curves.ease,
                          width: opcionesBusquedaMaximizado
                              ? busquedaEscalaHorizontal =
                                  busquedaEscalaHorizontal = .1
                              : MediaQuery.of(context).size.width - 88,
                          height: opcionesBusquedaMaximizado ? .1 : 45,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                          decoration: BoxDecoration(
                              color: Theme.of(context).tabBarTheme.labelColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: TextField(
                              decoration: InputDecoration(
                            icon: Icon(Icons.search),
                            hintText: "Buscar salas",
                            border: InputBorder.none,
                          )),
                        ),
                      ),
                      Divider(
                        indent: 5,
                      ),
                      FadeIn(
                        delay: Duration(milliseconds: 0),
                        duration: Duration(milliseconds: 500),
                        child: AnimatedContainer(
                          alignment: Alignment.topRight,
                          duration: Duration(milliseconds: 350),
                          curve: Curves.ease,
                          height: busquedaEscalaVertical,
                          width: opcionesBusquedaMaximizado
                              ? MediaQuery.of(context).size.width - 42
                              : 45,
                          color: Colors.transparent,
                          child: mostrarBusquedaAvanzada(),
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    color: Color(0x00EBEBEB),
                    height: 38,
                  ),
                  Text(
                    "Equipos recomendados",
                    textScaleFactor: 1.3,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  Divider(
                    color: Color(0x00EBEBEB),
                    height: 18,
                  ),

                  //FUTURE BUILDER PARA INFORMACIÓN DE SALAS
                  Expanded(
                    child: FutureBuilder(
                        future: _futureSalas,
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
                            return mostrarSalas();
                          }
                        }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 15,
        backgroundColor: Theme.of(context).buttonColor,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        onPressed: () {
          vibrate();
          _showOverlay(context);
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
    );
  }

  Widget mostrarBusquedaAvanzada() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (!opcionesBusquedaMaximizado) {
            setState(() {
              busquedaEscalaHorizontal == 45
                  ? busquedaEscalaHorizontal =
                      MediaQuery.of(context).size.width - 90
                  : busquedaEscalaHorizontal = 45;

              busquedaEscalaVertical == 45
                  ? busquedaEscalaVertical = 155
                  : busquedaEscalaVertical = 45;

              opcionesBusquedaMaximizado
                  ? opcionesBusquedaMaximizado = false
                  : opcionesBusquedaMaximizado = true;
            });
          }
        },
        child: Container(
          padding: opcionesBusquedaMaximizado
              ? EdgeInsets.symmetric(horizontal: 0, vertical: 0)
              : EdgeInsets.symmetric(horizontal: 12, vertical: 11),
          decoration: BoxDecoration(
              color: Theme.of(context).tabBarTheme.labelColor,
              borderRadius: BorderRadius.circular(15)),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  opcionesBusquedaMaximizado
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                busquedaEscalaHorizontal == 45
                                    ? busquedaEscalaHorizontal =
                                        MediaQuery.of(context).size.width - 90
                                    : busquedaEscalaHorizontal = 45;

                                busquedaEscalaVertical == 45
                                    ? busquedaEscalaVertical = 130
                                    : busquedaEscalaVertical = 45;

                                opcionesBusquedaMaximizado
                                    ? opcionesBusquedaMaximizado = false
                                    : opcionesBusquedaMaximizado = true;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  borderRadius: BorderRadius.circular(16)),
                              child: FadeIn(
                                delay: Duration(milliseconds: 100),
                                duration: Duration(milliseconds: 400),
                                child: Icon(
                                  Icons.tune,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          alignment: Alignment.topCenter,
                          child: FadeIn(
                            delay: Duration(milliseconds: 100),
                            duration: Duration(milliseconds: 400),
                            child: Icon(
                              Icons.tune,
                              color: Colors.grey,
                            ),
                          ),
                        )
                ],
              ),

              //Opciones avanzadas maximizado
              opcionesBusquedaMaximizado
                  ? Row(
                      children: [],
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  //ListView con las tarjetas de las salas

  Widget mostrarSalas() {
    return ListView.builder(
      shrinkWrap: true,
      controller: _scrollController,
      itemBuilder: (context, index) {
        if (index == myList.length) {
          return Container(
            height: 50,
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                CupertinoActivityIndicator(),
              ],
            ),
          );
        }
        return Container(
          color: Colors.transparent,
          child: Column(
            children: [
              crearElementoSala(context, index, index % 2 == 0 ? true : false),
              Divider(
                color: Colors.transparent,
                height: 60,
              ),
            ],
          ),
        );
      },
      itemCount: myList.length + 1,
    );
  }

  Widget crearElementoSala(context, int indiceTarjeta, bool tieneClave) {
    final temaElementoSala =
        Theme.of(context).copyWith(dividerColor: Colors.transparent);
    final temaDivisorNegro =
        Theme.of(context).copyWith(dividerColor: Colors.grey);

    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).backgroundColor.withOpacity(.9)
              ]),
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 20),
              blurRadius: 25,
              spreadRadius: -20,
              color: Colors.black,
            )
          ]),
      child: Theme(
        data: temaElementoSala,
        child: ExpansionTile(
          title: Text(
            '$nombreEquipo $indiceTarjeta',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline4
                .copyWith(fontWeight: FontWeight.w500),
            textScaleFactor: .8,
          ),
          childrenPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 2),
          leading: Container(
            width: 80,
            child: Row(
              children: [
                tieneClave == true
                    ? Icon(
                        Icons.lock_outline,
                        color: Color(0xffAD0000),
                        size: 22,
                      )
                    : Icon(
                        Icons.lock_open,
                        color: Color(0xff11700E),
                        size: 22,
                      ),
                Divider(indent: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    color: Theme.of(context).primaryColor,
                    height: 50,
                    width: 50,
                    child: Image(
                      image: AssetImage('assets/images/Gan.jpg'),
                      height: 1000,
                      width: 1000,
                    ),
                  ),
                ),
              ],
            ),
          ),
          children: [
            Theme(
              data: temaDivisorNegro,
              child: Divider(
                height: 8,
                thickness: .7,
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: 0),
              duration: Duration(milliseconds: 600),
              child: Text(
                'País',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
                textScaleFactor: .9,
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: 0),
              duration: Duration(milliseconds: 600),
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                alignment: Alignment.center,
                child: Text(
                  '$paisEquipo',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  textScaleFactor: .8,
                  maxLines: 1,
                ),
              ),
            ),
            Theme(
              data: temaDivisorNegro,
              child: Divider(
                height: 8,
                thickness: .7,
              ),
            ),
            Container(
              child: FadeIn(
                delay: Duration(milliseconds: 150),
                duration: Duration(milliseconds: 600),
                child: Text(
                  'Fecha de Creación',
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  textScaleFactor: .9,
                ),
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: 150),
              duration: Duration(milliseconds: 600),
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                alignment: Alignment.center,
                child: Text(
                  '$fechaCreacion',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.w700),
                  textAlign: TextAlign.left,
                  textScaleFactor: .8,
                  maxLines: 1,
                ),
              ),
            ),
            Theme(
              data: temaDivisorNegro,
              child: Divider(
                height: 8,
                thickness: .7,
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: 300),
              duration: Duration(milliseconds: 600),
              child: Text(
                'Descripción',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.w700),
                textAlign: TextAlign.left,
                textScaleFactor: .9,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .6,
              child: FadeIn(
                delay: Duration(milliseconds: 300),
                duration: Duration(milliseconds: 600),
                child: Text(
                  "$descripcionEquipo",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 5,
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(fontWeight: FontWeight.w700),
                  textScaleFactor: .62,
                ),
              ),
            ),
            Container(
              child:
                  tieneClave == true ? Divider(height: 26) : Divider(height: 5),
            ),
            Container(
              child: tieneClave == true
                  ? Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 1.5,
                      child: FadeIn(
                        delay: Duration(milliseconds: 450),
                        duration: Duration(milliseconds: 600),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 35,
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          decoration: BoxDecoration(
                              color: Color(0x1a7d7d7d),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                              textAlign: TextAlign.left,
                              obscureText: true,
                              decoration: InputDecoration(
                                alignLabelWithHint: true,
                                icon: Icon(Icons.vpn_key),
                                hintText: "Escribir contraseña",
                                border: InputBorder.none,
                              )),
                        ),
                      ),
                    )
                  : Container(),
            ),
            Divider(
              height: 10,
            ),
            Container(
              height: 40,
              child: FadeIn(
                delay: Duration(milliseconds: 600),
                duration: Duration(milliseconds: 600),
                child: OutlineButton(
                  padding: const EdgeInsets.symmetric(horizontal: 110),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.transparent,
                  child: Text(
                    "ENTRAR",
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        .copyWith(fontWeight: FontWeight.w700),
                    textScaleFactor: .75,
                  ),
                  onPressed: () {
                    print('Tarjeta número $indiceTarjeta seleccionada');
                    _informacionEquipo.setEnEquipo = true;
                  },
                ),
              ),
            ),
            Divider(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    Navigator.of(context).push(CreacionSala());
  }
}

Future<int> getEquipos() async {
  try {
    var uri = new Uri.https('dog.ceo', 'https//api/users?page=2');
    final resp = await http.get(uri);
    return await Future.delayed(const Duration(milliseconds: 500));
  } catch (Exception) {
    return await Future.delayed(const Duration(milliseconds: 1000));
  }
}

Future<void> vibrate() async {
  await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
}

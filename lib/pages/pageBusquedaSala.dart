import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sctproject/classes/informacionSala.dart';
import 'package:sctproject/classes/spHelper.dart';
import 'package:sctproject/pages/pageCreacionSala.dart';
import 'package:sctproject/pages/pageSala.dart';

class BusquedaSala extends StatefulWidget {
  BusquedaSala({Key key}) : super(key: key);

  InformacionSala _informacionSala = new InformacionSala();
  BusquedaSala.constructor(InformacionSala informacionSala) {
    this._informacionSala = informacionSala;
  }

  @override
  _busquedaSalaState createState() =>
      _busquedaSalaState.constructorState(_informacionSala);
}

class _busquedaSalaState extends State<BusquedaSala> {
  InformacionSala _informacionSala = new InformacionSala();

  _busquedaSalaState.constructorState(InformacionSala informacionSala) {
    this._informacionSala = informacionSala;
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

    _futureSalas = getSalas();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _futureSalas = _getMoreData();
      }
    });
  }

  String categoriaSala = "Rubik's Cube";
  String anfitrionSala = "Alejandro Ortega";
  String idiomaSala = "Español";
  String tituloSala = "World Championship";
  String descripcionSala =
      "Para echar la reta con los panas cada vez que se pueda y todos los días de ser necesario pue";
  List<Widget> listaSalas;

  int salaSeleccionada = -1;
  bool tieneClave = true;

  bool gradienteActivado = true;

  double busquedaEscalaHorizontal = 45;
  double busquedaEscalaVertical = 45;
  bool opcionesBusquedaMaximizado = false;
  bool agregandoSala = false;

  _getMoreData() {
    _futureSalas = getSalas();
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
          Container(
            color: Theme.of(context).primaryColor,
          ),
          ClipRRect(
              borderRadius: BorderRadius.circular(35.0),
              child: Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/speedC.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              )),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: <Widget>[
                  Divider(
                    color: Color(0x00EBEBEB),
                    height: 25.0,
                  ),
                  FadeInDown(
                    duration: Duration(milliseconds: 500),
                    from: 30,
                    delay: Duration(milliseconds: 0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        // Stroked text as border.
                        Text(
                          'SALAS',
                          style: TextStyle(
                            fontFamily: GoogleFonts.baiJamjuree().fontFamily,
                            fontSize: 30,
                            letterSpacing: 2,
                            fontWeight: FontWeight.bold,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 1
                              ..color = Colors.black,
                          ),
                        ),
                        Text(
                          'SALAS',
                          style: TextStyle(
                            fontFamily: GoogleFonts.baiJamjuree().fontFamily,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            color: Colors.white,
                          ),
                        ),
                      ],
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
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            cursorColor: Theme.of(context).iconTheme.color,
                            decoration: InputDecoration(
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontWeight: FontWeight.w500),
                              icon: Icon(Icons.search,
                                  color: opcionesBusquedaMaximizado
                                      ? Colors.transparent
                                      : Theme.of(context).iconTheme.color),
                              hintText: "Buscar sala",
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
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
                    height: 20,
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
            color: Theme.of(context).indicatorColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(15),
          ),
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
                              color: Theme.of(context).iconTheme.color,
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
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                  height: 10,
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
                height: 45,
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
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 20),
              blurRadius: 15,
              spreadRadius: -8,
              color: Colors.black,
            )
          ]),
      child: Theme(
        data: temaElementoSala,
        child: ExpansionTile(
          title: Text(
            '$tituloSala $indiceTarjeta',
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headline1
                .copyWith(fontWeight: FontWeight.w500),
            textScaleFactor: 1.25,
          ),
          childrenPadding: EdgeInsets.all(2),
          leading: Container(
            width: 50,
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
                Image(
                  image: AssetImage('assets/images/3x3.png'),
                  height: 21,
                  width: 21,
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
                'Anfitrión',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            FadeIn(
              delay: Duration(milliseconds: 0),
              duration: Duration(milliseconds: 600),
              child: Container(
                width: MediaQuery.of(context).size.width * .6,
                alignment: Alignment.center,
                child: Text(
                  '$anfitrionSala',
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
                  'Idioma',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
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
                  '$idiomaSala',
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
                    .subtitle1
                    .copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * .6,
              child: FadeIn(
                delay: Duration(milliseconds: 300),
                duration: Duration(milliseconds: 600),
                child: Text(
                  "$descripcionSala",
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
                            color: Theme.of(context)
                                .indicatorColor
                                .withOpacity(0.3),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: TextField(
                            cursorColor: Theme.of(context).iconTheme.color,
                            obscureText: true,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontWeight: FontWeight.w500),
                              icon: Icon(Icons.vpn_key,
                                  color: opcionesBusquedaMaximizado
                                      ? Colors.transparent
                                      : Theme.of(context).iconTheme.color),
                              hintText: "Contraseña",
                              border: InputBorder.none,
                            ),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ),
            Divider(
              height: 10,
            ),
            Container(
              height: 30,
              child: FadeIn(
                delay: Duration(milliseconds: 600),
                duration: Duration(milliseconds: 600),
                child: OutlineButton(
                  padding: const EdgeInsets.symmetric(horizontal: 110),
                  borderSide: BorderSide(
                    color: Theme.of(context).indicatorColor,
                    width: .3,
                  ),
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
                    _informacionSala.setEnSala = true;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Sala.constructor(_informacionSala)),
                    );
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

Future<int> getSalas() async {
  List listaSalas;
  try {
    var response = await Dio().get('https://restcountries.eu/rest/v2/all');
    listaSalas = response.data;
    return await Future.delayed(const Duration(milliseconds: 500));
  } catch (Exception) {
    return await Future.delayed(const Duration(milliseconds: 1000));
  }
}

Future<void> vibrate() async {
  await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
}

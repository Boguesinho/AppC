import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CreacionSala extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 400);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black.withOpacity(0.5);

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  bool conClave = false;

  double anchoCampoClave = 0;

  bool categoriasInicializadas = false;
  String nombreCategoria = "Rubik's Cube";
  List<Widget> listaCategorias = new List<Widget>();

  var begin = Offset(0, 1);
  var end = Offset.zero;

  CarouselController buttonCarouselController;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
        initialChildSize: 1,
        minChildSize: .20,
        maxChildSize: 1,
        builder: (context, sc) {
          return SingleChildScrollView(
            controller: sc,
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Divider(color: Colors.transparent, height: 5),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(.9),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 3,
                            width: 42,
                          ),
                          Divider(color: Colors.transparent, height: 7),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).backgroundColor,
                          Theme.of(context).primaryColor,
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        //STACK PARA LA FILA DEL CLOSE / CLEAR Y EL TEXTO HISTORIAL
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 55,
                                          width: 55,
                                          decoration: BoxDecoration(
                                              color: Colors.transparent,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Icon(
                                            Icons.clear,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                            size: 26,
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Historial",
                                  textScaleFactor: 1.5,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline5
                                      .copyWith(fontWeight: FontWeight.w900),
                                ),
                              ],
                            ),
                          ],
                        ),

                        //CONTAINER PARA LOS REGISTROS DE PROMEDIOS Y CONTEO
                        Container(
                          width: MediaQuery.of(context).size.width - 20,
                          height: 0,
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Column(
                                children: [],
                              ),
                              Column(),
                            ],
                          ),
                        ),
                        Divider(color: Colors.transparent),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  30,
                                              child: Text(
                                                "Nombre",
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                textScaleFactor: 1.3,
                                              ),
                                            ),
                                            Divider(
                                              indent: 40,
                                            ),
                                            Container(
                                              height: 40,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  30,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 0),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .tabBarTheme
                                                      .labelColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: TextField(
                                                  maxLines: 1,
                                                  minLines: 1,
                                                  textAlign: TextAlign.start,
                                                  decoration: InputDecoration(
                                                    hintText: "Nombre de sala",
                                                    border: InputBorder.none,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            height: 45,
                                            color: Colors.transparent),
                                        Row(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  30,
                                              child: Text(
                                                "Descripción",
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                textScaleFactor: 1.3,
                                              ),
                                            ),
                                            Divider(
                                              indent: 40,
                                            ),
                                            Container(
                                              height: 95,
                                              width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2 -
                                                  30,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 0),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .tabBarTheme
                                                      .labelColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: TextField(
                                                  maxLines: 4,
                                                  minLines: 1,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textAlign: TextAlign.start,
                                                  decoration: InputDecoration(
                                                    hintText: "Descripción",
                                                    border: InputBorder.none,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.transparent,
                                        ),
                                        Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Divider(
                                            thickness: 1.6,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 128,
                                              child: Text(
                                                "Contraseña",
                                                textAlign: TextAlign.right,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                textScaleFactor: 1.3,
                                              ),
                                            ),
                                            Switch(
                                              value: conClave,
                                              onChanged: (value) {
                                                setState(() {
                                                  conClave = value;
                                                  anchoCampoClave == 0
                                                      ? anchoCampoClave =
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width /
                                                                  2 -
                                                              30
                                                      : anchoCampoClave = 0;
                                                });
                                                changedExternalState();
                                              },
                                            ),
                                            AnimatedContainer(
                                              duration:
                                                  Duration(milliseconds: 350),
                                              curve: Curves.ease,
                                              height: 40,
                                              width: 1.0 * anchoCampoClave,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 6, vertical: 0),
                                              decoration: BoxDecoration(
                                                  color: Theme.of(context)
                                                      .tabBarTheme
                                                      .labelColor,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: TextField(
                                                  maxLines: 1,
                                                  minLines: 1,
                                                  obscureText: true,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  textAlign: TextAlign.start,
                                                  decoration: InputDecoration(
                                                    hintText: "Contraseña",
                                                    border: InputBorder.none,
                                                  )),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Divider(
                                            thickness: 1.6,
                                          ),
                                        ),
                                        Divider(
                                            height: 15,
                                            color: Colors.transparent),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Categoría",
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline5
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                textScaleFactor: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Divider(
                                            height: 10,
                                            color: Colors.transparent),
                                        Container(
                                          width: 280,
                                          child: CarouselSlider(
                                            carouselController:
                                                buttonCarouselController,
                                            options: CarouselOptions(
                                              height: 90,
                                              viewportFraction: 0.237,
                                              aspectRatio: 16 / 9,
                                              enlargeCenterPage: true,
                                              initialPage: 0,
                                              enableInfiniteScroll: true,
                                              onPageChanged: (index, reason) {
                                                setState(() {
                                                  nombreCategoria =
                                                      obtenerCategoria(
                                                          index + 1);
                                                });
                                                changedExternalState();
                                              },
                                            ),
                                            items: obtenerListaItems(
                                                "assets/images/3x3.png"),
                                          ),
                                        ),
                                        Text(
                                          "$nombreCategoria",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  fontWeight: FontWeight.w400),
                                          textScaleFactor: .9,
                                        ),
                                        Divider(
                                            height: 80,
                                            color: Colors.transparent),
                                        Column(
                                          children: [
                                            Container(
                                              height: 40,
                                              child: OutlineButton(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 110),
                                                shape:
                                                    new RoundedRectangleBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                    .circular(
                                                                30.0)),
                                                color: Colors.transparent,
                                                child: Text(
                                                  "CREAR",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w600),
                                                  textScaleFactor: 1.5,
                                                ),
                                                onPressed: () {
                                                  print(
                                                      'Botón: CREAR oprimido');
                                                },
                                              ),
                                            ),
                                            Divider(
                                                color: Colors.transparent,
                                                height: 50),
                                          ],
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<Widget> obtenerListaItems(String rutaImagen) {
    if (!categoriasInicializadas) {
      for (int i = 0; i < 17; i++) {
        listaCategorias.add(Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Stack(
            children: [
              Image(
                image: AssetImage('$rutaImagen'),
                height: 3000,
                width: 3000,
              ),
            ],
          ),
        ));
      }
      categoriasInicializadas = true;
    }
    return listaCategorias;
  }

  String obtenerCategoria(int numeroCategoria) {
    switch (numeroCategoria) {
      case 1:
        return "Rubik's Cube";
        break;
      case 2:
        return "2x2";
        break;
      case 3:
        return "4x4";
        break;
      case 4:
        return "5x5";
        break;
      case 5:
        return "6x6";
        break;
      case 6:
        return "7x7";
        break;
      case 7:
        return "Blindfold";
        break;
      case 8:
        return "FMC";
        break;
      case 9:
        return "One Hand";
        break;
      case 10:
        return "Clock";
        break;
      case 11:
        return "Megaminx";
        break;
      case 12:
        return "Pyraminx";
        break;
      case 13:
        return "Skewb";
        break;
      case 14:
        return "Square-1";
        break;
      case 15:
        return "4x4 Blindfold";
        break;
      case 16:
        return "5x5 Blindfold";
        break;
      case 17:
        return "Multi-Blindfold";
        break;

      default:
        return "";
        break;
    }
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeIn(
      animate: true,
      delay: Duration(milliseconds: 50),
      duration: Duration(milliseconds: 600),
      child: SlideTransition(
        position: Tween(begin: Offset(0.0, 1.0), end: Offset(0.0, 0.0))
            .animate(animation),
        child: child,
      ),
    );
  }
}

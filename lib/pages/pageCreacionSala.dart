import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CreacionSala extends ModalRoute<void> {
  @override
  Duration get transitionDuration => Duration(milliseconds: 450);

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
            child: GestureDetector(
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.linear_scale,
                        color: Colors.white,
                        size: 27,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * .927,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            borderRadius: BorderRadius.circular(25),
                            gradient: LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color(0xffA1C7EF),
                                  Color(0xff2D71B8)
                                ])),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Divider(
                                          height: 8,
                                        ),
                                        Text(
                                          "Crear Sala",
                                          textScaleFactor: 1.3,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4
                                              .copyWith(
                                                  fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Material(
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
                                          color: Colors.white,
                                          size: 26,
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.pop(context);
                                      }),
                                ),
                              ],
                            ),
                            Divider(height: 45, color: Colors.transparent),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: Text(
                                    "Nombre",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Divider(
                                  indent: 40,
                                ),
                                Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .tabBarTheme
                                          .labelColor,
                                      borderRadius: BorderRadius.circular(15)),
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
                            Divider(height: 45, color: Colors.transparent),
                            Row(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: Text(
                                    "Descripción",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Divider(
                                  indent: 40,
                                ),
                                Container(
                                  height: 95,
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .tabBarTheme
                                          .labelColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextField(
                                      maxLines: 4,
                                      minLines: 1,
                                      keyboardType: TextInputType.text,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(
                                thickness: 1.6,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 128,
                                  child: Text(
                                    "Contraseña",
                                    textAlign: TextAlign.right,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w500),
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
                                  duration: Duration(milliseconds: 350),
                                  curve: Curves.ease,
                                  height: 40,
                                  width: 1.0 * anchoCampoClave,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 0),
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .tabBarTheme
                                          .labelColor,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: TextField(
                                      maxLines: 1,
                                      minLines: 1,
                                      obscureText: true,
                                      keyboardType: TextInputType.text,
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Divider(
                                thickness: 1.6,
                              ),
                            ),
                            Divider(height: 10, color: Colors.transparent),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    "Categoría",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Divider(height: 20, color: Colors.transparent),
                            Container(
                              width: 280,
                              child: CarouselSlider(
                                carouselController: buttonCarouselController,
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
                                          obtenerCategoria(index + 1);
                                    });
                                    changedExternalState();
                                  },
                                ),
                                items:
                                    obtenerListaItems("assets/images/3x3.png"),
                              ),
                            ),
                            Text(
                              "$nombreCategoria",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4
                                  .copyWith(fontWeight: FontWeight.w400),
                              textScaleFactor: .7,
                            ),
                            Divider(height: 80, color: Colors.transparent),
                            Container(
                              height: 40,
                              child: OutlineButton(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 110),
                                shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0)),
                                color: Colors.transparent,
                                child: Text(
                                  "CREAR",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(fontWeight: FontWeight.w600),
                                  textScaleFactor: 1,
                                ),
                                onPressed: () {
                                  print('Botón: CREAR oprimido');
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
    var tween = Tween(begin: begin, end: end);

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

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sctproject/DB/dataBaseProvider.dart';
import 'package:sctproject/classes/spHelper.dart';
import 'package:sctproject/models/sesion.dart';

class Categorias extends StatefulWidget {
  Categorias({Key key}) : super(key: key);

  @override
  _CategoriasState createState() => _CategoriasState();
}

class _CategoriasState extends State<Categorias> {
  List<Sesion> listaSesiones;
  int categoriaActual;
  int despliegueActual = 0;
  int sesionActual = 1;

  @override
  void initState() {
    super.initState();
    DatabaseProvider.db.getSesiones().then(
      (solveList) {
        listaSesiones = solveList;
      },
    );
    setState(() {
      categoriaActual = SPHelper.getInt('categoriaSeleccionadaInt');
      sesionActual = SPHelper.getInt('sesionSeleccionadaInt');

      print(categoriaActual);
      print(sesionActual);
    });
  }

  //VARIABLES
  TextEditingController txtController = new TextEditingController();

  List<Widget> listaCategorias = new List<Widget>();
  List<Widget> listaSesionesW = new List<Widget>();

  bool contenedorDesplegado = false;
  bool sesionCambiada = false;

  double alturaContenedor = 93;

  var sesionesStr = {""};

  var categoriasStr = {
    "Rubiks Cube",
    "2x2",
    "4x4",
    "5x5",
    "6x6",
    "7x7",
    "Clock",
    "Megaminx",
    "Pyraminx",
    "Skewb",
    "Square-1",
  };

  double _getAlturaContenedor(int index) {
    alturaContenedor = 90;
    for (int i = 0; i < listaSesiones.length; i++) {
      if (listaSesiones[i].foreignCategorias == index + 1) {
        alturaContenedor += 33.0;
      }
    }
    return alturaContenedor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: sesionCambiada
          ? FloatingActionButton.extended(
              backgroundColor: Theme.of(context).backgroundColor,
              onPressed: () async {
                //CAMBIO DEL VALOR DE LA SESION SELECCIONADA
                SPHelper.setString('sesionSeleccionada',
                    '${listaSesiones[sesionActual - 1].nombreSesion}');

                SPHelper.setString('categoriaSeleccionada',
                    '${categoriasStr.toList()[categoriaActual]}');

                SPHelper.setInt('categoriaSeleccionadaInt', categoriaActual);
                SPHelper.setInt('sesionSeleccionadaInt', sesionActual);

                Navigator.pop(context);
                setState(() {});
              },
              icon: Icon(Icons.save_alt),
              label: Text(
                "Guardar cambios",
                textAlign: TextAlign.center,
                textScaleFactor: .6,
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            )
          : null,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Container(
            width: 50,
            height: 50,
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Icon(MdiIcons.arrowLeftBold,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                "Elige categoría y sesión",
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Container(
            width: 50,
            height: 50,
            child: CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Icon(Icons.delete_forever,
                  color: Theme.of(context).iconTheme.color),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        child: Column(
          children: [
            Divider(height: 30, color: Colors.transparent),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 240),
                      childAnimationBuilder: (widget) => ScaleAnimation(
                        scale: .5,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: obtenerListaCategorias(true),
                    ),
                  ),
                ),
                AnimationLimiter(
                  child: Column(
                    children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(milliseconds: 240),
                      childAnimationBuilder: (widget) => ScaleAnimation(
                        scale: .5,
                        child: FadeInAnimation(
                          child: widget,
                        ),
                      ),
                      children: obtenerListaCategorias(false),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> obtenerListaCategorias(bool columnaIzquierda) {
    listaCategorias.clear();

    if (columnaIzquierda) {
      for (int i = 0; i < categoriasStr.length; i++) {
        if (i % 2 == 0) {
          listaCategorias.add(_getTarjetaCategoria(
              "${categoriasStr.toList()[i]}", "Sesión $i", i));
          listaCategorias.add(Divider(color: Colors.transparent, height: 30));
        }
      }
    } else {
      for (int i = 0; i < categoriasStr.length; i++) {
        if (i % 2 != 0) {
          listaCategorias.add(_getTarjetaCategoria(
              "${categoriasStr.toList()[i]}", "Sesión $i", i));
          listaCategorias.add(Divider(color: Colors.transparent, height: 30));
        }
      }
    }

    listaCategorias.add(Container(height: 50));
    listaCategorias.add(Container(height: 50));

    return listaCategorias;
  }

  cambiarSesion(int id, int index) {
    sesionActual = id;
    categoriaActual = index;
    sesionCambiada = true;
  }

  Widget _getTarjetaCategoria(
      String nombreCategoria, String nombreSesion, int index) {
    return

        //CONTENEDOR GENERAL
        AnimatedContainer(
      duration: Duration(milliseconds: 900),
      curve: Curves.ease,

      //ALTURA CONTAINER
      height: despliegueActual == index && contenedorDesplegado
          ? _getAlturaContenedor(index)
          : 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  //CONTENEDOR TITULO
                  CupertinoButton(
                    pressedOpacity: 1,
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      setState(() {
                        despliegueActual == index && contenedorDesplegado
                            ? contenedorDesplegado = false
                            : despliegueActual == index && !contenedorDesplegado
                                ? contenedorDesplegado = true
                                : contenedorDesplegado = true;
                        despliegueActual = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 450),
                      curve: Curves.ease,
                      padding:
                          EdgeInsets.symmetric(horizontal: 7, vertical: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: categoriaActual == index
                            ? LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Theme.of(context).primaryColorDark,
                                  Theme.of(context).primaryColorLight
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Theme.of(context).backgroundColor,
                                  Theme.of(context).backgroundColor,
                                ],
                              ),
                      ),
                      height: 50,
                      width: MediaQuery.of(context).size.width / 2.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage('assets/images/3x3.png'),
                            height: 22,
                            width: 22,
                          ),
                          Container(width: 8),
                          Expanded(
                            child: Text(
                              "$nombreCategoria",
                              textAlign: TextAlign.center,
                              textScaleFactor: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(fontWeight: FontWeight.w900),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.transparent,
                    height: 5,
                  ),
                  despliegueActual == index && contenedorDesplegado
                      ? Column(
                          children: getListaSesionesW(index),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getListaSesionesW(int index) {
    listaSesionesW.clear();
    for (int i = 0; i < listaSesiones.length; i++) {
      if (listaSesiones[i].foreignCategorias == index + 1) {
        listaSesionesW.add(
          FadeIn(
            duration: Duration(milliseconds: 300),
            child: CupertinoButton(
              minSize: 0,
              pressedOpacity: 1,
              padding: EdgeInsets.all(0),
              onPressed: () {
                setState(() {
                  print("BOTON A SELECCIONADO $i");

                  cambiarSesion(i + 1, index);
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 350),
                curve: Curves.ease,
                padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: sesionActual == i + 1 && categoriaActual == index
                      ? LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).primaryColorDark,
                            Theme.of(context).primaryColorLight
                          ],
                        )
                      : LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Theme.of(context).backgroundColor,
                            Theme.of(context).backgroundColor,
                          ],
                        ),
                ),
                height: despliegueActual == index ? 30 : 0,
                width: MediaQuery.of(context).size.width / 2.5,
                child: Center(
                  child: Text(
                    "${listaSesiones.toList()[i].nombreSesion}",
                    textAlign: TextAlign.center,
                    textScaleFactor: .7,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ),
        );
        listaSesionesW.add(Divider(color: Colors.transparent, height: 3));
      }
    }

    listaSesionesW.add(
      FadeIn(
        delay: Duration(milliseconds: 200),
        child: CupertinoButton(
          minSize: 0,
          pressedOpacity: 1,
          padding: EdgeInsets.all(0),
          onPressed: () async {
            //INSERTAR SESION EN BD
            Sesion sesion = Sesion(
                nombreSesion: "Nueva sesión", foreignCategorias: index + 1);
            mostrarForm(context, sesion, listaSesiones.length, index);
            setState(() {});
          },
          child: AnimatedContainer(
            duration: Duration(milliseconds: 650),
            curve: Curves.ease,
            padding: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Theme.of(context).backgroundColor,
                  Theme.of(context).backgroundColor,
                ],
              ),
            ),
            height: despliegueActual == index ? 30 : 0,
            width: MediaQuery.of(context).size.width / 2.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    "Nueva sesión",
                    textAlign: TextAlign.center,
                    textScaleFactor: .7,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Container(width: 7),
                Center(child: Icon(Icons.add)),
              ],
            ),
          ),
        ),
      ),
    );

    return listaSesionesW;
  }

  mostrarForm(BuildContext context, Sesion sesion, int id, int index) {
    txtController.text = "";
    showDialog(
      context: context,
      builder: (context) => Theme(
        data: Theme.of(context),
        child: AlertDialog(
          backgroundColor: Theme.of(context).backgroundColor.withOpacity(1),
          title: Text(
            "Crear sesión",
            textAlign: TextAlign.center,
            textScaleFactor: 1.2,
            style: Theme.of(context)
                .textTheme
                .headline5
                .copyWith(fontWeight: FontWeight.w900),
          ),
          content: TextField(
            controller: txtController,
            obscureText: false,
            autofocus: true,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Nombre de sesión',
              hintStyle: TextStyle(color: Colors.grey),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () async {
                sesion.nombreSesion = txtController.text;
                await DatabaseProvider.db.insertSesion(sesion);
                setState(() {
                  listaSesiones.add(sesion);
                  cambiarSesion(id + 1, index);
                  Navigator.pop(context);
                });
              },
              child: Text(
                "Guardar",
                textAlign: TextAlign.left,
                textScaleFactor: 1,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).primaryColorDark),
              ),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  Navigator.pop(context);
                });
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
}

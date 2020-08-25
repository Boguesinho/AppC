import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sctproject/pages/pageBusquedaSala.dart';
import 'package:sctproject/pages/pageConfiguracion.dart';
import 'package:sctproject/pages/pageEquipo.dart';
import 'package:sctproject/pages/pagePerfilUsuario.dart';
import 'package:sctproject/pages/pageTimerCubo.dart';

class CustomNavBar extends StatefulWidget {
  @override
  _CustomNavBarState createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar> {
  final colorBase = Color(0xff333437); //Color con opacidad 100
  int indicePagina = 2;

  final BusquedaSala _busquedaSala = new BusquedaSala();
  final Configuracion _configuracion = new Configuracion();
  final Equipo _equipo = new Equipo();
  final PerfilUsuario _perfilUsuario = new PerfilUsuario();
  final TimerCubo _timerCubo = new TimerCubo();

  Widget _mostrarPagina = TimerCubo();

  Widget _elegirPagina(int pagina) {
    switch (pagina) {
      case 0:
        return _perfilUsuario;
        break;
      case 1:
        return _equipo;
        break;
      case 2:
        return _timerCubo;
        break;
      case 3:
        return _busquedaSala;
        break;
      case 4:
        return _configuracion;
        break;
      default:
        return new Container(
          child: new Text(
            'No se ha encontrado ninguna página',
            textScaleFactor: 2,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        color: colorBase,
        height: 50,
        index: indicePagina,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        items: <Widget>[
          Icon(Icons.person,
              size: 25, color: Theme.of(context).iconTheme.color),
          Icon(Icons.people,
              size: 25, color: Theme.of(context).iconTheme.color),
          Icon(Icons.timer, size: 25, color: Theme.of(context).iconTheme.color),
          Icon(Icons.dashboard,
              size: 25, color: Theme.of(context).iconTheme.color),
          Icon(Icons.settings,
              size: 25, color: Theme.of(context).iconTheme.color),
        ],
        onTap: (index) {
          setState(() {
            _mostrarPagina = _elegirPagina(index);
          });
        },
        animationDuration: Duration(milliseconds: 500),
        animationCurve: Curves.ease,
      ),
      body: Container(
        color: Colors.black,
        child: Center(
          child: _mostrarPagina,
        ),
      ),
    );
  }
}

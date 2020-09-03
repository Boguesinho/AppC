import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:sctproject/pages/pagePerfilUsuario.dart';
import 'package:sctproject/utils/theme.dart';

import 'pages/pageBusquedaEquipo.dart';
import 'pages/pageBusquedaSala.dart';
import 'pages/pageChatEquipo.dart';
import 'pages/pageConfiguracion.dart';
import 'pages/pageTimerCubo.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: basicTheme(),
      home: Example(),
    ));

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int _indicePagina = 2;

  final ChatEquipo _chatEquipo = new ChatEquipo();

  final BusquedaSala _busquedaSala = new BusquedaSala();
  final Configuracion _configuracion = new Configuracion();
  final BusquedaEquipo _busquedaEquipo = new BusquedaEquipo();
  final PerfilUsuario _perfilUsuario = new PerfilUsuario();
  final TimerCubo _timerCubo = new TimerCubo();

  Widget _mostrarPagina = TimerCubo();

  Widget _elegirPagina(int pagina) {
    switch (pagina) {
      case 0:
        return _perfilUsuario;
        break;
      case 1:
        return _busquedaEquipo;
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
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: [
              BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(.1))
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 7),
            child: GNav(
                gap: 12,
                activeColor: Theme.of(context).primaryColor,
                iconSize: 23,
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                duration: Duration(milliseconds: 700),
                tabBackgroundColor: Theme.of(context).backgroundColor,
                tabs: [
                  GButton(
                    icon: LineIcons.user,
                    text: 'Perfil',
                  ),
                  GButton(
                    icon: LineIcons.group,
                    text: 'Equipo',
                  ),
                  GButton(
                    icon: Icons.timer,
                    text: 'Timer',
                  ),
                  GButton(
                    icon: Icons.dashboard,
                    text: 'Salas',
                  ),
                  GButton(
                    icon: LineIcons.bar_chart_o,
                    text: 'Estadísticas',
                  ),
                ],
                selectedIndex: _indicePagina,
                onTabChange: (index) {
                  setState(() {
                    vibrate();
                    _indicePagina = index;
                    _mostrarPagina = _elegirPagina(index);
                  });
                }),
          ),
        ),
      ),
      body: Container(
        child: Center(
          child: _mostrarPagina,
        ),
      ),
    );
  }

  Future<void> vibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }
}

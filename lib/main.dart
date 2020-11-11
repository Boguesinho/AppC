import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sctproject/pages/pageHistorial.dart';
import 'package:sctproject/pages/pagePerfilUsuario.dart';
import 'package:sctproject/pages/pageTimer.dart';
import 'bloc/tiempos_bloc.dart';
import 'classes/spHelper.dart';
import 'classes/tema.dart';
import 'pages/pageBusquedaSala.dart';
import 'pages/pageConfiguracion.dart';
import 'package:shared_preferences/shared_preferences.dart';

TemaCambio temaActual = TemaCambio();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    SharedPreferences.getInstance().then((SharedPreferences sp) {
      SPHelper.setPref(sp);
      runApp(MyApp());
    });
  });
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }

  static TemaCambio getThemeObject() {
    return temaActual;
  }
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    temaActual.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SolveBloc>(
      create: (context) => SolveBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: temaActual.temaActual(),
        home: new Example(),
      ),
    );
  }
}

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  PageController _pageController = new PageController();

  int _indicePagina = 2;

  //final ChatEquipo _chatEquipo = new ChatEquipo.constructor(_informacionEquipo);

  var _paginas = [
    new PerfilUsuario(),
    Historial(),
    TimerCubo(),
    Configuracion(),
    BusquedaSala()
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: new Scaffold(
        bottomNavigationBar: AnimatedContainer(
          duration: Duration(milliseconds: 600),
          curve: Curves.ease,
          height: 40,
          child: new TabBar(
              indicatorColor: Colors.transparent,
              labelColor: Theme.of(context).iconTheme.color,
              tabs: [
                Tab(
                  icon: new Icon(MdiIcons.account),
                ),
                Tab(
                  icon: new Icon(MdiIcons.history),
                ),
                Tab(
                  icon: new Icon(MdiIcons.timer),
                ),
                Tab(
                  icon: new Icon(MdiIcons.chartArc),
                ),
                Tab(
                  icon: new Icon(MdiIcons.cubeOutline),
                ),
              ],
              onTap: (index) {
                setState(() {
                  vibrate();
                  _indicePagina = index;
                  _pageController.jumpToPage(_indicePagina);
                });
              }),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: PageView(
            pageSnapping: true,
            controller: _pageController,
            children: _paginas,
            onPageChanged: (index) {
              setState(() {
                _indicePagina = index;
              });
            }),
      ),
    );
  }

  Future<void> vibrate() async {
    await SystemChannels.platform.invokeMethod<void>('HapticFeedback.vibrate');
  }
}

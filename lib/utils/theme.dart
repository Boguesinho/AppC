import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5.copyWith(
          fontFamily: 'Roboto',
          fontSize: 15.0,
          color: Color(0xff333437),
        ),

        //Letras en detalle, para resaltar
        headline6: base.headline6.copyWith(
            fontFamily: 'Roboto', fontSize: 17.0, color: Color(0xff2874A6)),

        //Color contrario al de la base (base oscura > blanco)
        headline4: base.headline5.copyWith(
          fontFamily: 'Roboto',
          fontSize: 24.8,
          color: Colors.white,
        ),
        headline3: base.headline5.copyWith(
          fontFamily: 'Roboto',
          fontSize: 21.0,
          color: Color(0xff333437),
        ),
        //LETRA DE TARJETAS
        headline1: base.headline1.copyWith(
          fontFamily: 'Roboto',
          fontSize: 15.0,
          color: Colors.black,
        ),
        caption: base.caption.copyWith(
          color: Color(0xFFCCC5AF),
        ),
        bodyText2: base.bodyText2.copyWith(color: Colors.black),
        bodyText1: base.bodyText2.copyWith(color: Color(0xff21649B)));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      //textTheme: Typography().white,

      //GRIS OSCURO: 0xff333437

      //Primer gradiente
      primaryColor: Color(0xffEAF2F8),

      //primaryColor: Color(0xff4829b2),
      indicatorColor: Colors.black,
      scaffoldBackgroundColor: Color(0xf2D0D0D0),
      accentColor: Colors.blueAccent,
      iconTheme: IconThemeData(
        color: Color(0xff333437),
        size: 20.0,
      ),
      buttonColor: Color(0xe6ADADAD),

      //Segundo gradiente
      //Azul Oscuro-: backgroundColor: Color(0xff2874A6),
      //Azul claro: backgroundColor: Color(0xff5499C7),
      backgroundColor: Color(0xff2874A6),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Color(0xffEBF5FB),
        unselectedLabelColor: Colors.grey,
      ));
}

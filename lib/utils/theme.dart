import 'package:flutter/material.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5.copyWith(
          fontFamily: 'Roboto',
          fontSize: 15.0,
          color: Color(0xff333437),
        ),
        headline6: base.headline6.copyWith(
            fontFamily: 'Roboto', fontSize: 17.0, color: Color(0xff21649B)),
        headline4: base.headline5.copyWith(
          fontFamily: 'Roboto',
          fontSize: 24.0,
          color: Colors.white,
        ),
        headline3: base.headline5.copyWith(
          fontFamily: 'Roboto',
          fontSize: 21.0,
          color: Color(0xff616161),
        ),
        caption: base.caption.copyWith(
          color: Color(0xFFCCC5AF),
        ),
        bodyText2: base.bodyText2.copyWith(color: Colors.black));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      //textTheme: Typography().white,

      //GRIS OSCURO: 0xff333437

      //Primer gradiente
      primaryColor: Colors.blue,
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
      backgroundColor: Color(0xffffffff),
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
      ));
}

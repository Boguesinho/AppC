import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData basicTheme() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15.0,
          color: Color(0xff333437),
        ),

        //Letras en detalle, para resaltar
        headline6: base.headline6.copyWith(
            fontFamily: GoogleFonts.baiJamjuree().fontFamily,
            fontSize: 17.0,
            color: Color(0xff2874A6)),

        //Color contrario al de la base (base oscura > blanco)
        headline4: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 24.8,
          color: Colors.white,
        ),
        headline3: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 21.0,
          color: Colors.black,
        ),
        subtitle1: base.headline6.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15,
          color: Colors.white,
        ),
        //LETRA DE TARJETAS
        headline1: base.headline1.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
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

      //GRIS OSCURO: 0xff33343

      //PRIMER GRADIENTE
      primaryColorLight: Colors.deepPurple[400].withOpacity(.8),

      //SEGUNDO GRADIENTE
      primaryColorDark: Colors.blue[300].withOpacity(.8),
      primaryColor: Color(0xffEAF2F8),
      cardColor: Color(0xff434B63).withOpacity(.4),
      //primaryColor: Color(0xff4829b2),
      indicatorColor: Colors.white,
      scaffoldBackgroundColor: Color(0xf2D0D0D0),
      accentColor: Colors.grey,
      iconTheme: IconThemeData(
        color: Color(0xff333437),
        size: 20.0,
      ),
      buttonColor: Color(0xe6ADADAD),

      //COLOR PARA LAS CATEGORIAS / BAJA OPACIDAD
      backgroundColor: Color(0xff505B5F).withOpacity(.2),

      //
      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Color(0xffEBF5FB),
        unselectedLabelColor: Colors.grey,
      ));
}

/*







*/
ThemeData temaOscuro() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15.0,
          color: Colors.white,
        ),

        //Letras en detalle, para resaltar
        headline6: base.headline6.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 18,
          color: Color(0xff2874A6),
        ),
        //Color contrario al de la base (base oscura > blanco)
        headline4: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 24.8,
          color: Colors.white,
        ),
        subtitle1: base.headline6.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15,
          color: Colors.black,
        ),
        headline3: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 21.0,
          color: Colors.white,
        ),
        //LETRA DE TARJETAS
        headline1: base.headline1.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15.0,
          color: Colors.white,
        ),
        caption: base.caption.copyWith(
          color: Colors.white,
        ),
        bodyText2: base.bodyText2.copyWith(color: Colors.white),
        bodyText1: base.bodyText2.copyWith(color: Colors.white));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      //textTheme: Typography().white,

      //GRIS OSCURO: 0xff333437

      //PRIMER GRADIENTE
      primaryColorLight: Colors.deepPurple[400].withOpacity(.8),

      //SEGUNDO GRADIENTE
      primaryColorDark: Colors.blue[300].withOpacity(.8),
      primaryColor: Color(0xff282828),
      backgroundColor: Color(0xff717A97),
      cardColor: Color(0xff434B63),

      //primaryColor: Color(0xff4829b2),
      indicatorColor: Colors.black,
      scaffoldBackgroundColor: Color(0xf2D0D0D0),
      accentColor: Colors.grey,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 20.0,
      ),
      buttonColor: Color(0xe6ADADAD),

      //Segundo gradiente
      //Azul Oscuro-: backgroundColor: Color(0xff2874A6),
      //Azul claro: backgroundColor: Color(0xff5499C7),

      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
      ));
}

/*






*/

ThemeData temaAmoled() {
  TextTheme _basicTextTheme(TextTheme base) {
    return base.copyWith(
        headline5: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15.0,
          color: Colors.white,
        ),

        //Letras en detalle, para resaltar
        headline6: base.headline6.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 18,
          color: Color(0xff2874A6),
        ),
        //Color contrario al de la base (base oscura > blanco)
        headline4: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 24.8,
          color: Colors.white,
        ),
        subtitle1: base.headline6.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15,
          color: Colors.black,
        ),
        headline3: base.headline5.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 21.0,
          color: Colors.white,
        ),
        //LETRA DE TARJETAS
        headline1: base.headline1.copyWith(
          fontFamily: GoogleFonts.baiJamjuree().fontFamily,
          fontSize: 15.0,
          color: Colors.white,
        ),
        caption: base.caption.copyWith(
          color: Colors.white,
        ),
        bodyText2: base.bodyText2.copyWith(color: Colors.white),
        bodyText1: base.bodyText2.copyWith(color: Colors.white));
  }

  final ThemeData base = ThemeData.light();
  return base.copyWith(
      textTheme: _basicTextTheme(base.textTheme),
      //textTheme: Typography().white,

      primaryColor: Colors.black,

      //COLOR PARA LAS CATEGORIAS / BAJA OPACIDAD
      backgroundColor: Color(0xff505B5F).withOpacity(.3),
      cardColor: Color(0xff434B63).withOpacity(.4),

      //PRIMER GRADIENTE
      primaryColorLight: Colors.deepPurple[400].withOpacity(.8),

      //SEGUNDO GRADIENTE
      primaryColorDark: Colors.blue[300].withOpacity(.8),

      //primaryColor: Color(0xff4829b2),
      indicatorColor: Colors.black,
      scaffoldBackgroundColor: Color(0xf2D0D0D0),
      accentColor: Colors.grey,
      iconTheme: IconThemeData(
        color: Colors.white,
        size: 20.0,
      ),
      buttonColor: Color(0xe6ADADAD),
      dialogBackgroundColor: Colors.blue,

      //Segundo gradiente
      //Azul Oscuro-: backgroundColor: Color(0xff2874A6),
      //Azul claro: backgroundColor: Color(0xff5499C7),

      tabBarTheme: base.tabBarTheme.copyWith(
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
      ));
}

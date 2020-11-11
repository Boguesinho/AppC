import 'package:flutter/material.dart';
import 'package:sctproject/classes/informacionEquipo.dart';
import 'package:sctproject/models/mensaje_model.dart';

class ChatEquipo extends StatefulWidget {
  ChatEquipo({Key key}) : super(key: key);

  InformacionEquipo _informacionEquipo = new InformacionEquipo();
  ChatEquipo.constructor(InformacionEquipo informacionEquipo) {
    this._informacionEquipo = informacionEquipo;
  }
  @override
  _ChatEquipoState createState() =>
      _ChatEquipoState.constructorState(_informacionEquipo);
}

class _ChatEquipoState extends State<ChatEquipo> {
  InformacionEquipo _informacionEquipo = new InformacionEquipo();

  _ChatEquipoState.constructorState(InformacionEquipo informacionEquipo) {
    this._informacionEquipo = informacionEquipo;
  }

  //CREAR MENSAJE

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe
            ? Theme.of(context).accentColor.withOpacity(.25)
            : Theme.of(context).backgroundColor.withOpacity(.17),
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            textScaleFactor: .28,
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  fontWeight: FontWeight.w400,
                ),
            textScaleFactor: .27,
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: <Widget>[
        msg,
      ],
    );
  }

//TEXTFIELD PARA EL MENSAJE
  _buildMessageComposer() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: [
              Container(width: 15),
              Expanded(
                child: TextField(
                    maxLines: 4,
                    minLines: 1,
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                      hintText: "Escribe un mensaje",
                      border: InputBorder.none,
                    )),
              ),
              Container(width: 15),
              Container(
                height: 20,
                width: 20,
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.send,
                      size: 22, color: Theme.of(context).iconTheme.color),
                  onPressed: () {
                    print("ENVIAR MENSAJE");
                  },
                ),
              ),
              Container(width: 15),
            ],
          ),
        ),
        Divider(height: 5, color: Colors.transparent),
      ],
    );
  }

  //MÉTODO BUILD

  @override
  Widget build(BuildContext context) {
    Widget imagenEquipo = _informacionEquipo.imagenEquipo;
    String nombreEquipo = _informacionEquipo.nombreEquipo;
    int cantidadMiembros = _informacionEquipo.cantidadMiembros;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(.65),
      body: Stack(
        children: [
          //MENSAJE DE CHAT
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).primaryColor.withOpacity(.5),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                            ),
                            child: ListView.builder(
                              reverse: true,
                              padding: EdgeInsets.only(top: 15.0),
                              itemCount: messages.length,
                              itemBuilder: (BuildContext context, int index) {
                                final Message message = messages[index];
                                final bool isMe =
                                    message.sender.id == usuarioActual.id;
                                return _buildMessage(message, isMe);
                              },
                            ),
                          ),
                        ),
                      ),
                      _buildMessageComposer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              ClipPath(
                clipper: MyClipper(),
                //CONTENEDOR SUPERIOR (TODO LO DE ARRIBA)
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topRight,
                        colors: [
                          Theme.of(context).backgroundColor,
                          Theme.of(context).primaryColor,
                        ]),
                  ),
                  height: 140,
                  child: SafeArea(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //DIVISOR SUPERIOR (ENTRE LA BARRA DE NOTIFICACIÓN Y LA IMAGEN DE EQUIPO)
                        Divider(height: 10, color: Colors.transparent),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //CONTENEDOR CON IMAGEN DEL EQUIPO
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                  color: Theme.of(context).primaryColor,
                                  height: 60,
                                  width: 60,
                                  child: imagenEquipo,
                                ),
                              ),
                            ),

                            Expanded(
                              flex: 10,
                              child: Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Text(
                                      "$nombreEquipo",
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4
                                          .copyWith(
                                              fontWeight: FontWeight.w600),
                                      textAlign: TextAlign.left,
                                      textScaleFactor: 1,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Divider(height: 5, color: Colors.transparent),
                                  Row(
                                    children: [],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 50,
                                    alignment: Alignment.center,
                                    child: OutlineButton(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(7.0)),
                                      color: Colors.transparent,
                                      onPressed: () {
                                        print(
                                            'Botón: MIEMBROS EQUIPO oprimido');
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.group,
                                            size: 27,
                                            color: Theme.of(context)
                                                .iconTheme
                                                .color,
                                          ),
                                          Text(
                                            "$cantidadMiembros",
                                            overflow: TextOverflow.ellipsis,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline6
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                            textAlign: TextAlign.left,
                                            textScaleFactor: 1.05,
                                            maxLines: 2,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();

    var controlPoint = Offset(size.width / 5.4, size.height);
    var endPoint = Offset(size.width / 4.5, size.height);

    path.lineTo(0, size.height - 30);
    path.quadraticBezierTo(
        controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy);
    path.quadraticBezierTo(
        size.width / 3, endPoint.dy, size.width, size.height - 30);
    //path.lineTo(size.width, size.height - 30);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }
}

import 'package:sctproject/models/usuario_model.dart';

class Message {
  final User sender;
  final String
      time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
  });
}

// USUARIO ACTUAL(Mensaje propio)
final User usuarioActual = User(
  id: 0,
  name: 'Usuario actual',
  imageUrl: 'assets/images/3x3.png',
);

// USUARIOS
final User paco = User(
  id: 1,
  name: 'Paco',
  imageUrl: 'assets/images/3x3.png',
);
final User pablo = User(
  id: 2,
  name: 'Pablo',
  imageUrl: 'assets/images/3x3.png',
);

List<Message> messages = [
  Message(
    sender: pablo,
    time: '5:30 PM',
    text: 'Mensaje de prueba número uno para ver el tamaño del mensaje',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: usuarioActual,
    time: '4:30 PM',
    text: 'Mensaje de prueba número dos para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '3:45 PM',
    text:
        'Mensaje de prueba número tres para ver el tamaño del mensaje Mensaje de prueba número uno para ver el tamaño del mensaje Mensaje de prueba número uno para ver el tamaño del mensajeMensaje de prueba número uno para ver el tamaño del mensaje Mensaje de prueba número uno para ver el tamaño del mensaje Mensaje de prueba número uno para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '3:15 PM',
    text: 'Mensaje de prueba número cuatro para ver el tamaño del mensaje',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: usuarioActual,
    time: '2:30 PM',
    text: 'Mensaje de prueba número cinco para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'Mensaje de prueba número seis para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'Mensaje de prueba número siete para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'Mensaje de prueba número ocho para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'Mensaje de prueba número nueve para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'Mensaje de prueba número diez para ver el tamaño del mensaje',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'sdas',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'sdas',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: pablo,
    time: '2:00 PM',
    text: 'sdas',
    isLiked: false,
    unread: true,
  ),
];

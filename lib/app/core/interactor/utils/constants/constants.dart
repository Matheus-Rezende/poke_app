import 'package:flutter/cupertino.dart';

@immutable
class Constants {
  //------------------- URL BASE --------------------------------------------
  static String urlBase() => 'https://pokeapi.co/api/v2/';
  //-------------------------------------------------------------------------

  //------------------- TIMEOUT ---------------------------------------------
  static int timeoutSeconds() => 10;
  static String timeoutMessage() => 'Estamos tendo problemas para conectar ao servidor :(';
}

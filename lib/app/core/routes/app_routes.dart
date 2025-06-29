import 'package:flutter/foundation.dart';

@immutable
class AppRoutes {
  //------------------- Rota do menu -------------------------
  static String bottomMenu() => '/bottom-menu/';
  //-------------------------------------------------------------------------

  //------------------- Rotas para o módulo Onboard -------------------------
  static String splash() => '/';
  static String onboarding() => '/onboarding';
  //-------------------------------------------------------------------------

  //------------------- Rotas para o módulo Pokedex -------------------------
  static String pokemonDetails() => '/pokedex/pokemon-details';
  //-------------------------------------------------------------------------

  //------------------- Rotas para o módulo Regiões -------------------------
  static String regions() => '/regions/';
  //-------------------------------------------------------------------------

  //------------------- Rotas para o módulo Favoritos -----------------------
  static String favorites() => '/favorites/';
  //-------------------------------------------------------------------------

  //------------------- Rotas para o módulo Perfil --------------------------
  static String profile() => '/profile/';
  //-------------------------------------------------------------------------
}

abstract final class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static String pokemonDetails(String pokemonName) => '$home/$pokemonName';
}

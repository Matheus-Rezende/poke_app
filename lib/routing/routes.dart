abstract final class Routes {
  static const String splash = '/';
  static const String home = '/home';
  static String pokemonDetails(int pokemonId) => '$home/$pokemonId';
}

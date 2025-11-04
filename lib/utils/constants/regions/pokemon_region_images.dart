import 'package:poke_app/utils/assets/app_assets.dart';

class PokemonRegionImages {
  static Map<String, String> generationImages = {
    '1': AppAssets.pokemonRegions.kanto,
    '2': AppAssets.pokemonRegions.johto,
    '3': AppAssets.pokemonRegions.hoenn,
    '4': AppAssets.pokemonRegions.sinnoh,
    '5': AppAssets.pokemonRegions.unova,
    '6': AppAssets.pokemonRegions.kalos,
    '7': AppAssets.pokemonRegions.alola,
    '8': AppAssets.pokemonRegions.galar,
    '9': AppAssets.pokemonRegions.paldea,
  };

  static String imageForGeneration(String generation) =>
      generationImages[generation] ?? AppAssets.pokemonRegions.defaultRegion;
}

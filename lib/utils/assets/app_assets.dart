class AppAssets {
  AppAssets._();

  static const bottomMenu = _BottomMenuAssets();
  static const pokemonTypes = _PokemonTypesAssets();
  static const pokemonTypesTransparency = _PokemonTypesTransparencyAssets();
  static const pokemonEvolutions = _PokemonEvolutionsAssets();
  static const pokemonFavorites = _PokemonFavoritesAssets();
  static const pokemonGender = _PokemonGenderAssets();
  static const pokemonCharacteristics = _PokemonCharacteristicsAssets();
  static const pokemonSplash = _PokemonSplashAssets();
  static const pokemonRegions = _PokemonRegionsAssets();
  static const general = _GeneralAssets();
}

class _BottomMenuAssets {
  const _BottomMenuAssets();

  static const _basePath = 'assets/icons/svg/bottom_menu';

  final String pokedex = '$_basePath/pokedex.svg';
  final String pokedexFilled = '$_basePath/pokedex_filled.svg';

  final String regions = '$_basePath/regions.svg';
  final String regionsFilled = '$_basePath/regions_filled.svg';

  final String favorites = '$_basePath/favorites.svg';
  final String favoritesFilled = '$_basePath/favorites_filled.svg';

  final String profile = '$_basePath/profile.svg';
  final String profileFilled = '$_basePath/profile_filled.svg';
}

class _PokemonTypesAssets {
  const _PokemonTypesAssets();
  static const _basePath = 'assets/icons/svg/pokemons/elements';

  final String normal = '$_basePath/normal_element.svg';
  final String fighting = '$_basePath/fighting_element.svg';
  final String flying = '$_basePath/flying_element.svg';
  final String poison = '$_basePath/poison_element.svg';
  final String ground = '$_basePath/ground_element.svg';
  final String rock = '$_basePath/rock_element.svg';
  final String bug = '$_basePath/bug_element.svg';
  final String ghost = '$_basePath/ghost_element.svg';
  final String steel = '$_basePath/steel_element.svg';
  final String fire = '$_basePath/fire_element.svg';
  final String water = '$_basePath/water_element.svg';
  final String grass = '$_basePath/grass_element.svg';
  final String electric = '$_basePath/eletric_element.svg';
  final String psychic = '$_basePath/psychic_element.svg';
  final String ice = '$_basePath/ice_element.svg';
  final String dragon = '$_basePath/dragon_element.svg';
  final String dark = '$_basePath/dark_element.svg';
  final String fairy = '$_basePath/fairy_element.svg';
}

class _PokemonTypesTransparencyAssets {
  const _PokemonTypesTransparencyAssets();
  static const _basePath = 'assets/icons/svg/pokemons/elements_with_transparency';

  final String normal = '$_basePath/normal_element.svg';
  final String fighting = '$_basePath/fighting_element.svg';
  final String flying = '$_basePath/flying_element.svg';
  final String poison = '$_basePath/poison_element.svg';
  final String ground = '$_basePath/ground_element.svg';
  final String rock = '$_basePath/rock_element.svg';
  final String bug = '$_basePath/bug_element.svg';
  final String ghost = '$_basePath/ghost_element.svg';
  final String steel = '$_basePath/steel_element.svg';
  final String fire = '$_basePath/fire_element.svg';
  final String water = '$_basePath/water_element.svg';
  final String grass = '$_basePath/grass_element.svg';
  final String electric = '$_basePath/eletric_element.svg';
  final String psychic = '$_basePath/psychic_element.svg';
  final String ice = '$_basePath/ice_element.svg';
  final String dragon = '$_basePath/dragon_element.svg';
  final String dark = '$_basePath/dark_element.svg';
  final String fairy = '$_basePath/fairy_element.svg';
}

class _PokemonEvolutionsAssets {
  const _PokemonEvolutionsAssets();
  static const _basePath = 'assets/icons/svg/pokemon_species';
  final String arrowDown = '$_basePath/arrow_down_icon.svg';
}

class _PokemonFavoritesAssets {
  const _PokemonFavoritesAssets();
  static const _basePath = 'assets/icons/svg/pokemons/favorite';
  final String favorite = '$_basePath/favorite_icon.svg';
}

class _PokemonGenderAssets {
  const _PokemonGenderAssets();
  static const _baseIconPath = 'assets/icons/svg';
  static const _baseImagePath = 'assets/images/svg';
  final String unknown = '$_baseImagePath/pokemon_information/unknown_gender_bar.svg';
  final String male = '$_baseIconPath/pokemon_species/male_icon.svg';
  final String female = '$_baseIconPath/pokemon_species/female_icon.svg';
}

class _PokemonSplashAssets {
  const _PokemonSplashAssets();
  static const _baseIconPath = 'assets/icons/svg';
  static const _baseImagePath = 'assets/images/svg';

  final String pokeball = '$_baseIconPath/pokeball_icon.svg';
  final String logo = '$_baseImagePath/logos/pokemon_logo.svg';
}

class _PokemonCharacteristicsAssets {
  const _PokemonCharacteristicsAssets();
  static const _basePath = 'assets/icons/svg/pokemon_species';
  final String weight = '$_basePath/weight_icon.svg';
  final String height = '$_basePath/height_icon.svg';
  final String category = '$_basePath/category_icon.svg';
  final String ability = '$_basePath/ability_icon.svg';
}

class _PokemonRegionsAssets {
  const _PokemonRegionsAssets();
  static const _basePath = 'assets/images/png/regions';
  final String defaultRegion = '$_basePath/region_default.webp';
  final String alola = '$_basePath/region_alola.png';
  final String galar = '$_basePath/region_galar.png';
  final String hisui = '$_basePath/region_hisui.png';
  final String hoenn = '$_basePath/region_hoenn.png';
  final String johto = '$_basePath/region_johto.png';
  final String kalos = '$_basePath/region_kalos.png';
  final String kanto = '$_basePath/region_kanto.png';
  final String paldea = '$_basePath/region_paldea.jpg';
  final String sinnoh = '$_basePath/region_sinnoh.png';
  final String unova = '$_basePath/region_unova.png';
}

class _GeneralAssets {
  const _GeneralAssets();
  static const _baseSvgPath = 'assets/icons/svg';
  static const _basePngPath = 'assets/images/png';

  final String pokeball = '$_baseSvgPath/pokedex_filled.svg';
  final String magikarp = '$_basePngPath/others/magikarp.png';
}

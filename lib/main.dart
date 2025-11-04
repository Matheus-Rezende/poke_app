import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_detail.dart';
import 'package:poke_app/routing/router.dart';
import 'package:poke_app/ui/core/themes/theme.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_card.dart';
import 'package:poke_app/ui/pokemon_details/widgets/pokemon_details_header.dart';
import 'main_development.dart' as develop;
import 'main_staging.dart' as staging;

void main() => staging.main();

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PokeApp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: routerConfig(),
    );
  }
}

@Preview(name: 'My PokemonCard')
Widget myCardPokemon() {
  return Column(
    spacing: 16.0,
    children: [
      PokemonCard(
        id: 1,
        name: 'Bulbasaur',
        types: ['grass', 'poison'],
        imagePath: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      ),
      PokemonCard(
        id: 2,
        name: 'Ivysaur',
        types: ['grass', 'poison'],
        imagePath: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      ),
    ],
  );
}

@Preview(name: 'My PokemonHeader')
Widget myHeaderPokemon() {
  return Container();
  // return PokemonDetailsHeader(
  //   pokemon: PokemonDetail(
  //     id: 1,
  //     name: 'Bulbasaur',
  //     types: ['grass', 'poison'],
  //     animatedImage:
  //         'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif',
  //     sound: 'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg',
  //     description: 'Teste',
  //     height: 69,
  //     weight: 80,
  //     category: 'teste',
  //     abilities: ['teste'],
  //     genderRate: -1,
  //   ),
  // );
}

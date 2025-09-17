import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:poke_app/ui/core/themes/theme.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_card.dart';
import 'package:poke_app/ui/menu/widgets/menu_screen.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PokeApp',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: MenuScreen(),
    );
  }
}

@Preview(name: 'My card Pokemon', size: Size(400, 100))
Widget myCardPokemon() {
  return Column(
    spacing: 16.0,
    children: [
      PokemonCard(
        id: 1,
        name: 'Bulbasaur',
        types: ['Grama', 'Veneno'],
        imagePath: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      ),
      PokemonCard(
        id: 2,
        name: 'Ivysaur',
        types: ['Grama', 'Veneno'],
        imagePath: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      ),
    ],
  );
}

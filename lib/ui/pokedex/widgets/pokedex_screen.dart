import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/widgets/pokedex_list.dart';

class PokedexScreen extends StatelessWidget {
  final PokedexViewmodel pokedexViewmodel;
  const PokedexScreen({super.key, required this.pokedexViewmodel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: pokedexViewmodel.load,
          builder: (context, child) {
            if (pokedexViewmodel.load.running) {
              return Center(child: PokeballLoading(isSliverWidget: false));
            }
            if (pokedexViewmodel.load.error) {
              return Center(child: PokemonMessage(title: 'Não foi possível carregar os Pokémons'));
            }
            return child!;
          },
          child: ListenableBuilder(
            listenable: pokedexViewmodel,
            builder: (context, child) {
              return PokedexList(pokedex: pokedexViewmodel.pokedex);
            },
          ),
        ),
      ),
    );
  }
}

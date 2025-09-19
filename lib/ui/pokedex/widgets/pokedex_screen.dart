import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/widgets/pokedex_list.dart';

class PokedexScreen extends StatefulWidget {
  final PokedexViewmodel pokedexViewmodel;
  const PokedexScreen({super.key, required this.pokedexViewmodel});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      widget.pokedexViewmodel.loadMore.execute();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListenableBuilder(
          listenable: widget.pokedexViewmodel,
          builder: (context, child) {
            final pokedexViewmodel = widget.pokedexViewmodel;

            if (pokedexViewmodel.load.running && pokedexViewmodel.pokedex.isEmpty) {
              return const Center(child: PokeballLoading(isSliverWidget: false));
            }

            if (pokedexViewmodel.load.error && pokedexViewmodel.pokedex.isEmpty) {
              return Center(child: PokemonMessage(title: 'Não foi possível carregar os Pokémons'));
            }

            if (!pokedexViewmodel.load.running && pokedexViewmodel.pokedex.isEmpty) {
              return PokemonMessage(
                title: 'Hey treinador, sua pokedex está vazia :(',
                subtitle: 'Vamos procurar novos pokémons para começar a coleção',
              );
            }

            return PokedexList(
              pokedexViewmodel: pokedexViewmodel,
              scrollController: _scrollController,
            );
          },
        ),
      ),
    );
  }
}

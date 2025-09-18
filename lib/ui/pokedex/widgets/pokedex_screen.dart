import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/widgets/pokeball_loading.dart';
import 'package:poke_app/ui/core/widgets/pokemon_message.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/widgets/pokedex_list.dart';

// MUDANÇA 1: Convertido para StatefulWidget para gerenciar o ScrollController.
class PokedexScreen extends StatefulWidget {
  final PokedexViewmodel pokedexViewmodel;
  const PokedexScreen({super.key, required this.pokedexViewmodel});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  // MUDANÇA 2: Criação do ScrollController.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // MUDANÇA 3: Adiciona um 'ouvinte' ao controller para detectar a rolagem.
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    // MUDANÇA 4: Remove o ouvinte e descarta o controller para evitar memory leaks.
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  // MUDANÇA 5: A lógica que dispara o carregamento de mais Pokémon.
  void _onScroll() {
    // Verifica se o usuário está perto do final da lista.
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      // Chama o comando para carregar mais itens no ViewModel.
      // O próprio ViewModel tem uma trava de segurança para não executar várias vezes.
      widget.pokedexViewmodel.loadMore.execute();
      print('object');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // MUDANÇA 6: Um único ListenableBuilder para reagir a todas as mudanças do ViewModel.
        child: ListenableBuilder(
          listenable: widget.pokedexViewmodel,
          builder: (context, child) {
            final pokedexViewmodel = widget.pokedexViewmodel;

            // CASO 1: Carregamento inicial (spinner em tela cheia)
            if (pokedexViewmodel.load.running && pokedexViewmodel.pokedex.isEmpty) {
              return const Center(child: PokeballLoading(isSliverWidget: false));
            }

            // CASO 2: Erro no carregamento inicial
            if (pokedexViewmodel.load.error && pokedexViewmodel.pokedex.isEmpty) {
              return Center(
                child: PokemonMessage(
                  title: 'Não foi possível carregar os Pokémons',
                  // TODO: Adicionar um botão de 'Tentar Novamente' que chama viewModel.load.execute()
                ),
              );
            }

            // CASO 3: Lista vazia após um carregamento bem-sucedido
            if (!pokedexViewmodel.load.running && pokedexViewmodel.pokedex.isEmpty) {
              return PokemonMessage(
                title: 'Hey treinador, sua pokedex está vazia :(',
                subtitle: 'Vamos procurar novos pokémons para começar a coleção',
              );
            }

            // CASO 4: Exibição da lista de Pokémon
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

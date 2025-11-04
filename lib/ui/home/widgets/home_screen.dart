import 'package:flutter/material.dart';
import 'package:poke_app/ui/core/viewmodels/menu_viewmodel.dart';
import 'package:poke_app/ui/core/widgets/custom_bottom_menu/bottom_menu.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/search_pokemon_viewmodel.dart';
import 'package:poke_app/ui/pokedex/viewmodels/types_pokemon_viewmodel.dart';
import 'package:poke_app/ui/pokedex/widgets/pokedex_screen.dart';
import 'package:poke_app/ui/regions/viewmodels/regions_viewmodel.dart';
import 'package:poke_app/ui/regions/widgets/regions_screen.dart';

class HomeScreen extends StatefulWidget {
  final PokedexViewmodel pokedexViewmodel;
  final SearchPokemonViewmodel searchPokemonViewmodel;
  final TypesPokemonViewmodel typesPokemonViewmodel;
  final RegionsViewmodel regionsViewmodel;
  const HomeScreen({
    super.key,
    required this.pokedexViewmodel,
    required this.searchPokemonViewmodel,
    required this.typesPokemonViewmodel,
    required this.regionsViewmodel,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final MenuViewmodel _menuViewmodel;

  List<Widget> get _pages => [
    PokedexScreen(
      pokedexViewmodel: widget.pokedexViewmodel,
      searchPokemonViewmodel: widget.searchPokemonViewmodel,
      typesPokemonViewmodel: widget.typesPokemonViewmodel,
    ),
    RegionsScreen(regionsViewmodel: widget.regionsViewmodel),
    RegionsScreen(regionsViewmodel: widget.regionsViewmodel),
    RegionsScreen(regionsViewmodel: widget.regionsViewmodel),
  ];

  @override
  void initState() {
    super.initState();
    _menuViewmodel = MenuViewmodel();
    _menuViewmodel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _menuViewmodel.removeListener(_onViewModelChanged);
    _menuViewmodel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pages[_menuViewmodel.currentIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomMenu(
              currentIndex: _menuViewmodel.currentIndex,
              onTap: (index) => _menuViewmodel.selectTab(index),
            ),
          ),
        ],
      ),
    );
  }
}

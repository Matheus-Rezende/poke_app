import 'package:flutter/material.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_dev.dart';
import 'package:poke_app/ui/core/viewmodels/menu_viewmodel.dart';
import 'package:poke_app/ui/core/widgets/custom_bottom_menu/bottom_menu.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';
import 'package:poke_app/ui/pokedex/widgets/pokedex_screen.dart';
import 'package:poke_app/ui/regions/widgets/regions_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  late final MenuViewmodel _viewModel;

  static final List<Widget> _pages = [
    PokedexScreen(pokedexViewmodel: PokedexViewmodel(pokedexRepository: PokedexRepositoryDev())),
    RegionsScreen(),
    PokedexScreen(pokedexViewmodel: PokedexViewmodel(pokedexRepository: PokedexRepositoryDev())),
    PokedexScreen(pokedexViewmodel: PokedexViewmodel(pokedexRepository: PokedexRepositoryDev())),
  ];

  @override
  void initState() {
    super.initState();
    _viewModel = MenuViewmodel();
    _viewModel.addListener(_onViewModelChanged);
  }

  @override
  void dispose() {
    _viewModel.removeListener(_onViewModelChanged);
    _viewModel.dispose();
    super.dispose();
  }

  void _onViewModelChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_viewModel.currentIndex],
      floatingActionButton: CustomBottomMenu(
        currentIndex: _viewModel.currentIndex,
        onTap: (index) => _viewModel.selectTab(index),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

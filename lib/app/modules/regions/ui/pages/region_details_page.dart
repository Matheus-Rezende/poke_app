import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/stories/core_store.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/cards/pokemon_card_widget.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/favorites/interactor/stories/favorite_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/search/search_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/search_textfield_widget.dart';
import 'package:poke_app/app/modules/regions/interactor/states/pokemons_region_state.dart';
import 'package:poke_app/app/modules/regions/interactor/stories/regions_store.dart';
import 'package:poke_app/app/modules/regions/interactor/utils/arguments/region_arguments.dart';

class RegionDetailsPage extends StatefulWidget {
  final RegionArguments arguments;
  const RegionDetailsPage({super.key, required this.arguments});

  @override
  State<RegionDetailsPage> createState() => _RegionDetailsPageState();
}

class _RegionDetailsPageState extends State<RegionDetailsPage> {
  final coreStore = Modular.get<CoreStore>();
  final regionsStore = Modular.get<RegionsStore>();
  final favoriteStore = Modular.get<FavoriteStore>();
  final searchPokemonStore = Modular.get<SearchPokemonStore>();

  final String scrollKey = "regions";

  final appTheme = Modular.get<AppTheme>();

  @override
  void initState() {
    super.initState();
    regionsStore.getPokemonsByRegion(url: widget.arguments.url);
    coreStore.initScrollListener(key: scrollKey, isFetchNextPokemons: false);
  }

  @override
  void dispose() {
    coreStore.disposeScrollController(scrollKey);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      body: Observer(
        builder: (context) {
          return CustomScrollView(
            controller: coreStore.getScrollController(scrollKey),
            physics: BouncingScrollPhysics(),
            slivers: [
              _buildAppBar(),
              if (searchPokemonStore.showSearchResult) _buildSearchedPokemon(),
              if (searchPokemonStore.showSearchLoading) _buildLoading(),
              if (searchPokemonStore.showSearchError)
                _buildError(message: searchPokemonStore.messageSearchError, useSliverWidget: true),
              if (regionsStore.showMainList) _buildMainList(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverToBoxAdapter(
      child: CustomAppBarWidget(
        padding: EdgeInsets.only(top: 46.0),
        backgroundColor: appTheme.colors.whiteColor,
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Modular.to.pop(),
                  icon: Icon(Icons.arrow_back, color: appTheme.colors.blackColor),
                ),
                Text(
                  widget.arguments.regionName.toCapitalized,
                  style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SearchTextfieldWidget(
                theme: appTheme,
                focus: coreStore.searchFocusNode,

                onChanged: (value) {
                  searchPokemonStore.changePokemonSearchText(value);
                  if (value.isNotEmpty) {
                    searchPokemonStore.onSearchPokemonChanged(value);
                  } else {
                    regionsStore.showMainList;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Divider(color: appTheme.colors.greyE6Color, height: 1.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchedPokemon() {
    final pokemon = searchPokemonStore.pokemonSearchState.pokemon;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: PokemonCardWidget(
          margin: EdgeInsets.only(top: 16.0),
          id: pokemon.id,
          name: pokemon.name,
          types: pokemon.types,
          imagePath: pokemon.imageUrl,
          theme: appTheme,
          isLoadingPokemonTypes: false,
          onPressed: () => Modular.to.pushNamed(AppRoutes.pokemonDetails(), arguments: pokemon.id.toString()),
          favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemon),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return CustomLoadingWidget();
  }

  Widget _buildError({required String message, required bool useSliverWidget}) {
    return MessageWidget(
      theme: appTheme,
      useSliverWidget: useSliverWidget,
      title: message,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0),
    );
  }

  Widget _buildMainList() {
    if (searchPokemonStore.pokemonSearchText.isEmpty) {
      return Observer(
        builder: (context) {
          return switch (regionsStore.pokemonsRegionState) {
            InitPokemonsRegionState() => Container(),
            LoadingPokemonsRegionState() => CustomLoadingWidget(isSliverWidget: true),
            SuccessPokemonsRegionState(:final pokemons) => SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                if (index < pokemons.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                    child: PokemonCardWidget(
                      theme: appTheme,
                      name: pokemons[index].name,
                      imagePath: pokemons[index].imageUrl,
                      id: pokemons[index].id,
                      types: pokemons[index].types,
                      favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemons[index]),
                      isLoadingPokemonTypes: regionsStore.isLoading,

                      onPressed: () =>
                          Modular.to.pushNamed(AppRoutes.pokemonDetails(), arguments: pokemons[index].name),
                    ),
                  );
                } else {
                  return null;
                }
              }),
            ),
            ErrorPokemonsRegionState(:final message) => MessageWidget(
              theme: appTheme,
              title: message,
              useSliverWidget: true,
              padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0, top: 56.0),
            ),
          };
        },
      );
    } else {
      return SliverToBoxAdapter(child: Container());
    }
  }
}

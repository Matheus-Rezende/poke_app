import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/bottom_sheets/custom_bottom_sheet_widget.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/favorites/interactor/stories/favorite_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_types/types_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/pokemons_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/search/search_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/utils/constants/background_color_type_button.dart';
import 'package:poke_app/app/modules/pokedex/interactor/utils/constants/foreground_color_type_button.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/bottom_sheet_types_widget.dart';
import 'package:poke_app/app/core/ui/widgets/cards/pokemon_card_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/search_textfield_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/loading/shimmer_pokedex_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> with TickerProviderStateMixin {
  final pokemonsStore = Modular.get<PokemonsStore>();
  final typesPokemonStore = Modular.get<TypesPokemonStore>();
  final searchPokemonStore = Modular.get<SearchPokemonStore>();

  final favoriteStore = Modular.get<FavoriteStore>();

  final ScrollController _scrollController = ScrollController();

  final FocusNode _searchFocusNode = FocusNode();
  late AppTheme appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appTheme = Modular.get<AppTheme>();
  }

  @override
  void initState() {
    super.initState();

    pokemonsStore.fetchInitial();

    _scrollController.addListener(() {
      if (!typesPokemonStore.isFilterTypeSelected) {
        if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
          pokemonsStore.fetchNext();
        }
      }
      if (_searchFocusNode.hasFocus) {
        _searchFocusNode.unfocus();
      }
    });
    searchPokemonStore.pokemonSearchText = '';
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      appBar: CustomAppBarWidget(
        widget: SearchTextfieldWidget(
          theme: appTheme,
          focus: _searchFocusNode,
          onChanged: (value) {
            searchPokemonStore.changePokemonSearchText(value);
            if (value.isNotEmpty) {
              searchPokemonStore.onSearchPokemonChanged(value);
            } else {
              pokemonsStore.showMainList;
              typesPokemonStore.changeButtonTypePokemons(text: 'Todos os tipos');
            }
          },
        ),
      ),
      body: Observer(builder: (_) => _buildBody()),
    );
  }

  Widget _buildBody() {
    return switch (pokemonsStore.pokemonState) {
      InitPokemonState() => const SizedBox.shrink(),
      LoadingPokemonState() => const ShimmerPokedexWidget(),
      SuccessPokemonState() => _buildContentList(),
      ErrorPokemonState(:final message) => MessageWidget(
        theme: appTheme,
        title: message,
        useSliverWidget: false,
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0),
      ),
    };
  }

  Widget _buildContentList() {
    return CustomScrollView(
      controller: _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildTypeButton(),
        if (searchPokemonStore.showSearchResult) _buildSearchedPokemon(),
        if (searchPokemonStore.showSearchLoading) _buildLoading(),
        if (searchPokemonStore.showSearchError)
          _buildError(message: searchPokemonStore.messageSearchError, useSliverWidget: true),
        if (pokemonsStore.showMainList) _buildMainList(),
        if (typesPokemonStore.showTypeList) _buildTypeList(),
        if (typesPokemonStore.showTypeError)
          _buildError(message: typesPokemonStore.messageTypeError, useSliverWidget: true),
        if (typesPokemonStore.showTypeLoading) _buildLoading(),
        if (pokemonsStore.isLoadingBottom) _buildLoading(),
        if (!pokemonsStore.hasMore) _buildNoMoreItemsMessage(),
      ],
    );
  }

  Widget _buildTypeButton() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: CustomButtonWidget(
          title: typesPokemonStore.textButtonTypePokemons,
          titleStyle: appTheme.typography.poppins14px().copyWith(
            color: ForegroundColorTypeButton().colors(typesPokemonStore.textButtonTypePokemons),
            fontWeight: FontWeight.w600,
          ),
          borderRadius: 50.0,
          padding: 0.0,
          height: 42.0,
          backgroundColor: BackgroundColorTypeButton().colors(typesPokemonStore.textButtonTypePokemons),
          onPressed: () => _showBottomSheet(context),
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
          onPressed: () => Modular.to.pushNamed(AppRoutes.pokemonDetails(), arguments: pokemon.id.toString()),
          favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemon),
        ),
      ),
    );
  }

  Widget _buildMainList() {
    if (searchPokemonStore.pokemonSearchText.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final pokemon = pokemonsStore.pokemons[index];
            return PokemonCardWidget(
              id: pokemon.id,
              name: pokemon.name,
              types: pokemon.types,
              imagePath: pokemon.imageUrl,
              theme: appTheme,
              margin: EdgeInsets.symmetric(vertical: 6.0),
              onPressed: () =>
                  Modular.to.pushNamed(AppRoutes.pokemonDetails(), arguments: pokemon.id.toString()),
              favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemon),
            );
          }, childCount: pokemonsStore.pokemons.length),
        ),
      );
    } else {
      return SliverToBoxAdapter(child: Container());
    }
  }

  Widget _buildTypeList() {
    final pokemons = typesPokemonStore.pokemonTypeState.pokemons;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
          final pokemon = pokemons[index];
          return PokemonCardWidget(
            id: pokemon.id,
            name: pokemon.name,
            types: pokemon.types,
            imagePath: pokemon.imageUrl,
            theme: appTheme,
            onPressed: () =>
                Modular.to.pushNamed(AppRoutes.pokemonDetails(), arguments: pokemon.id.toString()),
            favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemon),
          );
        }, childCount: pokemons.length),
      ),
    );
  }

  Widget _buildError({required String message, required bool useSliverWidget}) {
    return MessageWidget(
      theme: appTheme,
      useSliverWidget: useSliverWidget,
      title: message,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 80.0),
    );
  }

  Widget _buildLoading() {
    return CustomLoadingWidget();
  }

  Widget _buildNoMoreItemsMessage() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Chegamos ao final da lista de Pokémons',
            textAlign: TextAlign.center,
            style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    CustomBottomSheetWidget.show(
      context: context,
      title: 'Selecione o tipo',
      height: 700.0,
      widget: BottomSheetTypesWidget(
        theme: appTheme,
        typesPokemonStore: typesPokemonStore,
        pokemonsStore: pokemonsStore,
      ),
    );
  }
}

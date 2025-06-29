import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/bottom_sheets/custom_bottom_sheet_widget.dart';
import 'package:poke_app/app/core/ui/widgets/buttons/custom_button_widget.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokedex_store.dart';
import 'package:poke_app/app/modules/pokedex/interactor/utils/constants/background_color_type_button.dart';
import 'package:poke_app/app/modules/pokedex/interactor/utils/constants/foreground_color_type_button.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/bottom_sheet_types_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/pokemon_card_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/search_textfield_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/shimmer_pokedex_widget.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> with TickerProviderStateMixin {
  final store = Modular.get<PokedexStore>();
  final ScrollController _scrollController = ScrollController();
  late final AnimationController _animationController;
  late final Animation<double> _animationLoading;
  late AppTheme appTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    appTheme = Modular.get<AppTheme>();
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: const Duration(seconds: 2), vsync: this)
      ..repeat(reverse: true);

    _animationLoading = CurvedAnimation(parent: _animationController, curve: Curves.elasticInOut);

    store.fetchInitial();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        store.fetchNext();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      body: Observer(builder: (_) => _buildBody()),
    );
  }

  Widget _buildBody() {
    return switch (store.pokemonState) {
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
      controller: store.isFilterTypeSelected ? null : _scrollController,
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildAppBar(),
        if (store.showTypeButton) _buildTypeButton(),
        if (store.showSearchResult) _buildSearchedPokemon(),
        if (store.showSearchLoading) _buildLoading(),
        if (store.showSearchError) _buildError(message: store.messageSearchError, useSliverWidget: true),
        if (store.showMainList) _buildMainList(),
        if (store.showTypeList) _buildTypeList(),
        if (store.showTypeError) _buildError(message: store.messageTypeError, useSliverWidget: true),
        if (store.showTypeLoading) _buildLoading(),
        if (store.isLoadingBottom) _buildLoading(),
        if (!store.hasMore) _buildNoMoreItemsMessage(),
      ],
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      toolbarHeight: 88.0,
      backgroundColor: appTheme.colors.whiteColor,
      surfaceTintColor: appTheme.colors.whiteColor,
      title: SearchTextfieldWidget(
        theme: appTheme,
        onChanged: (value) {
          store.changePokemonSearchText(value);
          if (value.isNotEmpty) {
            store.onSearchPokemonChanged(value);
          } else {
            store.fetchInitial();
            store.changeButtonTypePokemons(text: 'Todos os tipos');
          }
        },
      ),
      pinned: true,
    );
  }

  Widget _buildTypeButton() {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: CustomButtonWidget(
          title: store.textButtonTypePokemons,
          titleStyle: appTheme.typography.poppins14px().copyWith(
            color: ForegroundColorTypeButton().colors(store.textButtonTypePokemons),
            fontWeight: FontWeight.w600,
          ),
          borderRadius: 50.0,
          padding: 0.0,
          height: 42.0,
          backgroundColor: BackgroundColorTypeButton().colors(store.textButtonTypePokemons),
          onPressed: () => _showBottomSheet(context),
        ),
      ),
    );
  }

  Widget _buildSearchedPokemon() {
    final pokemon = store.pokemonSearchState.pokemon;
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      sliver: SliverToBoxAdapter(
        child: PokemonCardWidget(
          id: pokemon.id,
          name: pokemon.name,
          types: pokemon.types,
          imagePath: pokemon.imageUrl,
          theme: appTheme,
          animationLoading: _animationLoading,
        ),
      ),
    );
  }

  Widget _buildMainList() {
    if (store.pokemonSearchText.isEmpty) {
      return SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final pokemon = store.pokemons[index];
            return PokemonCardWidget(
              id: pokemon.id,
              name: pokemon.name,
              types: pokemon.types,
              imagePath: pokemon.imageUrl,
              theme: appTheme,
              animationLoading: _animationLoading,
            );
          }, childCount: store.pokemons.length),
        ),
      );
    } else {
      return SliverToBoxAdapter(child: Container());
    }
  }

  Widget _buildTypeList() {
    final pokemons = store.pokemonTypeState.pokemons;
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
            animationLoading: _animationLoading,
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
    return CustomLoadingWidget(animation: _animationLoading);
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
      widget: BottomSheetTypesWidget(theme: appTheme, store: store),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/cards/pokemon_card_widget.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/favorites/interactor/stories/favorite_store.dart';
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
  final regionsStore = Modular.get<RegionsStore>();
  final favoriteStore = Modular.get<FavoriteStore>();

  final appTheme = Modular.get<AppTheme>();

  @override
  void initState() {
    super.initState();
    regionsStore.getPokemonsByRegion(url: widget.arguments.url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.colors.whiteColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            CustomAppBarWidget(
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
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Divider(color: appTheme.colors.greyE6Color, height: 1.0),
                  ),
                  Observer(
                    builder: (context) {
                      return switch (regionsStore.pokemonsRegionState) {
                        InitPokemonsRegionState() => Container(),
                        LoadingPokemonsRegionState() => CustomLoadingWidget(isSliverWidget: false),
                        SuccessPokemonsRegionState(:final pokemons) => Column(
                          children: List.generate(pokemons.length, (index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                              child: PokemonCardWidget(
                                theme: appTheme,
                                name: pokemons[index].name,
                                imagePath: pokemons[index].imageUrl,
                                id: pokemons[index].id,
                                types: pokemons[index].types,
                                favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemons[index]),

                                onPressed: () => Modular.to.pushNamed(
                                  AppRoutes.pokemonDetails(),
                                  arguments: pokemons[index].name,
                                ),
                              ),
                            );
                          }),
                        ),
                        ErrorPokemonsRegionState(:final message) => MessageWidget(
                          theme: appTheme,
                          title: message,
                          useSliverWidget: false,
                          padding: EdgeInsetsGeometry.only(left: 16.0, right: 16.0, top: 56.0),
                        ),
                      };
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

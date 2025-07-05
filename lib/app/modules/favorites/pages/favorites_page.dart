import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/routes/app_routes.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/app_bar/custom_app_bar_widget.dart';
import 'package:poke_app/app/core/ui/widgets/messages/message_widget.dart';
import 'package:poke_app/app/modules/favorites/interactor/stories/favorite_store.dart';
import 'package:poke_app/app/core/ui/widgets/cards/pokemon_card_widget.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteStore = Modular.get<FavoriteStore>();
    final appTheme = Modular.get<AppTheme>();

    return Observer(
      builder: (context) {
        return Scaffold(
          backgroundColor: appTheme.colors.whiteColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              CustomAppBarWidget(
                padding: EdgeInsets.only(top: 54.0),
                isSliverWidget: true,
                widget: Column(
                  spacing: 8.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Favoritos',
                        style: appTheme.typography.poppins18px().copyWith(fontWeight: FontWeight.w600),
                      ),
                    ),
                    Divider(color: appTheme.colors.greyE6Color),
                  ],
                ),
              ),
            ],
            body: favoriteStore.pokemonsFavorites.isEmpty
                ? MessageWidget(
                    theme: appTheme,
                    useSliverWidget: false,
                    title: 'Você não favoritou nenhum Pokémon :( ',
                    padding: EdgeInsetsGeometry.symmetric(horizontal: 16.0),
                    subtitle:
                        'Clique no ícone de coração dos seus pokémons favoritos e eles aparecerão aqui.',
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: List.generate(favoriteStore.pokemonsFavorites.length, (index) {
                        final pokemon = favoriteStore.pokemonsFavorites[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                          child: Dismissible(
                            key: Key(pokemon.name),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              padding: EdgeInsets.only(right: 32.0),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                color: appTheme.colors.redColor,
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: SvgPicture.asset('assets/icons/svg/pokemons/favorite/trash_icon.svg'),
                            ),
                            onDismissed: (direction) {
                              favoriteStore.removeFavorite(index);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    '${pokemon.name.toCapitalized} removido',
                                    style: appTheme.typography.poppins18px(),
                                  ),
                                ),
                              );
                            },
                            child: PokemonCardWidget(
                              isFavoritePage: true,
                              id: pokemon.id,
                              name: pokemon.name,
                              types: pokemon.types,
                              imagePath: pokemon.imageUrl,
                              theme: appTheme,
                              onPressed: () => Modular.to.pushNamed(
                                AppRoutes.pokemonDetails(),
                                arguments: pokemon.id.toString(),
                              ),
                              favoriteOnPressed: () => favoriteStore.toggleFavorite(pokemon),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
          ),
        );
      },
    );
  }
}

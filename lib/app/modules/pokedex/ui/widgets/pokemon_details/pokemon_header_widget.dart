import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/interactor/utils/type_colors/pokemon_type_colors.dart';
import 'package:poke_app/app/core/interactor/utils/type_icons/pokemon_type_transparency_icons.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/clippers/bottom_circular_clipper.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/stories/pokemons/details/pokemon_informations/informations_pokemon_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/type_badge_widget.dart';

class PokemonHeaderWidget extends StatelessWidget {
  final InformationsPokemonStore store;
  const PokemonHeaderWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();

    return SliverToBoxAdapter(
      child: Observer(
        builder: (context) {
          if (store.pokemonDetailsState is SuccessPokemonDetailsState) {
            _playPokemonAudio(store.pokemonDetailsState.pokemon.soundPath ?? '');
          }
          return switch (store.pokemonDetailsState) {
            InitPokemonDetailsState() => Container(),
            LoadingPokemonDetailsState() => Container(),
            SuccessPokemonDetailsState(:final pokemon) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Column(
                      children: [
                        ClipPath(
                          clipper: BottomCircularClipper(),
                          child: Container(
                            height: 307.0,
                            color: typeColors[pokemon.types![0]]!.withValues(alpha: 0.8),
                            child: Center(
                              child: SvgPicture.asset(
                                typeIconsTransparencyPath[pokemon.types![0]] ?? '',
                                height: 200.0,
                                width: 200.0,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.0),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40.0, horizontal: 24.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () => Modular.to.pop(),
                              child: SizedBox(
                                height: 24.0,
                                width: 24.0,
                                child: Icon(Icons.chevron_left, color: appTheme.colors.whiteColor),
                              ),
                            ),
                            Icon(Icons.favorite_border, color: appTheme.colors.whiteColor),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsGeometry.only(top: 176.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () => _playPokemonAudio(pokemon.soundPath ?? ''),
                          splashColor: Colors.transparent,
                          child: CachedNetworkImage(
                            imageUrl: pokemon.gifPath ?? '',
                            height: 154.0,
                            filterQuality: FilterQuality.none,
                            fit: BoxFit.fill,
                            placeholder: (_, __) => SvgPicture.asset(
                              'assets/icons/svg/bottom_menu/pokedex_filled.svg',
                              height: 40.0,
                            ),

                            errorWidget: (_, __, ___) => Column(
                              spacing: 16.0,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/svg/bottom_menu/pokedex_filled.svg',
                                  height: 40.0,
                                ),
                                Text(
                                  'Imagem não encontrada',
                                  style: appTheme.typography.poppins14px().copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    pokemon.name!.toCapitalized,
                    style: appTheme.typography.poppins32px().copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0),
                  child: Text(
                    'N°${pokemon.id.toString().padLeft(3, '0')}',
                    style: appTheme.typography.poppins16px().copyWith(
                      fontWeight: FontWeight.w500,
                      color: appTheme.colors.blackColor.withValues(alpha: 0.7),
                    ),
                  ),
                ),
                SizedBox(height: 24.0),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0),
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 4.0,
                    children: pokemon.types!
                        .map((type) => TypeBadgeWidget(type: type, theme: appTheme))
                        .toList(),
                  ),
                ),
                SizedBox(height: 24.0),
              ],
            ),
            ErrorPokemonDetailsState(:final message) => Text(message),
          };
        },
      ),
    );
  }

  Future<void> _playPokemonAudio(String audioUrl) async {
    final player = AudioPlayer();

    try {
      await player.stop();
      await player.seek(Duration.zero);
      await player.setUrl(audioUrl);
      await player.play();
    } on PlayerException catch (e) {
      print('[Erro no áudio]: $e');
    } finally {
      await player.dispose(); // sempre liberar recursos
    }
  }
}

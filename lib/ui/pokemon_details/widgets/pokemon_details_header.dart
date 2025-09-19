import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/ui/core/widgets/clippers/bottom_circular_clipper.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_type_badge.dart';
import 'package:poke_app/ui/core/widgets/pokemon_type/pokemon_type_colors.dart';
import 'package:poke_app/ui/core/widgets/pokemon_type/pokemon_type_transparency_icons.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';

class PokemonDetailsHeader extends StatefulWidget {
  final PokemonDetail pokemon;
  const PokemonDetailsHeader({super.key, required this.pokemon});

  @override
  State<PokemonDetailsHeader> createState() => _PokemonDetailsHeaderState();
}

class _PokemonDetailsHeaderState extends State<PokemonDetailsHeader> {
  final _log = Logger('PokedexViewModel');

  @override
  void initState() {
    super.initState();
    _playPokemonAudio(widget.pokemon.sound);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 24.0,
      children: [
        Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: BottomCircularClipper(),
                  child: Container(
                    height: 307.0,
                    color: pokemonTypeColors[widget.pokemon.types[0]]!.withValues(alpha: 0.8),
                    child: Center(
                      child: SvgPicture.asset(
                        pokemonTypeTransparencyIcons[widget.pokemon.types[0]] ?? '',
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
                padding: const EdgeInsets.fromLTRB(4.0, 40.0, 24.0, 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.chevron_left, color: AppColors.white1),
                    ),
                    InkWell(
                      onTap: () {},
                      child: SvgPicture.asset(
                        'assets/icons/svg/pokemons/favorite/favorite_icon.svg',
                        // isPokemonFavorite
                        //     ? 'assets/icons/svg/pokemons/favorite/favorite_filled_icon.svg'
                        //     : 'assets/icons/svg/pokemons/favorite/favorite_icon.svg',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.only(top: 176.0),
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () => _playPokemonAudio(widget.pokemon.sound),
                  splashColor: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: widget.pokemon.animatedGif,
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
                        Container(
                          padding: EdgeInsets.all(4.0),
                          margin: EdgeInsets.symmetric(horizontal: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: AppColors.grey1.withValues(alpha: 0.6),
                          ),
                          child: Text(
                            'Imagem não encontrada',
                            style: Theme.of(context).textTheme.labelSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black1,
                              fontSize: 11.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                widget.pokemon.name.toCapitalized,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0),
              child: Text(
                'N°${widget.pokemon.id.toString().padLeft(3, '0')}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0),
          child: Wrap(
            spacing: 6.0,
            runSpacing: 4.0,
            children: widget.pokemon.types.map((type) => PokemonTypeBadge(type: type)).toList(),
          ),
        ),
      ],
    );
  }

  Future<void> _playPokemonAudio(String audioUrl) async {
    final player = AudioPlayer();

    try {
      await player.stop();
      await player.seek(Duration.zero);
      await player.setUrl(audioUrl);
      await player.play();
    } on PlayerException catch (error) {
      _log.warning('Erro no áudio: $error');
    } finally {
      await player.dispose();
    }
  }
}

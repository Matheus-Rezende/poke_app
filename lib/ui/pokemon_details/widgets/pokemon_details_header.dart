import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:just_audio/just_audio.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/ui/core/widgets/clippers/bottom_circular_clipper.dart';
import 'package:poke_app/ui/core/widgets/pokemon_cards/pokemon_type_badge.dart';
import 'package:poke_app/ui/core/widgets/pokemon_error_image.dart';
import 'package:poke_app/utils/assets/app_assets.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_colors.dart';
import 'package:poke_app/utils/constants/pokemon_type/pokemon_type_transparency_icons.dart';
import 'package:poke_app/ui/pokemon_details/viewmodels/pokemon_details_viewmodel.dart';
import 'package:poke_app/utils/extensions/string_casting_extension.dart';

class PokemonDetailsHeader extends StatefulWidget {
  final PokemonDetailsViewmodel pokemonDetailsViewmodel;
  const PokemonDetailsHeader({super.key, required this.pokemonDetailsViewmodel});

  @override
  State<PokemonDetailsHeader> createState() => _PokemonDetailsHeaderState();
}

class _PokemonDetailsHeaderState extends State<PokemonDetailsHeader> {
  final _log = Logger('PokedexViewModel');

  @override
  void initState() {
    super.initState();
    _playPokemonAudio(widget.pokemonDetailsViewmodel.pokemon.sound);
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
                    color: pokemonTypeColors[widget.pokemonDetailsViewmodel.pokemon.types[0]]!
                        .withValues(alpha: 0.8),
                    child: Center(
                      child: SvgPicture.asset(
                        pokemonTypeTransparencyIcons[widget
                                .pokemonDetailsViewmodel
                                .pokemon
                                .types[0]] ??
                            '',
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
                        AppAssets.pokemonFavorites.favorite,
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
                  onTap: () => _playPokemonAudio(widget.pokemonDetailsViewmodel.pokemon.sound),
                  splashColor: Colors.transparent,
                  child: CachedNetworkImage(
                    imageUrl: widget.pokemonDetailsViewmodel.pokemon.animatedImage,
                    height: 154.0,
                    filterQuality: FilterQuality.none,
                    fit: BoxFit.fill,
                    placeholder: (_, __) =>
                        SvgPicture.asset(AppAssets.general.pokeball, height: 40.0),

                    errorWidget: (_, __, ___) => Column(
                      spacing: 16.0,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: PokemonErrorImage.content(context),
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
                widget.pokemonDetailsViewmodel.pokemon.name.toCapitalized,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Padding(
              padding: EdgeInsetsGeometry.symmetric(horizontal: 12.0),
              child: Text(
                widget.pokemonDetailsViewmodel.formattedNumber,
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
            children: widget.pokemonDetailsViewmodel.pokemon.types
                .map((type) => PokemonTypeBadge(type: type))
                .toList(),
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

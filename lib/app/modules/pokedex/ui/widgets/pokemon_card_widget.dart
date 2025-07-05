import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:poke_app/app/core/interactor/utils/type_colors/pokemon_type_colors.dart';
import 'package:poke_app/app/core/interactor/utils/type_icons/pokemon_type_transparency_icons.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/modules/favorites/interactor/stories/favorite_store.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/type_badge_widget.dart';

class PokemonCardWidget extends StatelessWidget {
  final int id;
  final String name;
  final List<String> types;
  final String imagePath;
  final AppTheme theme;
  final VoidCallback? onPressed;
  final VoidCallback? favoriteOnPressed;

  const PokemonCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.types,
    required this.imagePath,
    required this.theme,
    this.onPressed,
    this.favoriteOnPressed,
  });

  @override
  Widget build(BuildContext context) {
    final primaryType = types.isNotEmpty ? types[0] : 'normal';
    final primaryColor = typeColors[primaryType] ?? Colors.grey;
    final primaryIcon = typeIconsTransparencyPath[primaryType] ?? '';
    final favoriteStore = Modular.get<FavoriteStore>();

    return Container(
      margin: const EdgeInsets.only(top: 12.0),
      decoration: BoxDecoration(color: primaryColor.withAlpha(51), borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  bottomLeft: Radius.circular(15.0),
                ),
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'N°${id.toString().padLeft(3, '0')}',
                        style: theme.typography.poppins12px().copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colors.grey33Color,
                        ),
                      ),
                      Text(
                        name.toCapitalized,
                        style: theme.typography.poppins21px().copyWith(
                          fontWeight: FontWeight.w500,
                          color: theme.colors.blackColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: Row(
                          children: types
                              .map(
                                (type) => TypeBadgeWidget(
                                  type: type,
                                  theme: theme,
                                  margin: const EdgeInsets.only(right: 8.0),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Observer(
            builder: (context) {
              favoriteStore.isFavorite(id);
              return GestureDetector(
                onTap: favoriteOnPressed,
                child: Container(
                  width: 126.0,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: Container(
                          width: 32.0,
                          height: 32.0,
                          decoration: BoxDecoration(
                            color: theme.colors.whiteColor.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(favoriteStore.getFavoriteImagePath(id)),
                        ),
                      ),

                      Align(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: SvgPicture.asset(
                            primaryIcon,
                            width: 94,
                            height: 94,
                            colorFilter: ColorFilter.mode(
                              theme.colors.whiteColor.withAlpha(128),
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24.0),
                          child: CachedNetworkImage(
                            imageUrl: imagePath,
                            height: 80.0,
                            filterQuality: FilterQuality.none,
                            placeholder: (_, __) => CustomLoadingWidget(isSliverWidget: false),
                            errorWidget: (_, __, ___) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/svg/bottom_menu/pokedex_filled.svg',
                                  height: 40.0,
                                ),
                                Text(
                                  'Imagem não encontrada',
                                  style: theme.typography.poppins12px().copyWith(fontWeight: FontWeight.w700),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

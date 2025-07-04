import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_app/app/core/interactor/utils/extensions/string_casing_extension.dart';
import 'package:poke_app/app/core/interactor/utils/type_colors/pokemon_type_colors.dart';
import 'package:poke_app/app/core/interactor/utils/type_icons/pokemon_type_transparency_icons.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/core/ui/widgets/loadings/custom_loading_widget.dart';
import 'package:poke_app/app/modules/pokedex/ui/widgets/type_badge_widget.dart';

class PokemonEvolutionCardWidget extends StatelessWidget {
  final int id;
  final String name;
  final List<String> types;
  final String imagePath;
  final AppTheme theme;
  const PokemonEvolutionCardWidget({
    super.key,
    required this.id,
    required this.name,
    required this.types,
    required this.imagePath,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final primaryType = types.isNotEmpty ? types[0] : 'normal';
    final primaryColor = typeColors[primaryType] ?? Colors.grey;
    final primaryIcon = typeIconsTransparencyPath[primaryType] ?? '';
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90.0),
        border: Border.all(color: theme.colors.greyE6Color),
      ),
      child: Row(
        spacing: 12.0,
        children: [_buildImage(primaryColor, primaryIcon), _buildInfo(), _buildSpace()],
      ),
    );
  }

  Widget _buildImage(Color backgroundColor, String iconPath) {
    return Flexible(
      flex: 2,
      child: Container(
        height: 74.0,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(90.0)),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: SvgPicture.asset(
                iconPath,

                colorFilter: ColorFilter.mode(theme.colors.whiteColor.withAlpha(128), BlendMode.srcIn),
              ),
            ),
            CachedNetworkImage(
              imageUrl: imagePath,
              height: 60.0,
              width: 90.0,
              filterQuality: FilterQuality.none,
              placeholder: (_, __) => CustomLoadingWidget(isSliverWidget: false),
              errorWidget: (_, __, ___) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [SvgPicture.asset('assets/icons/svg/bottom_menu/pokedex_filled.svg', height: 40.0)],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    return Flexible(
      flex: 4,
      child: Column(
        spacing: 4.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            name.toCapitalized,
            style: theme.typography.poppins16px().copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colors.grey1AColor,
            ),
          ),
          Text(
            'N°${id.toString().padLeft(3, '0')}',
            style: theme.typography.poppins12px().copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colors.grey33Color,
            ),
          ),
          SizedBox(
            height: 16.0,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: types.length == 1 ? 1 : 2,
                childAspectRatio: types.length == 1 ? 15.0 : 7.0,
                crossAxisSpacing: 8.0,
              ),
              itemCount: types.length,
              itemBuilder: (context, index) => TypeBadgeWidget(
                type: types[index],
                theme: theme,
                isSimpleBadge: true,
                padding: EdgeInsets.all(2.0),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpace() {
    return Flexible(child: Container());
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/app/modules/menu/interactor/stories/custom_bottom_menu_store.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/favorites/pages/favorites_page.dart';
import 'package:poke_app/app/modules/pokedex/ui/pages/pokedex_page.dart';
import 'package:poke_app/app/modules/profile/pages/profile_page.dart';
import 'package:poke_app/app/modules/regions/pages/regions_page.dart';

class CustomBottomMenuWidget extends StatelessWidget {
  const CustomBottomMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Modular.get<AppTheme>();
    final store = Modular.get<CustomBottomMenuStore>();

    final List<Widget> pages = const [PokedexPage(), RegionsPage(), FavoritesPage(), ProfilePage()];

    SvgPicture buildIconsBottomMenu(bool isSelected, String iconSelectedPath, String iconUnselectedPath) {
      if (isSelected) {
        return SvgPicture.asset(iconSelectedPath);
      } else {
        return SvgPicture.asset(iconUnselectedPath);
      }
    }

    Widget buildCustomBottomMenu() {
      return SafeArea(
        child: Container(
          height: 72,
          padding: EdgeInsets.only(bottom: 4.0),
          decoration: BoxDecoration(
            color: appTheme.colors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: appTheme.colors.blackColor.withValues(alpha: 0.1),
                blurRadius: 16,
                // offset: Offset(7, 0),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(4, (index) {
              SvgPicture svgIcon;
              String label;

              final isSelected = index == store.selectedIndex;

              switch (index) {
                case 0:
                  svgIcon = buildIconsBottomMenu(
                    isSelected,
                    'assets/icons/svg/bottom_menu/pokedex_filled.svg',
                    'assets/icons/svg/bottom_menu/pokedex.svg',
                  );
                  label = isSelected ? 'Pokedéx' : '';
                  break;
                case 1:
                  svgIcon = buildIconsBottomMenu(
                    isSelected,
                    'assets/icons/svg/bottom_menu/regions_filled.svg',
                    'assets/icons/svg/bottom_menu/regions.svg',
                  );
                  label = isSelected ? 'Regiões' : '';
                  break;
                case 2:
                  svgIcon = buildIconsBottomMenu(
                    isSelected,
                    'assets/icons/svg/bottom_menu/favorites_filled.svg',
                    'assets/icons/svg/bottom_menu/favorites.svg',
                  );
                  label = isSelected ? 'Favoritos' : '';
                  break;
                case 3:
                  svgIcon = buildIconsBottomMenu(
                    isSelected,
                    'assets/icons/svg/bottom_menu/profile_filled.svg',
                    'assets/icons/svg/bottom_menu/profile.svg',
                  );
                  label = isSelected ? 'Conta' : '';
                  break;
                default:
                  svgIcon = buildIconsBottomMenu(
                    isSelected,
                    'assets/icons/svg/bottom_menu/pokedex_filled.svg',
                    'assets/icons/svg/bottom_menu/pokedex.svg',
                  );
                  label = '';
              }

              return InkWell(
                onTap: () => store.onItemTapped(index),
                child: Column(
                  mainAxisAlignment: isSelected ? MainAxisAlignment.center : MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    svgIcon,
                    Text(
                      label,
                      style: appTheme.typography.poppins12px().copyWith(
                        fontWeight: FontWeight.w500,
                        color: appTheme.colors.backgroundBlueColor,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      );
    }

    return Observer(
      builder: (context) {
        return Scaffold(body: pages[store.selectedIndex], bottomNavigationBar: buildCustomBottomMenu());
      },
    );
  }
}

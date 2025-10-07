import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';
import 'package:poke_app/utils/assets/app_assets.dart';

class BottomMenuItemData {
  final String selectedIconPath;
  final String unselectedIconPath;
  final String label;

  const BottomMenuItemData({
    required this.selectedIconPath,
    required this.unselectedIconPath,
    required this.label,
  });
}

class CustomBottomMenu extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomMenu({super.key, required this.currentIndex, required this.onTap});

  static final List<BottomMenuItemData> _menuItems = [
    BottomMenuItemData(
      selectedIconPath: AppAssets.bottomMenu.pokedexFilled,
      unselectedIconPath: AppAssets.bottomMenu.pokedex,
      label: 'Pokedéx',
    ),
    BottomMenuItemData(
      selectedIconPath: AppAssets.bottomMenu.regionsFilled,
      unselectedIconPath: AppAssets.bottomMenu.regions,
      label: 'Regiões',
    ),
    BottomMenuItemData(
      selectedIconPath: AppAssets.bottomMenu.favoritesFilled,
      unselectedIconPath: AppAssets.bottomMenu.favorites,
      label: 'Favoritos',
    ),
    BottomMenuItemData(
      selectedIconPath: AppAssets.bottomMenu.profileFilled,
      unselectedIconPath: AppAssets.bottomMenu.profile,
      label: 'Conta',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkTheme = theme.brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        height: 72,
        margin: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onSecondary,
          borderRadius: BorderRadius.circular(36.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_menuItems.length, (index) {
            final item = _menuItems[index];
            final isSelected = index == currentIndex;

            return InkWell(
              onTap: () => onTap(index),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: SvgPicture.asset(
                        isSelected ? item.selectedIconPath : item.unselectedIconPath,
                        key: ValueKey(isSelected ? item.selectedIconPath : item.unselectedIconPath),
                      ),
                    ),

                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: isSelected ? 18 : 0,
                      child: Text(
                        item.label,
                        overflow: TextOverflow.clip,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: isDarkTheme ? AppColors.white1 : AppColors.darkblue,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

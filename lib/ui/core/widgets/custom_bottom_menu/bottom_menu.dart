import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:poke_app/ui/core/themes/colors.dart';

// A classe de dados permanece a mesma.
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

  static const List<BottomMenuItemData> _menuItems = [
    BottomMenuItemData(
      selectedIconPath: 'assets/icons/svg/bottom_menu/pokedex_filled.svg',
      unselectedIconPath: 'assets/icons/svg/bottom_menu/pokedex.svg',
      label: 'Pokedéx',
    ),
    BottomMenuItemData(
      selectedIconPath: 'assets/icons/svg/bottom_menu/regions_filled.svg',
      unselectedIconPath: 'assets/icons/svg/bottom_menu/regions.svg',
      label: 'Regiões',
    ),
    BottomMenuItemData(
      selectedIconPath: 'assets/icons/svg/bottom_menu/favorites_filled.svg',
      unselectedIconPath: 'assets/icons/svg/bottom_menu/favorites.svg',
      label: 'Favoritos',
    ),
    BottomMenuItemData(
      selectedIconPath: 'assets/icons/svg/bottom_menu/profile_filled.svg',
      unselectedIconPath: 'assets/icons/svg/bottom_menu/profile.svg',
      label: 'Conta',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // A estrutura externa do menu permanece a mesma.
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
              customBorder: const CircleBorder(),
              highlightColor: Colors.transparent,
              // splashColor: AppColors.darkblue.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // MUDANÇA 1: Animação de fade para o ícone.
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      child: SvgPicture.asset(
                        // O `key` é essencial para o AnimatedSwitcher saber qual widget é qual.
                        isSelected ? item.selectedIconPath : item.unselectedIconPath,
                        key: ValueKey(isSelected ? item.selectedIconPath : item.unselectedIconPath),
                        //colorFilter: ColorFilter.mode(backgroundColor, BlendMode.srcIn),
                      ),
                    ),

                    // MUDANÇA 2: Animação de altura para o texto do rótulo.
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeInOut,
                      height: isSelected ? 18 : 0, // O container "cresce" para mostrar o texto.
                      child: ClipRect(
                        // Impede que o texto seja visível enquanto o container encolhe.
                        child: Text(
                          item.label,
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            color: AppColors.darkblue,
                            fontWeight: FontWeight.w600,
                          ),
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

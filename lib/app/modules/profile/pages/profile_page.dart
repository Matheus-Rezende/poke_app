import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/stories/core_store.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final coreStore = Modular.get<CoreStore>();
    final appTheme = Modular.get<AppTheme>();
    return Scaffold(
      body: Observer(
        builder: (context) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tema',
                    style: appTheme.typography.poppins16px().copyWith(fontWeight: FontWeight.w600),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(coreStore.isLight ? 'Claro' : 'Escuro', style: appTheme.typography.poppins14px()),

                      Switch.adaptive(
                        activeColor: appTheme.colors.grey66Color,
                        inactiveThumbColor: appTheme.colors.grey33Color,
                        inactiveThumbImage: AssetImage('assets/icons/png/theme/light_theme_icon.png'),
                        activeThumbImage: AssetImage('assets/icons/png/theme/dark_theme_icon.png'),
                        value: !coreStore.isLight,
                        onChanged: (value) => coreStore.changeTheme(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

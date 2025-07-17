import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/stories/core_store.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/notifications/interactor/stories/notifications_store.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  final coreStore = Modular.get<CoreStore>();
  final notificationsStore = Modular.get<NotificationsStore>();
  final appTheme = Modular.get<AppTheme>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    notificationsStore.loadNotifications(); // já carrega no início
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      notificationsStore.updateNotificationPermission();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12.0,
            children: [
              Text(
                'Notificações',
                style: appTheme.typography.poppins16px().copyWith(fontWeight: FontWeight.w600),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      spacing: 6.0,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Atualizações na pokédex',
                          style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Novos Pokémons, habilidades, informações, etc.',
                          style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Observer(
                    builder: (context) {
                      return Switch.adaptive(
                        activeColor: appTheme.colors.grey66Color,
                        inactiveThumbColor: appTheme.colors.grey33Color,
                        inactiveThumbImage: AssetImage('assets/icons/png/notifications/cancel_icon.png'),
                        activeThumbImage: AssetImage('assets/icons/png/notifications/check_icon.png'),
                        value:
                            !notificationsStore.isNotificationsDisabled &&
                            notificationsStore.hasNotificationPermission,
                        onChanged: (value) async {
                          await notificationsStore.changeNotification();
                        },
                      );
                    },
                  ),
                ],
              ),
              Text('Tema', style: appTheme.typography.poppins16px().copyWith(fontWeight: FontWeight.w600)),
              Observer(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 2,
                        child: Column(
                          spacing: 6.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'O tema atual é:',
                              style: appTheme.typography.poppins14px().copyWith(fontWeight: FontWeight.w500),
                            ),
                            Text(
                              coreStore.isLight ? 'Claro' : 'Escuro',
                              style: appTheme.typography.poppins14px(),
                            ),
                          ],
                        ),
                      ),

                      Switch.adaptive(
                        activeColor: appTheme.colors.grey66Color,
                        inactiveThumbColor: appTheme.colors.grey33Color,
                        inactiveThumbImage: AssetImage('assets/icons/png/theme/light_theme_icon.png'),
                        activeThumbImage: AssetImage('assets/icons/png/theme/dark_theme_icon.png'),
                        value: !coreStore.isLight,
                        onChanged: (value) => coreStore.changeTheme(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

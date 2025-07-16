import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/core/interactor/stories/core_store.dart';
import 'package:poke_app/app/core/ui/app_theme.dart';
import 'package:poke_app/app/modules/notifications/interactor/stories/notifications_store.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  final coreStore = Modular.get<CoreStore>();
  final notificationsStore = Modular.get<NotificationsStore>();

  @override
  void initState() {
    super.initState();
    coreStore.loadTheme();
    notificationsStore.loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        return MaterialApp.router(
          title: 'Poke App',
          themeMode: coreStore.isLight ? ThemeMode.light : ThemeMode.dark,
          theme: AppTheme().lightTheme,
          darkTheme: AppTheme().darkTheme,
          debugShowCheckedModeBanner: false,
          routerDelegate: Modular.routerDelegate,
          routeInformationParser: Modular.routeInformationParser,
        );
      },
    );
  }
}

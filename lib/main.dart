import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:poke_app/app/app_module.dart';
import 'package:poke_app/app/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  AwesomeNotifications().setListeners(onActionReceivedMethod: onActionReceivedMethod);
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}

Future<void> onActionReceivedMethod(ReceivedAction action) async {
  final route = action.payload?['route'];
  final pokemonId = action.payload?['pokemonId'];

  if (route != null) {
    Modular.to.pushNamed(route, arguments: pokemonId);
  }
}

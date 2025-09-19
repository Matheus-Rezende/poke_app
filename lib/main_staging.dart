import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/config/dependencies.dart';
import 'package:poke_app/main.dart';
import 'package:provider/provider.dart';

void main() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((log) {
    print('[${log.level}] - [${log.loggerName}] - [${log.message}]');
    if (log.stackTrace != null) {
      print('Error: ${log.error}');
      print('Stacktrace: ${log.stackTrace}');
    }
  });
  runApp(MultiProvider(providers: providersRemote, child: const MainApp()));
}

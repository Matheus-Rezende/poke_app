import 'package:flutter/material.dart';
import 'package:poke_app/config/dependencies.dart';
import 'package:poke_app/main.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: providersRemote, child: const MainApp()));
}

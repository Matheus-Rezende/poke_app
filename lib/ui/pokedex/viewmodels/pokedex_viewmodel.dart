import 'package:flutter/material.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexViewmodel extends ChangeNotifier {
  PokedexViewmodel({required PokedexRepository pokedexRepository})
    : _pokedexRepository = pokedexRepository {
    load = Command0(_load)..execute();
  }
  late Command0 load;
  final PokedexRepository _pokedexRepository;

  List<Pokemon> _pokedex = [];

  List<Pokemon> get pokedex => _pokedex;

  Future<Result> _load() async {
    await Future.delayed(const Duration(seconds: 1));
    final result = await _pokedexRepository.get();

    switch (result) {
      case Ok<List<Pokemon>>():
        _pokedex = result.value;
        notifyListeners();
        break;
      case Error():
        //TODO: Logging
        break;
    }
    return result;
  }
}

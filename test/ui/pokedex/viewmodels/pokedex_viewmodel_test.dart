import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_dev.dart';
import 'package:poke_app/ui/pokedex/viewmodels/pokedex_viewmodel.dart';

void main() {
  group('Should test pokedexViewmodel', () {
    late PokedexRepository pokedexRepository;
    late PokedexViewmodel pokedexViewmodel;

    setUp(() {
      pokedexRepository = PokedexRepositoryDev();
      pokedexViewmodel = PokedexViewmodel(pokedexRepository: pokedexRepository);
    });
    test('Verifying Viewmodel initial state', () {
      expect(pokedexViewmodel.pokedex, isNotEmpty);
    });

    test('test load pokedex', () async {
      await pokedexViewmodel.load.execute();

      expect(pokedexViewmodel.pokedex, isNotEmpty);
      expect(pokedexViewmodel.pokedex.first.name, contains('Bulbasaur'));
    });
  });
}

import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexRepositoryDev implements PokedexRepository {
  final List<PokemonSummary> _pokedex = List.generate(
    40,
    (index) => PokemonSummary(
      id: index + 1,
      name: 'bulbasaur',
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
      types: ['grass', 'poison'],
    ),
  );

  final PokemonDetail _pokemonDetail = PokemonDetail(
    id: 1,
    name: 'bulbasaur',
    types: ['grass', 'poison'],
    animatedGif:
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif',
    sound: 'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg',
  );

  @override
  Future<Result<List<PokemonSummary>>> get({required int limit, required int offset}) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // 2. Pega a "fatia" correta da lista usando skip e take.
      // Esta é a lógica principal da paginação.
      final page = _pokedex.skip(offset).take(limit).toList();

      // 3. Retorna a página como um resultado de sucesso.
      return Result.ok(page);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<PokemonDetail>> getPokemonByName(String name) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      return Result.ok(_pokemonDetail);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexRepositoryDev implements PokedexRepository {
  final List<Pokemon> _pokedex = List.generate(
    40,
    (index) => Pokemon(
      id: index + 1,
      name: 'Pokemon ${index + 1}',
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',
      types: ['grass', 'poison'],
    ),
  );

  @override
  Future<Result<List<Pokemon>>> get({required int limit, required int offset}) async {
    try {
      await Future.delayed(const Duration(seconds: 2));

      // 2. Pega a "fatia" correta da lista usando skip e take.
      // Esta é a lógica principal da paginação.
      final page = _pokedex.skip(offset).take(limit).toList();

      // 3. Retorna a página como um resultado de sucesso.
      return Result.ok(page);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}

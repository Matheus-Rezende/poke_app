// MUDANÇA 1: Removido 'ChangeNotifier'. O repositório não gerencia estado da UI.
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/data/services/api/api_client.dart';
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexRepositoryRemote implements PokedexRepository {
  PokedexRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;
  final ApiClient _apiClient;

  @override
  Future<Result<List<Pokemon>>> get({required int limit, required int offset}) async {
    try {
      final result = await _apiClient.getPokemons(limit: limit, offset: offset);

      switch (result) {
        case Ok<List<Pokemon>>():
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}

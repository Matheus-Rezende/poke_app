import 'package:poke_app/domain/models/pokemons/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

abstract class PokedexRepository {
  Future<Result<List<PokemonSummary>>> getPokemons({required int limit, required int offset});
}

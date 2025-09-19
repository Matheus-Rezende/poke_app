import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

abstract class PokedexRepository {
  Future<Result<List<PokemonSummary>>> get({required int limit, required int offset});
  Future<Result<PokemonDetail>> getPokemonByName(String name);
}

import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/result/result.dart';

abstract class PokedexRepository {
  Future<Result<List<Pokemon>>> get();
}

import 'package:dartz/dartz.dart';

abstract interface class PokemonTypesRepository {
  Future<Either<String, List<String>>> fetchPokemonTypesById({required int id});
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/pokemons_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';

class PokemonsRepositoryImpl implements PokemonsRepository {
  final HttpService http;

  PokemonsRepositoryImpl({required this.http});

  @override
  Future<Either<ErrorPokemonState, SuccessPokemonState>> fetchPokemons({
    int limit = 20,
    required int offset,
  }) async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}pokemon?limit=$limit&offset=$offset')
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          List<PokemonsModel> pokemons = (body['results'] as List)
              .map((pokemon) => PokemonsModel.fromJson(pokemon))
              .toList();

          // Realiza as requisições dos detalhes em paralelo
          await Future.wait(
            pokemons.map((pokemon) async {
              final detailsResponse = await http.get(url: pokemon.url ?? '');

              if (detailsResponse.statusCode == 200) {
                final detailsBody = json.decode(detailsResponse.body);

                final typesList = (detailsBody['types'] as List)
                    .map((typeInfo) => typeInfo['type']['name'] as String)
                    .map((en) => pokemonTypeTranslation[en] ?? en)
                    .toList();

                pokemon.types = typesList;
              }
            }),
          );

          return Right(SuccessPokemonState(pokemons: pokemons));
        } else {
          return Left(ErrorPokemonState(message: 'Não conseguimos carregar os Pokémons'));
        }
      } else {
        return Left(ErrorPokemonState(message: 'Aconteceu um erro!'));
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonState(message: Constants.timeoutMessage()));
    }
  }
}

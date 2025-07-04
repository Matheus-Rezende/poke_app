import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_search_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/search/search_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_search_state.dart';

class SearchPokemonRepositoryImpl implements SearchPokemonRepository {
  final HttpService http;

  SearchPokemonRepositoryImpl({required this.http});

  @override
  Future<Either<ErrorPokemonSearchState, SuccessPokemonSearchState>> searchPokemon({
    required String pokemonName,
  }) async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}pokemon/$pokemonName')
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          PokemonSearchModel pokemon = PokemonSearchModel.fromJson(body);

          final typesList = (body['types'] as List)
              .map((typeInfo) => typeInfo['type']['name'] as String)
              .map((en) => pokemonTypeTranslation[en] ?? en)
              .toList();

          pokemon.types = typesList;

          return Right(SuccessPokemonSearchState(pokemon: pokemon));
        } else {
          return Left(ErrorPokemonSearchState(message: 'Não conseguimos carregar o Pokémon pesquisado'));
        }
      } else {
        return Left(
          ErrorPokemonSearchState(message: 'O Pokémon pesquisado não existe ou foi digitado incorretamente.'),
        );
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonSearchState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonSearchState(message: Constants.timeoutMessage()));
    }
  }
}

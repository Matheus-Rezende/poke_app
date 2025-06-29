import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_model.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_search_model.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_type_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokedex_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_search_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

class PokedexRepositoryImpl implements PokedexRepository {
  final HttpService http;

  PokedexRepositoryImpl({required this.http});

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
          List<PokemonModel> pokemons = (body['results'] as List)
              .map((pokemon) => PokemonModel.fromJson(pokemon))
              .toList();

          // Realiza as requisições dos detalhes em paralelo
          await Future.wait(
            pokemons.map((pokemon) async {
              final detailsResponse = await http.get(url: pokemon.url);

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

  @override
  Future<Either<ErrorPokemonTypeState, SuccessPokemonTypeState>> fetchTypePokemons({
    required String pokemonType,
  }) async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}type/$pokemonType')
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          List<PokemonTypeModel> pokemons = (body['pokemon'] as List)
              .map((pokemon) => PokemonTypeModel.fromJson(pokemon))
              .toList();

          // Realiza as requisições dos detalhes em paralelo
          await Future.wait(
            pokemons.map((pokemon) async {
              final detailsResponse = await http.get(url: pokemon.url);

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

          return Right(SuccessPokemonTypeState(pokemons: pokemons));
        } else {
          return Left(ErrorPokemonTypeState(message: 'Não conseguimos carregar os Pokémons'));
        }
      } else {
        return Left(ErrorPokemonTypeState(message: 'Aconteceu um erro!'));
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonTypeState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonTypeState(message: Constants.timeoutMessage()));
    }
  }
}

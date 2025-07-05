import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_type_damage_model.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_types/types_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_damage_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_type_state.dart';

class TypesPokemonRepositoryImpl implements TypesPokemonRepository {
  final HttpService http;

  TypesPokemonRepositoryImpl({required this.http});

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
          List<PokemonsModel> pokemons = (body['pokemon'] as List)
              .map((pokemon) => PokemonsModel.fromJson(pokemon))
              .toList();

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

  @override
  Future<Either<ErrorPokemonTypeDamageState, SuccessPokemonTypeDamageState>> fetchPokemonTypeDamageByUrl({
    required String url,
  }) async {
    try {
      final response = await http.get(url: url).timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          PokemonTypeDamageModel typeDamage = PokemonTypeDamageModel.fromJson(body['damage_relations']);

          return Right(SuccessPokemonTypeDamageState(typeDamage: typeDamage));
        } else {
          return Left(
            ErrorPokemonTypeDamageState(message: 'Não conseguimos carregar os detalhes do Pokémon'),
          );
        }
      } else {
        return Left(ErrorPokemonTypeDamageState(message: 'Algo está errado'));
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonTypeDamageState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonTypeDamageState(message: Constants.timeoutMessage()));
    }
  }
}

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/core/interactor/utils/localization_utils.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_description_model.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_details_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_informations/informations_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_description_state.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_details_state.dart';

class InformationsPokemonRepositoryImpl implements InformationsPokemonRepository {
  final HttpService http;

  InformationsPokemonRepositoryImpl({required this.http});

  @override
  Future<Either<ErrorPokemonDetailsState, SuccessPokemonDetailsState>> fetchPokemonDetails({
    required String pokemon,
  }) async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}pokemon/$pokemon')
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          PokemonDetailsModel pokemon = PokemonDetailsModel.fromJson(body);

          return Right(SuccessPokemonDetailsState(pokemon: pokemon));
        } else {
          return Left(ErrorPokemonDetailsState(message: 'Não conseguimos carregar os detalhes do Pokémon'));
        }
      } else {
        return Left(ErrorPokemonDetailsState(message: 'Algo está errado'));
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonDetailsState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonDetailsState(message: Constants.timeoutMessage()));
    }
  }

  @override
  Future<Either<ErrorPokemonDescriptionState, SuccessPokemonDescriptionState>> fetchPokemonDescription({
    required String pokemon,
  }) async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}pokemon-species/$pokemon')
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          final flavorText = localizationUtils(data: body['flavor_text_entries'], fieldName: 'flavor_text');
          final evolutionChainUrl = body['evolution_chain']?['url'] ?? '';
          PokemonDescriptionModel description = PokemonDescriptionModel.fromJson({
            'flavor_text': flavorText,
            'gender_rate': body['gender_rate'],
            'evolution_chain_url': evolutionChainUrl,
          });

          return Right(SuccessPokemonDescriptionState(description: description));
        } else {
          return Left(
            ErrorPokemonDescriptionState(message: 'Não conseguimos carregar a descrição do Pokémon'),
          );
        }
      } else {
        return Left(ErrorPokemonDescriptionState(message: 'Sem descrição'));
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonDescriptionState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonDescriptionState(message: Constants.timeoutMessage()));
    }
  }
}

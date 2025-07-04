import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemon_details/pokemon_evolution_stage_model.dart';
import 'package:poke_app/app/modules/pokedex/interactor/repositories/pokemons/details/pokemon_evolutions/evolutions_pokemon_repository.dart';
import 'package:poke_app/app/modules/pokedex/interactor/states/pokemon_evolution_stage_state.dart';

class EvolutionsPokemonRepositoryImpl implements EvolutionsPokemonRepository {
  final HttpService http;

  EvolutionsPokemonRepositoryImpl({required this.http});

  @override
  Future<Either<ErrorPokemonEvolutionStageState, SuccessPokemonEvolutionStageState>>
  fetchPokemonPokemonEvolutionsByUrl({required String url}) async {
    try {
      final response = await http.get(url: url).timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'];
        if (contentType != null && contentType.contains('application/json')) {
          final body = json.decode(utf8.decode(response.bodyBytes));

          if (body.isNotEmpty) {
            final chain = body['chain'];
            List<PokemonEvolutionStageModel> stages = [];

            void parseChain(dynamic node) {
              stages.add(PokemonEvolutionStageModel.fromJson(node));
              for (final next in node['evolves_to']) {
                parseChain(next);
              }
            }

            parseChain(chain);

            return Right(SuccessPokemonEvolutionStageState(evolutions: stages));
          } else {
            return Left(
              ErrorPokemonEvolutionStageState(message: 'Não conseguimos carregar as evoluções do Pokémon'),
            );
          }
        } else {
          return Left(ErrorPokemonEvolutionStageState(message: 'Resposta não está em formato JSON'));
        }
      } else {
        return Left(ErrorPokemonEvolutionStageState(message: 'Erro HTTP: ${response.statusCode}'));
      }
    } on HttpException catch (e) {
      return Left(ErrorPokemonEvolutionStageState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorPokemonEvolutionStageState(message: Constants.timeoutMessage()));
    } on FormatException catch (e) {
      return Left(ErrorPokemonEvolutionStageState(message: 'Erro de formatação: ${e.message}'));
    } catch (e) {
      return Left(ErrorPokemonEvolutionStageState(message: 'Erro desconhecido: $e'));
    }
  }
}

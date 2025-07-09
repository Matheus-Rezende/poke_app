import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/modules/pokedex/data/models/pokemons_model.dart';
import 'package:poke_app/app/modules/regions/data/models/region_model.dart';
import 'package:poke_app/app/modules/regions/interactor/repositories/regions_repository.dart';
import 'package:poke_app/app/modules/regions/interactor/states/pokemons_region_state.dart';
import 'package:poke_app/app/modules/regions/interactor/states/regions_state.dart';

class RegionsRepositoryImpl implements RegionsRepository {
  final HttpService http;

  RegionsRepositoryImpl({required this.http});

  @override
  Future<Either<ErrorRegionsState, SuccessRegionsState>> fetchRegions() async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}region/', headers: {HttpHeaders.acceptHeader: 'application/json'})
          .timeout(Duration(seconds: Constants.timeoutSeconds()));
      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          List<RegionModel> regions = (body['results'] as List)
              .map((region) => RegionModel.fromJson(region))
              .toList();

          return Right(SuccessRegionsState(regions: regions));
        } else {
          return Left(ErrorRegionsState(message: 'Não conseguimos carregar as regiões'));
        }
      } else {
        return Left(ErrorRegionsState(message: 'Aconteceu um erro!'));
      }
    } on HttpException catch (e) {
      return Left(ErrorRegionsState(message: e.toString()));
    } on FormatException catch (e) {
      return Left(ErrorRegionsState(message: 'Erro de formatação: ${e.message}'));
    } on TimeoutException {
      return Left(ErrorRegionsState(message: Constants.timeoutMessage()));
    }
  }

  @override
  Future<Either<ErrorPokemonsRegionState, SuccessPokemonsRegionState>> fetchPokemonsByRegion({
    required String url,
  }) async {
    try {
      final regionResponse = await http
          .get(url: url, headers: {HttpHeaders.acceptHeader: 'application/json'})
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (regionResponse.statusCode != 200) {
        return Left(ErrorPokemonsRegionState(message: 'Erro ao buscar dados da região'));
      }

      final regionBody = json.decode(regionResponse.body);

      if (regionBody['pokedexes'] == null) {
        return Left(ErrorPokemonsRegionState(message: 'Não existem pokémons nessa região.'));
      }

      final pokedexUrl = regionBody['pokedexes'][0]['url'];

      final pokedexResponse = await http.get(
        url: pokedexUrl,
        headers: {HttpHeaders.acceptHeader: 'application/json'},
      );

      if (pokedexResponse.statusCode != 200) {
        return Left(ErrorPokemonsRegionState(message: 'Erro ao buscar dados da pokedex'));
      }

      final pokedexBody = json.decode(pokedexResponse.body);
      final pokemonEntries = pokedexBody['pokemon_entries'] as List;

      final pokemons = pokemonEntries
          .map((entry) => PokemonsModel.fromJson(entry['pokemon_species']))
          .toList();

      return Right(SuccessPokemonsRegionState(pokemons: pokemons));
    } on HttpException catch (e) {
      return Left(ErrorPokemonsRegionState(message: e.toString()));
    } on FormatException catch (e) {
      return Left(ErrorPokemonsRegionState(message: 'Erro de formatação: ${e.message}'));
    } on TimeoutException {
      return Left(ErrorPokemonsRegionState(message: Constants.timeoutMessage()));
    }
  }
}

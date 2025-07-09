import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/repositories/pokemon_types_repository.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/core/interactor/utils/translator/pokemon_type_translator.dart';

class PokemonTypesRepositoryImpl implements PokemonTypesRepository {
  final HttpService http;

  PokemonTypesRepositoryImpl({required this.http});

  @override
  Future<Either<String, List<String>>> fetchPokemonTypesById({required int id}) async {
    try {
      final response = await http
          .get(
            url: '${Constants.urlBase()}pokemon/$id/',
            headers: {HttpHeaders.acceptHeader: 'application/json'},
          )
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          final typesList = (body['types'] as List)
              .map((e) => e['type']['name'] as String)
              .map((en) => pokemonTypeTranslation[en] ?? en)
              .toList();
          return Right(typesList);
        } else {
          return Left(' Não conseguimos carregar os tipos');
        }
      } else {
        return Left('Aconteceu um erro');
      }
    } on HttpException catch (e) {
      return Left(e.toString());
    } on FormatException catch (e) {
      return Left(e.toString());
    } on TimeoutException {
      return Left(Constants.timeoutMessage());
    }
  }
}

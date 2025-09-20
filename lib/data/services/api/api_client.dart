import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class ApiClient {
  ApiClient({http.Client? clientHttpFactory})
    : _clientHttpFactory = clientHttpFactory ?? http.Client(),
      _baseUrl = 'pokeapi.co';

  final http.Client _clientHttpFactory;
  final String _baseUrl;

  Future<Result<List<PokemonSummary>>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    final client = _clientHttpFactory;

    try {
      final listUrl = Uri.https(_baseUrl, '/api/v2/pokemon', {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      final listResponse = await client.get(listUrl);

      if (listResponse.statusCode == 200) {
        final listJson = jsonDecode(listResponse.body);
        final List<dynamic> pokemonSummaries = listJson['results'];

        final List<Future<PokemonSummary>> futuresPokemons = pokemonSummaries.map((summary) async {
          final detailUrl = Uri.parse(summary['url']);
          final detailResponse = await client.get(detailUrl);
          if (detailResponse.statusCode == 200) {
            final detailJson = jsonDecode(detailResponse.body);
            return PokemonSummary.fromJson(detailJson);
          } else {
            return throw HttpException('Falha ao carregar detalhes para ${summary['name']}');
          }
        }).toList();
        final List<PokemonSummary> pokedex = await Future.wait(futuresPokemons, eagerError: true);

        return Result.ok(pokedex);
      } else {
        return Result.error(const HttpException('Falha ao carregar os pokémons.'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<PokemonDetail>> getPokemonDetailById(int id) async {
    final client = _clientHttpFactory;

    try {
      final pokemonUrl = Uri.https(_baseUrl, '/api/v2/pokemon/$id');
      final speciesUrl = Uri.https(_baseUrl, '/api/v2/pokemon-species/$id');

      final responses = await Future.wait([client.get(pokemonUrl), client.get(speciesUrl)]);

      if (responses[0].statusCode != 200) {
        return Result.error(
          HttpException(
            'Falha ao carregar dados essenciais do Pokémon: Status ${responses[0].statusCode}',
          ),
        );
      } else {
        final Map<String, dynamic> pokemonJson = jsonDecode(responses[0].body);

        Map<String, dynamic>? speciesJson;
        if (responses[1].statusCode == 200) {
          speciesJson = jsonDecode(responses[1].body);
        }
        final combinedJson = {...pokemonJson, if (speciesJson != null) 'species_data': speciesJson};

        final pokemon = PokemonDetail.fromJson(combinedJson);

        return Result.ok(pokemon);
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}

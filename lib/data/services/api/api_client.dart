import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:poke_app/domain/helpers/evolution_formatter.dart';
import 'package:poke_app/domain/models/pokemon/evolution_step.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class ApiClient {
  ApiClient({http.Client? clientHttpFactory})
    : _clientHttpFactory = clientHttpFactory ?? http.Client(),
      _baseUrl = 'pokeapi.co';

  final http.Client _clientHttpFactory;
  final String _baseUrl;

  final Map<String, List<String>> _typeWeaknessCache = {};
  final _log = Logger('ApiClient');

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
            _log.fine('Detalhes do pokémon ${summary['name']} carregados com sucesso!');
            return PokemonSummary.fromJson(detailJson);
          } else {
            _log.warning('Falha ao carregar detalhes para ${summary['name']}');
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

  Future<List<String>> _getTypeWeaknesses(String typeName) async {
    if (_typeWeaknessCache.containsKey(typeName)) {
      return _typeWeaknessCache[typeName]!;
    }
    final client = _clientHttpFactory;

    try {
      final url = Uri.https(_baseUrl, '/api/v2/type/$typeName');
      final response = await client.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final List<String> weaknesses = (json['damage_relations']['double_damage_from'] as List)
            .map((typeInfo) => typeInfo['name'] as String)
            .toList();

        _typeWeaknessCache[typeName] = weaknesses;
        return weaknesses;
      }
    } catch (error) {
      _log.warning('Erro ao buscar fraquezas para o tipo $typeName: $error');
    }
    return [];
  }

  Future<List<EvolutionStep>> _fetchEvolutionChain(String chainUrl) async {
    final client = _clientHttpFactory;
    try {
      final chainResponse = await client.get(Uri.parse(chainUrl));

      if (chainResponse.statusCode != 200) return [];

      final chainJson = jsonDecode(chainResponse.body);
      final List<Map<String, dynamic>> evoData = [];

      void traverseChain(Map<String, dynamic> chainLink) {
        final species = chainLink['species'];
        final urlParts = (species['url'] as String).split('/');
        final id = int.parse(urlParts[urlParts.length - 2]);
        String? trigger;
        if (chainLink['evolution_details'] != null &&
            (chainLink['evolution_details'] as List).isNotEmpty) {
          trigger = formatEvolutionTrigger(chainLink['evolution_details'][0]);
        }
        evoData.add({'id': id, 'name': species['name'], 'trigger': trigger});

        if (chainLink['evolves_to'] != null && (chainLink['evolves_to'] as List).isNotEmpty) {
          for (var nextLink in (chainLink['evolves_to'] as List)) {
            traverseChain(nextLink);
          }
        }
      }

      traverseChain(chainJson['chain']);

      final detailFutures = evoData.map((data) async {
        final detailUrl = Uri.https(_baseUrl, '/api/v2/pokemon/${data['id']}');
        final response = await client.get(detailUrl);
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);
          final List<String> typesList = (json['types'] as List)
              .map((typeInfo) => typeInfo['type']['name'] as String)
              .toList();
          return {
            ...data,
            'image':
                json['sprites']?['versions']?['generation-viii']?['icons']?['front_default'] ?? '',
            'types': typesList,
          };
        }
        return data
          ..['image'] = ''
          ..['types'] = <String>[];
      }).toList();

      final detailedEvoData = await Future.wait(detailFutures);

      return detailedEvoData
          .map(
            (data) => EvolutionStep(
              number: 'N°${data['id'].toString().padLeft(3, '0')}',
              name: data['name'],
              image: data['image'],
              types: data['types'],
              triggerDescription: data['trigger'],
            ),
          )
          .toList();
    } catch (error) {
      _log.warning('Erro ao buscar cadeia de evolução: $error');
      return [];
    }
  }

  Future<Result<PokemonDetail>> getPokemonDetailById(String id) async {
    final client = _clientHttpFactory;
    try {
      final pokemonUrl = Uri.https(_baseUrl, '/api/v2/pokemon/$id');
      final speciesUrl = Uri.https(_baseUrl, '/api/v2/pokemon-species/$id');

      final primaryResponses = await Future.wait([client.get(pokemonUrl), client.get(speciesUrl)]);

      if (primaryResponses[0].statusCode != 200) {
        return Result.error(
          HttpException(
            'Falha ao carregar dados do Pokémon: Status ${primaryResponses[0].statusCode}',
          ),
        );
      }

      final pokemonJson = jsonDecode(primaryResponses[0].body) as Map<String, dynamic>;
      final speciesJson = primaryResponses[1].statusCode == 200
          ? jsonDecode(primaryResponses[1].body) as Map<String, dynamic>
          : null;

      final types = (pokemonJson['types'] as List)
          .map((typeInfo) => typeInfo['type']['name'] as String)
          .toList();
      final weaknessFutures = types.map((typeName) => _getTypeWeaknesses(typeName)).toList();

      List<EvolutionStep> evolutionChain = [];
      if (speciesJson?['evolution_chain']?['url'] != null) {
        evolutionChain = await _fetchEvolutionChain(speciesJson!['evolution_chain']['url']);
      }

      final weaknessesResults = await Future.wait(weaknessFutures);
      final uniqueWeaknesses = weaknessesResults.expand((list) => list).toSet().toList();

      final combinedJson = {
        ...pokemonJson,
        if (speciesJson != null) 'species_data': speciesJson,
        'weaknesses_data': uniqueWeaknesses,
        'evolution_chain_data': evolutionChain,
      };

      final pokemon = PokemonDetail.fromJson(combinedJson);
      return Result.ok(pokemon);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<PokemonSummary>> searchPokemon(String query) async {
    final client = _clientHttpFactory;

    final formattedQuery = query.toLowerCase().trim();
    if (formattedQuery.isEmpty) {
      return Result.error(const HttpException('Termo de busca não pode ser vazio.'));
    }

    try {
      final url = Uri.https(_baseUrl, '/api/v2/pokemon/$formattedQuery');
      _log.fine('Buscando Pokémon: $url');

      final response = await client.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final pokemonSummary = PokemonSummary.fromJson(json);
        _log.fine('Pokémon "${pokemonSummary.name}" encontrado com sucesso.');
        return Result.ok(pokemonSummary);
      } else {
        if (response.statusCode == 404) {
          _log.warning('Pokémon "$formattedQuery" não encontrado.');
          return Result.error(HttpException('Pokémon "$formattedQuery" não encontrado.'));
        }
        _log.warning('Falha na busca: Status ${response.statusCode}');
        return Result.error(HttpException('Falha na busca: Status ${response.statusCode}'));
      }
    } on Exception catch (error, stackTrace) {
      _log.severe('Erro ao buscar o Pokémon "$formattedQuery"', error, stackTrace);
      return Result.error(error);
    }
  }

  Future<Result<List<PokemonSummary>>> getPokemonsByType({
    required String typeName,
    required int limit,
    required int offset,
  }) async {
    final lowerCaseTypeName = typeName.toLowerCase();
    final client = _clientHttpFactory;

    try {
      // ETAPA 1: Busca a lista COMPLETA de resumos (nomes/URLs) para o tipo.
      final typeUrl = Uri.https(_baseUrl, '/api/v2/type/$lowerCaseTypeName');
      _log.fine('Buscando resumos para o tipo $lowerCaseTypeName: $typeUrl');
      final typeResponse = await client.get(typeUrl);

      if (typeResponse.statusCode == 200) {
        final typeJson = jsonDecode(typeResponse.body);
        final List<dynamic> allPokemonSummaries = typeJson['pokemon'];
        _log.fine('Recebidos ${allPokemonSummaries.length} resumos do tipo $lowerCaseTypeName.');

        // ETAPA 2: Aplica a paginação na lista de resumos.
        final paginatedSummaries = allPokemonSummaries.skip(offset).take(limit).toList();

        if (paginatedSummaries.isEmpty) {
          _log.info(
            'Não há mais pokémons do tipo $lowerCaseTypeName para paginar (offset: $offset).',
          );
          return Result.ok([]); // Retorna lista vazia se a página estiver vazia.
        }
        _log.fine(
          'Processando ${paginatedSummaries.length} pokémons para a página atual (offset: $offset).',
        );

        // ETAPA 3: Busca os detalhes APENAS para a página atual, em paralelo.
        final List<Future<PokemonSummary>> futuresPokemons = paginatedSummaries.map((
          pokemonEntry,
        ) async {
          final summary = pokemonEntry['pokemon'];
          final detailUrl = Uri.parse(summary['url']);
          final detailResponse = await client.get(detailUrl);
          if (detailResponse.statusCode == 200) {
            final detailJson = jsonDecode(detailResponse.body);
            _log.finer('Detalhes carregados para ${summary['name']} (Tipo: $lowerCaseTypeName)');
            return PokemonSummary.fromJson(detailJson);
          } else {
            _log.warning(
              'Falha ao carregar detalhes para ${summary['name']} (Tipo: $lowerCaseTypeName): ${detailResponse.statusCode}',
            );
            throw HttpException('Falha ao carregar detalhes para ${summary['name']}');
          }
        }).toList();

        // Aguarda todos os detalhes da PÁGINA ATUAL serem carregados
        final List<PokemonSummary> pokedexPage = await Future.wait(
          futuresPokemons,
          eagerError: true,
        );
        _log.info(
          'Página (offset: $offset) de ${pokedexPage.length} pokémons do tipo $lowerCaseTypeName carregada com sucesso.',
        );
        return Result.ok(pokedexPage); // Retorna apenas a página processada
      } else {
        _log.severe(
          'Falha ao carregar dados do tipo $lowerCaseTypeName: ${typeResponse.statusCode}',
        );
        return Result.error(
          HttpException('Falha ao carregar dados do tipo: ${typeResponse.statusCode}'),
        );
      }
    } on Exception catch (error, stackTrace) {
      _log.severe('Erro ao buscar pokémons por tipo $lowerCaseTypeName', error, stackTrace);
      return Result.error(error);
    }
  }
}

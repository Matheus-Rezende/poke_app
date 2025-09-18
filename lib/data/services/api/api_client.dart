import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/result/result.dart';

class ApiClient {
  ApiClient({http.Client? clientHttpFactory})
    : _clientHttpFactory = clientHttpFactory ?? http.Client(),
      _baseUrl = 'pokeapi.co';

  final http.Client _clientHttpFactory;
  final String _baseUrl;

  Future<Result<List<Pokemon>>> getPokemons({required int limit, required int offset}) async {
    final client = _clientHttpFactory;

    try {
      final listUrl = Uri.https(_baseUrl, '/api/v2/pokemon', {
        'limit': limit.toString(),
        'offset': offset.toString(),
      });

      final listResponse = await client.get(listUrl);

      if (listResponse.statusCode != 200) {
        throw HttpException('Falha ao carregar a lista de Pokémon: ${listResponse.statusCode}');
      }

      final listJson = jsonDecode(listResponse.body);
      final List<dynamic> pokemonSummaries = listJson['results'];

      // ETAPA 2: Buscar os detalhes de cada Pokémon em paralelo para eficiência.
      final List<Future<Pokemon>> futuresPokemons = pokemonSummaries.map((summary) async {
        final detailUrl = Uri.parse(summary['url']);
        final detailResponse = await client.get(detailUrl);
        if (detailResponse.statusCode == 200) {
          final detailJson = jsonDecode(detailResponse.body);
          return Pokemon.fromJson(detailJson);
        } else {
          // Lança um erro específico para esta falha, que será capturado pelo Future.wait
          throw HttpException('Falha ao carregar detalhes para ${summary['name']}');
        }
      }).toList();

      // Aguarda a conclusão de todas as chamadas de detalhes.
      // 'eagerError: true' faz com que ele pare na primeira falha, se houver.
      final List<Pokemon> pokedex = await Future.wait(futuresPokemons, eagerError: true);

      return Result.ok(pokedex);
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}

import 'dart:convert';
import 'package:logging/logging.dart';
import 'package:poke_app/data/services/http_client_service.dart';
import 'package:poke_app/domain/models/regions/region_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class RegionRemoteDataSource {
  final HttpClientService _httpClient;
  final _log = Logger('RegionRemoteDataSource');

  RegionRemoteDataSource(this._httpClient);

  Future<Result<List<Map<String, dynamic>>>> getRegions() async {
    try {
      final response = await _httpClient.get('/api/v2/region');

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final results = json['results'] as List<dynamic>;

        // Mantendo o retorno exato do seu código original (List<Map>)
        return Result.ok(List<Map<String, dynamic>>.from(results));
      } else {
        _log.warning('Falha ao buscar regiões. Código: ${response.statusCode}');
        return Result.error(Exception('Falha ao buscar regiões.'));
      }
    } catch (error) {
      _log.severe('Erro ao buscar regiões: $error');
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }

  Future<Result<RegionSummary>> getRegionDetails(String url) async {
    try {
      // Aqui precisamos de um pequeno ajuste, pois a URL vem completa da API
      // Mas nosso NetworkClient espera um path relativo.
      // Podemos extrair o path da URL ou fazer o client aceitar URL completa.
      // Para manter simples e robusto, vamos extrair o path.
      final uri = Uri.parse(url);
      final path = uri.path;

      final response = await _httpClient.get(path);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;

        final generationName = (json['main_generation']?['name'] as String?) ?? '';
        final regionName = json['name'] as String? ?? '';

        return Result.ok(RegionSummary(generationName: generationName, regionName: regionName));
      } else {
        return Result.error(Exception('Falha ao buscar detalhes da região: $url'));
      }
    } catch (error) {
      _log.warning('Erro ao buscar detalhes da região: $error');
      return Result.error(error is Exception ? error : Exception(error.toString()));
    }
  }
}

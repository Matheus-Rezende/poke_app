import 'package:logging/logging.dart';
import 'package:poke_app/data/repositories/regions/regions_repository.dart';
import 'package:poke_app/data/services/api/api_client.dart';
import 'package:poke_app/data/services/api/model/regions/pokemon_region_api_model.dart';
import 'package:poke_app/domain/models/regions/region_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class RegionsRepositoryRemote implements RegionsRepository {
  RegionsRepositoryRemote({required ApiClient apiClient}) : _apiClient = apiClient;

  final ApiClient _apiClient;
  final _log = Logger('RegionsRepositoryRemote');

  @override
  Future<Result<List<RegionSummary>>> getRegions() async {
    try {
      final regionsResult = await _apiClient.getRegions();

      switch (regionsResult) {
        case Error<List<Map<String, dynamic>>>():
          return Result.error(regionsResult.error);

        case Ok<List<Map<String, dynamic>>>():
      }
      final regionsList = regionsResult.asOk.value;

      final futures = regionsList.map((region) async {
        final url = region['url'] as String;
        final regionDetails = await _apiClient.getRegionDetails(url);
        switch (regionDetails) {
          case Error<PokemonRegionApiModel>():
            _log.warning('Erro ao buscar detalhes de ${region['name']}');
            return null;
          case Ok<PokemonRegionApiModel>():
            final details = regionDetails.value;
            return RegionSummary(
              regionName: details.regionName,
              generationName: details.generationName,
            );
        }
      });

      final regionSummaries = (await Future.wait(futures)).whereType<RegionSummary>().toList();

      return Result.ok(regionSummaries);
    } on Exception catch (error) {
      _log.severe('Erro no repositório de regiões: $error');
      return Result.error(error);
    }
  }
}

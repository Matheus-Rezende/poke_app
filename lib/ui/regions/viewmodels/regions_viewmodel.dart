import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:poke_app/data/repositories/regions/regions_repository.dart';
import 'package:poke_app/domain/models/regions/region_summary.dart';
import 'package:poke_app/utils/commands/commands.dart';
import 'package:poke_app/utils/result/result.dart';

class RegionsViewmodel extends ChangeNotifier {
  RegionsViewmodel({required RegionsRepository regionsRepository})
    : _regionsRepository = regionsRepository {
    load = Command0(_load)..execute();
  }

  final RegionsRepository _regionsRepository;

  List<RegionSummary> _regions = [];
  List<RegionSummary> get regions => _regions;

  late final Command0<List<RegionSummary>> load;

  final _log = Logger('RegionsViewmodel');

  int _romanGenerationToInt(String generationName) {
    final roman = generationName.replaceAll('generation-', '').toUpperCase();
    const map = {'I': 1, 'II': 2, 'III': 3, 'IV': 4, 'V': 5, 'VI': 6, 'VII': 7, 'VIII': 8, 'IX': 9};
    return map[roman] ?? 0;
  }

  Future<Result<List<RegionSummary>>> _load() async {
    try {
      final result = await _regionsRepository.getRegions();

      switch (result) {
        case Ok<List<RegionSummary>>():
          _regions = result.value.map((region) {
            final generation = _romanGenerationToInt(region.generationName);
            return region.copyWith(generationName: generation.toString());
          }).toList();

          _log.fine('Regiões carregados com sucesso!');
          return Result.ok(result.value);
        default:
          return result;
      }
    } on Exception catch (error, stacktrace) {
      _log.warning('Falha ao carregar as regiões:', error, stacktrace);
      return Result.error(error);
    } finally {
      notifyListeners();
    }
  }
}

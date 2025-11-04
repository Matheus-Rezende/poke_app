import 'package:poke_app/domain/models/regions/region_summary.dart';
import 'package:poke_app/utils/result/result.dart';

abstract class RegionsRepository {
  Future<Result<List<RegionSummary>>> getRegions();
}

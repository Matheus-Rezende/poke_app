import 'package:freezed_annotation/freezed_annotation.dart';

part 'region_summary.freezed.dart';
part 'region_summary.g.dart';

@freezed
abstract class RegionSummary with _$RegionSummary {
  const factory RegionSummary({required String generationName, required String regionName}) =
      _RegionSummary;

  factory RegionSummary.fromJson(Map<String, dynamic> json) => _$RegionSummaryFromJson(json);
}

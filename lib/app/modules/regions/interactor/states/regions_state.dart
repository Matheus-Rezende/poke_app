import 'package:poke_app/app/modules/regions/data/models/region_model.dart';

sealed class RegionsState {
  final List<RegionModel> regions;
  RegionsState({required this.regions});

  InitRegionsState init() {
    return InitRegionsState();
  }

  ErrorRegionsState error({required String message}) {
    return ErrorRegionsState(message: message);
  }

  SuccessRegionsState success({List<RegionModel>? regions}) {
    return SuccessRegionsState(regions: regions ?? this.regions);
  }

  LoadingRegionsState loading() {
    return LoadingRegionsState();
  }
}

class SuccessRegionsState extends RegionsState {
  SuccessRegionsState({required super.regions});
}

class LoadingRegionsState extends RegionsState {
  LoadingRegionsState() : super(regions: []);
}

class InitRegionsState extends RegionsState {
  InitRegionsState() : super(regions: []);
}

class ErrorRegionsState extends RegionsState {
  final String message;
  ErrorRegionsState({required this.message}) : super(regions: []);
}

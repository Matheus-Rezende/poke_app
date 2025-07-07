import 'package:dartz/dartz.dart';
import 'package:poke_app/app/modules/regions/interactor/states/regions_state.dart';

abstract interface class RegionsRepository {
  Future<Either<ErrorRegionsState, SuccessRegionsState>> fetchRegions();
}

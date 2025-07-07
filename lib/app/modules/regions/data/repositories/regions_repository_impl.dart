import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/app/core/data/services/http/http_service.dart';
import 'package:poke_app/app/core/interactor/utils/constants/constants.dart';
import 'package:poke_app/app/modules/regions/data/models/region_model.dart';
import 'package:poke_app/app/modules/regions/interactor/repositories/regions_repository.dart';
import 'package:poke_app/app/modules/regions/interactor/states/regions_state.dart';

class RegionsRepositoryImpl implements RegionsRepository {
  final HttpService http;

  RegionsRepositoryImpl({required this.http});

  @override
  Future<Either<ErrorRegionsState, SuccessRegionsState>> fetchRegions() async {
    try {
      final response = await http
          .get(url: '${Constants.urlBase()}region/', headers: {HttpHeaders.acceptHeader: 'application/json'})
          .timeout(Duration(seconds: Constants.timeoutSeconds()));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        if (body.isNotEmpty) {
          List<RegionModel> regions = (body['results'] as List)
              .map((region) => RegionModel.fromJson(region))
              .toList();

          return Right(SuccessRegionsState(regions: regions));
        } else {
          return Left(ErrorRegionsState(message: 'Não conseguimos carregar as regiões'));
        }
      } else {
        return Left(ErrorRegionsState(message: 'Aconteceu um erro!'));
      }
    } on HttpException catch (e) {
      return Left(ErrorRegionsState(message: e.toString()));
    } on TimeoutException {
      return Left(ErrorRegionsState(message: Constants.timeoutMessage()));
    }
  }
}

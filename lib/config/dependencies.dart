import 'package:poke_app/data/datasources/pokemon_remote_datasource.dart';
import 'package:poke_app/data/datasources/region_remote_datasource.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_dev.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_remote.dart';
import 'package:poke_app/data/repositories/regions/regions_repository.dart';
import 'package:poke_app/data/repositories/regions/regions_repository_remote.dart';
import 'package:poke_app/data/services/http_client_service.dart';
import 'package:poke_app/data/services/http_client_service_impl.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => HttpClientServiceImpl() as HttpClientService),
    Provider(create: (context) => PokemonRemoteDataSource(context.read())),
    Provider(create: (context) => RegionRemoteDataSource(context.read())),
    Provider(
      create: (context) => PokedexRepositoryRemote(dataSource: context.read()) as PokedexRepository,
    ),
    Provider(
      create: (context) => RegionsRepositoryRemote(dataSource: context.read()) as RegionsRepository,
    ),
  ];
}

List<SingleChildWidget> get providersLocal {
  return [Provider(create: (context) => PokedexRepositoryDev() as PokedexRepository)];
}

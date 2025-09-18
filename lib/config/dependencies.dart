import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_dev.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_remote.dart';
import 'package:poke_app/data/services/api/api_client.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> get providersRemote {
  return [
    Provider(create: (context) => ApiClient()),
    Provider(
      create: (context) => PokedexRepositoryRemote(apiClient: context.read()) as PokedexRepository,
    ),
  ];
}

List<SingleChildWidget> get providersLocal {
  return [Provider(create: (context) => PokedexRepositoryDev() as PokedexRepository)];
}

import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemons/evolution_step.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexRepositoryDev implements PokedexRepository {
  final List<PokemonSummary> _pokedex = List.generate(
    40,
    (index) => PokemonSummary(
      id: index + 1,
      name: 'bulbasaur',
      image:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png',

      types: ['grass', 'poison'],
    ),
  );

  final List<PokemonDetail> _pokemonsDetail = List.generate(
    40,
    (index) => PokemonDetail(
      id: index + 1,
      name: 'bulbasaur',
      description: 'Teste descrição',
      animatedImage:
          'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/${index + 1}.gif',
      sound:
          'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/${index + 1}.ogg',
      types: ['grass', 'poison'],
      height: 4,
      weight: 60,
      abilities: ['static', 'lightning-rod'],
      category: 'Mouse Pokémon',
      genderRate: 0,
      weaknesses: ['fire', 'ice'],
      evolutionChain: [
        EvolutionStep(
          number: 'N°${1.toString().padLeft(3, '0')}',
          name: 'Bulbasaur',
          image:
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-viii/icons/2.png',
          types: ['ice', 'fire'],
        ),
      ],
    ),
  );

  @override
  Future<Result<List<PokemonSummary>>> getPokemons({
    required int limit,
    required int offset,
  }) async {
    try {
      await Future.delayed(const Duration(seconds: 1));

      // 2. Pega a "fatia" correta da lista usando skip e take.
      // Esta é a lógica principal da paginação.
      final page = _pokedex.skip(offset).take(limit).toList();

      // 3. Retorna a página como um resultado de sucesso.
      return Result.ok(page);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<PokemonDetail>> getPokemonDetailById(String id) async {
    try {
      await Future.delayed(const Duration(seconds: 1));
      final pokemonDetail = _pokemonsDetail.where((pokemon) => pokemon.id.toString() == id).first;
      return Result.ok(pokemonDetail);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  @override
  Future<Result<PokemonSummary>> searchPokemon(String query) {
    // TODO: implement searchPokemon
    throw UnimplementedError();
  }

  @override
  Future<Result<List<PokemonSummary>>> getPokemonsByType({
    required String typeName,
    required int limit,
    required int offset,
  }) {
    // TODO: implement getPokemonsByType
    throw UnimplementedError();
  }
}

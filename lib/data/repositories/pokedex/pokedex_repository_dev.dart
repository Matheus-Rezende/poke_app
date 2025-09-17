import 'package:poke_app/data/repositories/pokedex/pokedex_repository.dart';
import 'package:poke_app/domain/models/pokemon/pokemon.dart';
import 'package:poke_app/utils/result/result.dart';

class PokedexRepositoryDev implements PokedexRepository {
  final List<Pokemon> _pokedex = [
    Pokemon(
      id: 1,
      name: 'Bulbasaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'Ivysaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'Ivysaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'Ivysaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'Ivysaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'Ivysaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'Ivysaur',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
      types: ['Grama', 'Venenoso'],
    ),
    Pokemon(
      id: 2,
      name: 'PikaPika',
      image: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png',
      types: ['Elétrico', 'Venenoso'],
    ),
  ];
  @override
  Future<Result<List<Pokemon>>> get() async {
    return Result.ok(_pokedex);
  }
}

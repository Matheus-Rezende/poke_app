import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:poke_app/data/repositories/pokedex/pokedex_repository_remote.dart';
import 'package:poke_app/data/services/api/api_client.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

import '../../../mock/pokedex.dart';

class MockApiClient extends Mock implements ApiClient {}

void main() {
  late PokedexRepositoryRemote pokedexRepository;
  late ApiClient apiClient;

  setUp(() {
    apiClient = MockApiClient();
    pokedexRepository = PokedexRepositoryRemote(apiClient: apiClient);
  });
  group('PokedexRepository test', () {
    test('get()', () async {
      // Arrange (Organização) - O que deve ser feito quando acontecer.
      when(
        () => apiClient.getPokemons(limit: 5, offset: 0),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetPokedex)));

      // Act (Ação) - A ação sendo feita.
      final result = await pokedexRepository.get(limit: 5, offset: 0);

      // Assert (Verificação) - Verifica se a ação saiu como o esperado.
      expect(result, isA<Ok<List<PokemonSummary>>>());
      expect(result.asOk.value.length, 5);
      expect(result.asOk.value, equals(mockGetPokedex));
    });
    test('getById()', () async {
      // Arrange (Organização) - O que deve ser feito quando acontecer.
      when(
        () => apiClient.getPokemonDetailById(any()),
      ).thenAnswer((invocation) => Future.value(Result.ok(mockGetById)));

      // Act (Ação) - A ação sendo feita.
      final firstCallResult = await pokedexRepository.getPokemonDetailById('1');
      final secondCallResult = await pokedexRepository.getPokemonDetailById('1');

      // Assert (Verificação) - Verifica se a ação saiu como o esperado.
      expect(firstCallResult, isA<Result<PokemonDetail>>());
      final firstCallPokemon = firstCallResult.asOk.value;
      expect(firstCallPokemon.id, 1);
      expect(firstCallPokemon.name, 'bulbasaur');
      expect(firstCallPokemon.sound, isA<String>());

      expect(secondCallResult, isA<Result<PokemonDetail>>());

      verify(() => apiClient.getPokemonDetailById(any())).called(2);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:poke_app/data/services/api/api_client.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemon/pokemon_summary.dart';
import 'package:poke_app/utils/result/result.dart';

import '../../../helpers/mock_helpers.dart';
import '../../../mock/http_client_mock.dart';
import '../../../mock/pokedex.dart';

void main() {
  late ApiClient apiClient;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    apiClient = ApiClient(clientHttpFactory: mockHttpClient);
  });
  group('Should test [ApiClient]', () {
    test('Should return Result Ok when GetPokemons()', () async {
      // Arrange
      final listUrl = Uri.https('pokeapi.co', '/api/v2/pokemon', {'limit': '2', 'offset': '0'});
      setUpMockGetRequest(client: mockHttpClient, url: listUrl, object: mockPokedexListResponse);

      final bulbasaurUrl = Uri.parse('https://pokeapi.co/api/v2/pokemon/1/');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: bulbasaurUrl,
        object: mockBulbasaurDetailResponse,
      );

      final ivysaurUrl = Uri.parse('https://pokeapi.co/api/v2/pokemon/2/');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: ivysaurUrl,
        object: mockIvysaurDetailResponse,
      );

      // Act
      final result = await apiClient.getPokemons(limit: 2, offset: 0);

      // Assert
      expect(result, isA<Ok<List<PokemonSummary>>>());
      final pokemons = result.asOk.value;
      expect(pokemons.length, 2);
      expect(pokemons[0].name, 'bulbasaur');
      expect(pokemons[1].name, 'ivysaur');
    });

    test('Should return Result Ok when GetPokemonById()', () async {
      final urlPokemonDetails = Uri.https('pokeapi.co', '/api/v2/pokemon/1');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlPokemonDetails,
        object: mockBulbasaurDetailResponse,
      );

      final urlSpeciesDetails = Uri.https('pokeapi.co', '/api/v2/pokemon-species/1');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlSpeciesDetails,
        object: mockBulbasaurSpeciesDetails,
      );

      final urlGrassWeaknesses = Uri.https('pokeapi.co', '/api/v2/type/grass');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlGrassWeaknesses,
        object: mockGrassWeaknesses,
      );
      final urlPoisonWeaknesses = Uri.https('pokeapi.co', '/api/v2/type/poison');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlPoisonWeaknesses,
        object: mockPoisonWeaknesses,
      );

      final urlEvolutions = Uri.https('pokeapi.co', '/api/v2/evolution-chain/1');
      setUpMockGetRequest(client: mockHttpClient, url: urlEvolutions, object: bulbasaurEvolution);

      final urlPokemonDetailsToEvolution = Uri.https('pokeapi.co', '/api/v2/pokemon/1');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlPokemonDetailsToEvolution,
        object: mockBulbasaurDetailResponse,
      );

      final urlSpeciesToEvolution = Uri.https('pokeapi.co', '/api/v2/pokemon-species/1');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlSpeciesToEvolution,
        object: mockBulbasaurSpeciesDetails,
      );

      final urlGrassWeaknessesToEvolution = Uri.https('pokeapi.co', '/api/v2/type/grass');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlGrassWeaknessesToEvolution,
        object: mockGrassWeaknesses,
      );
      final urlPoisonWeaknessesToEvolution = Uri.https('pokeapi.co', '/api/v2/type/poison');
      setUpMockGetRequest(
        client: mockHttpClient,
        url: urlPoisonWeaknessesToEvolution,
        object: mockPoisonWeaknesses,
      );
      final result = await apiClient.getPokemonDetailById('1');

      expect(result, isA<Result<PokemonDetail>>());
    });
  });
}

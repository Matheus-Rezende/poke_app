import 'package:poke_app/domain/models/pokemons/pokemon_detail.dart';
import 'package:poke_app/domain/models/pokemons/pokemon_summary.dart';

final List<PokemonSummary> mockGetPokedex = [
  PokemonSummary(
    id: 1,
    name: 'bulbasaur',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png',
    types: ['grass', 'poison'],
  ),
  PokemonSummary(
    id: 2,
    name: 'ivysaur',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png',
    types: ['grass', 'poison'],
  ),
  PokemonSummary(
    id: 3,
    name: 'venusaur',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png',
    types: ['grass', 'poison'],
  ),
  PokemonSummary(
    id: 4,
    name: 'charmander',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png',
    types: ['fire'],
  ),
  PokemonSummary(
    id: 5,
    name: 'charmeleon',
    imageUrl: 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png',
    types: ['fire'],
  ),
];

final PokemonDetail mockGetById = PokemonDetail(
  id: 1,
  name: 'bulbasaur',
  types: ['grass', 'poison'],
  animatedImage:
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/1.gif',
  sound: 'https://raw.githubusercontent.com/PokeAPI/cries/main/cries/pokemon/latest/1.ogg',
  description: 'Pokémon bravo',
  height: 80,
  weight: 40,
  category: 'Seed',
  abilities: ['Overgrow'],
  genderRate: 6,
  weaknesses: ['flying', 'poison'],
  evolutionChain: [],
);

final mockPokedexListResponse = {
  'count': 1302,
  'next': 'https://pokeapi.co/api/v2/pokemon?offset=2&limit=2',
  'previous': null,
  'results': [
    {'name': 'bulbasaur', 'url': 'https://pokeapi.co/api/v2/pokemon/1/'},
    {'name': 'ivysaur', 'url': 'https://pokeapi.co/api/v2/pokemon/2/'},
  ],
};

// Mock que simula a resposta de /pokemon/1/
final mockBulbasaurDetailResponse = {
  'id': 1,
  'name': 'bulbasaur',
  'sprites': {'front_default': 'url_da_imagem_bulbasaur.png'},
  'types': [
    {
      'type': {'name': 'grass'},
    },
    {
      'type': {'name': 'poison'},
    },
  ],
  'abilities': [
    {
      'ability': {'name': 'overgrow', 'url': 'https://pokeapi.co/api/v2/ability/65/'},
      'is_hidden': false,
      'slot': 1,
    },
    {
      'ability': {'name': 'chlorophyll', 'url': 'https://pokeapi.co/api/v2/ability/34/'},
      'is_hidden': true,
      'slot': 3,
    },
  ],
};

// Mock que simula a resposta de /pokemon/2/
final mockIvysaurDetailResponse = {
  'id': 2,
  'name': 'ivysaur',
  'sprites': {'front_default': 'url_da_imagem_ivysaur.png'},
  'types': [
    {
      'type': {'name': 'grass'},
    },
    {
      'type': {'name': 'poison'},
    },
  ],
  'abilities': [
    {
      'ability': {'name': 'overgrow', 'url': 'https://pokeapi.co/api/v2/ability/65/'},
      'is_hidden': false,
      'slot': 1,
    },
    {
      'ability': {'name': 'chlorophyll', 'url': 'https://pokeapi.co/api/v2/ability/34/'},
      'is_hidden': true,
      'slot': 3,
    },
  ],
};
final mockBulbasaurSpeciesDetails = {
  'species_data': {
    'flavor_text_entries': [
      {
        'flavor_text':
            'A strange seed was planted on its back at birth.The plant sprouts and grows with this POKéMON.',
        'language': {'name': 'en', 'url': 'https://pokeapi.co/api/v2/language/9/'},
        'version': {'name': 'red', 'url': 'https://pokeapi.co/api/v2/version/1/'},
      },
    ],
    'genera': [
      {
        'genus': 'Pokémon Seme',
        'language': {'name': 'it', 'url': 'https://pokeapi.co/api/v2/language/8/'},
      },
      {
        'genus': 'Seed Pokémon',
        'language': {'name': 'en', 'url': 'https://pokeapi.co/api/v2/language/9/'},
      },
      {
        'genus': 'たねポケモン',
        'language': {'name': 'ja', 'url': 'https://pokeapi.co/api/v2/language/11/'},
      },
      {
        'genus': '种子宝可梦',
        'language': {'name': 'zh-Hans', 'url': 'https://pokeapi.co/api/v2/language/12/'},
      },
    ],
    'gender_rate': 1,
    "evolution_chain": {"url": "https://pokeapi.co/api/v2/evolution-chain/1/"},
  },
};

final mockGrassWeaknesses = {
  "damage_relations": {
    "double_damage_from": [
      {"name": "flying", "url": "https://pokeapi.co/api/v2/type/3/"},
      {"name": "poison", "url": "https://pokeapi.co/api/v2/type/4/"},
      {"name": "bug", "url": "https://pokeapi.co/api/v2/type/7/"},
      {"name": "fire", "url": "https://pokeapi.co/api/v2/type/10/"},
      {"name": "ice", "url": "https://pokeapi.co/api/v2/type/15/"},
    ],
  },
};
final mockPoisonWeaknesses = {
  "damage_relations": {
    "double_damage_from": [
      {"name": "ground", "url": "https://pokeapi.co/api/v2/type/5/"},
      {"name": "psychic", "url": "https://pokeapi.co/api/v2/type/14/"},
    ],
  },
};

final bulbasaurEvolution = {
  "baby_trigger_item": null,
  "chain": {
    "evolution_details": [],
    "evolves_to": [
      {
        "evolution_details": [
          {
            "gender": null,
            "held_item": null,
            "item": null,
            "known_move": null,
            "known_move_type": null,
            "location": null,
            "min_affection": null,
            "min_beauty": null,
            "min_happiness": null,
            "min_level": 16,
            "needs_overworld_rain": false,
            "party_species": null,
            "party_type": null,
            "relative_physical_stats": null,
            "time_of_day": "",
            "trade_species": null,
            "trigger": {
              "name": "level-up",
              "url": "https://pokeapi.co/api/v2/evolution-trigger/1/",
            },
            "turn_upside_down": false,
          },
        ],
        "evolves_to": [
          {
            "evolution_details": [
              {
                "gender": null,
                "held_item": null,
                "item": null,
                "known_move": null,
                "known_move_type": null,
                "location": null,
                "min_affection": null,
                "min_beauty": null,
                "min_happiness": null,
                "min_level": 32,
                "needs_overworld_rain": false,
                "party_species": null,
                "party_type": null,
                "relative_physical_stats": null,
                "time_of_day": "",
                "trade_species": null,
                "trigger": {
                  "name": "level-up",
                  "url": "https://pokeapi.co/api/v2/evolution-trigger/1/",
                },
                "turn_upside_down": false,
              },
            ],
            "evolves_to": [],
            "is_baby": false,
            "species": {"name": "venusaur", "url": "https://pokeapi.co/api/v2/pokemon-species/3/"},
          },
        ],
        "is_baby": false,
        "species": {"name": "ivysaur", "url": "https://pokeapi.co/api/v2/pokemon-species/2/"},
      },
    ],
    "is_baby": false,
    "species": {"name": "bulbasaur", "url": "https://pokeapi.co/api/v2/pokemon-species/1/"},
  },
  "id": 1,
};

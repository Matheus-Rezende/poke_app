class PokemonEvolutionStageModel {
  final String name;
  final String evolutionTriggerText;

  PokemonEvolutionStageModel({required this.name, required this.evolutionTriggerText});

  factory PokemonEvolutionStageModel.fromJson(Map<String, dynamic> json) {
    final name = json['species']['name'] as String;

    String trigger = '';
    if (json['evolution_details'] != null && json['evolution_details'].isNotEmpty) {
      final detail = json['evolution_details'][0];

      if (detail['min_level'] != null) {
        trigger = 'Nível ${detail['min_level']}';
      } else if (detail['item'] != null) {
        trigger = 'Item: ${detail['item']['name']}';
      } else {
        trigger = 'Evolução especial';
      }
    } else {
      trigger = 'Inicial';
    }

    return PokemonEvolutionStageModel(name: name, evolutionTriggerText: trigger);
  }
}
